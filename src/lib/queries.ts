import { useQuery } from '@tanstack/react-query';
import { supabase, isSupabaseConfigured } from './supabase';
import { Dish, Location, DishLocation } from '../types';
import { MOCK_DISHES, MOCK_LOCATIONS, MOCK_DISH_LOCATIONS, LocationWithCoords } from './mockData';
import {
  findStationsByQuery,
  stationToLocation,
  getStationById,
  JAPAN_STATIONS,
} from './stationRegistry';
import { isCoordinatesOutsideJapan } from '../context/LocationContext';

export interface NearbyDish extends Dish {
  distance_km?: number;
  nearest_location_name?: string;
}

// Helper: Determine current calendar season in Japan
export function getCurrentSeason(): string {
  const month = new Date().getMonth() + 1; // 1-12
  if (month >= 3 && month <= 5) return 'Spring';
  if (month >= 6 && month <= 8) return 'Summer';
  if (month >= 9 && month <= 11) return 'Autumn';
  return 'Winter';
}

// Helper: Haversine distance formula in km
export function calculateDistanceKm(lat1: number, lon1: number, lat2: number, lon2: number): number {
  const R = 6371;
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const dLon = ((lon2 - lon1) * Math.PI) / 180;
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLon / 2) *
      Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return R * c;
}

// Helper: Robust Postgres & JSON array parser for tags, seasons, ingredients, etc.
export function parsePostgresArray(val: any): string[] {
  if (!val) return [];
  if (Array.isArray(val)) {
    const flattened: string[] = [];
    for (const item of val) {
      if (typeof item === 'string') {
        const trimmed = item.trim();
        if (
          (trimmed.startsWith('{') && trimmed.endsWith('}')) ||
          (trimmed.startsWith('[') && trimmed.endsWith(']'))
        ) {
          flattened.push(...parsePostgresArray(trimmed));
        } else if (trimmed) {
          const clean = trimmed.replace(/^["']|["']$/g, '').trim();
          if (clean) flattened.push(clean);
        }
      } else if (item) {
        flattened.push(String(item));
      }
    }
    return Array.from(new Set(flattened.filter(Boolean)));
  }

  if (typeof val === 'string') {
    const trimmed = val.trim();
    if (!trimmed || trimmed === '{}' || trimmed === '[]') return [];

    if (trimmed.startsWith('[') && trimmed.endsWith(']')) {
      try {
        const parsed = JSON.parse(trimmed);
        if (Array.isArray(parsed)) {
          return parsePostgresArray(parsed);
        }
      } catch {}
    }

    if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
      const inner = trimmed.slice(1, -1).trim();
      if (!inner) return [];
      const matches = inner.match(/(".*?"|[^",\s]+)(?=\s*,|\s*$)/g);
      if (matches && matches.length > 0) {
        return matches
          .map(s => s.replace(/^["']|["']$/g, '').trim())
          .filter(Boolean);
      }
      return inner
        .split(',')
        .map(s => s.replace(/^["']|["']$/g, '').trim())
        .filter(Boolean);
    }

    if (trimmed.includes('{') || trimmed.includes('}')) {
      const stripped = trimmed.replace(/[{}]/g, '').trim();
      return stripped
        .split(',')
        .map(s => s.replace(/^["']|["']$/g, '').trim())
        .filter(Boolean);
    }

    if (trimmed.includes(',')) {
      return trimmed
        .split(',')
        .map(s => s.replace(/^["']|["']$/g, '').trim())
        .filter(Boolean);
    }

    const clean = trimmed.replace(/^["']|["']$/g, '').trim();
    return clean ? [clean] : [];
  }

  return [];
}

export function normalizeDish(dish: Dish): Dish {
  if (!dish) return dish;
  return {
    ...dish,
    home_filter_tags: parsePostgresArray(dish.home_filter_tags),
    tags: parsePostgresArray(dish.tags),
    seasons: parsePostgresArray(dish.seasons),
  };
}

// Helper: Get local resolved location with coordinate fallback
function getLocalResolvedLocation(lat: number, lng: number): Location | null {
  // If coordinates are outside Japan anywhere in the world, return null
  if (isCoordinatesOutsideJapan(lat, lng)) {
    return null;
  }

  let nearestLoc: LocationWithCoords | null = null;
  let minDistance = Infinity;

  for (const loc of MOCK_LOCATIONS) {
    const dist = calculateDistanceKm(lat, lng, loc.lat, loc.lng);
    if (dist < minDistance) {
      minDistance = dist;
      nearestLoc = loc;
    }
  }

  // If outside Japan or > 65km from any mapped Japanese location, return null
  if (!nearestLoc || minDistance > 65) {
    return null;
  }

  // Sparse content fallback check
  const linkedCount = MOCK_DISH_LOCATIONS.filter(
    dl => dl.location_id === nearestLoc!.location_id && dl.link_status === 'Published'
  ).length;

  if (linkedCount < 4 && nearestLoc.parent_location_id) {
    const parentLoc = MOCK_LOCATIONS.find(l => l.location_id === nearestLoc!.parent_location_id);
    if (parentLoc) return parentLoc;
  }

  return nearestLoc;
}

// -------------------------------------------------------------
// 1. useResolvedLocation(lat, lng)
// -------------------------------------------------------------
export function useResolvedLocation(lat: number | null, lng: number | null) {
  return useQuery<Location | null>({
    queryKey: ['resolvedLocation', lat, lng],
    queryFn: async () => {
      if (lat === null || lng === null) return null;
      return getLocalResolvedLocation(lat, lng);
    },
    enabled: lat !== null && lng !== null,
    staleTime: 1000 * 60 * 10,
  });
}

// Helper: Check if a dish belongs to a target season (Spring, Summer, Autumn, Winter)
export function matchDishSeason(dish: Dish, targetSeason: string): boolean {
  if (!targetSeason) return false;
  const ts = targetSeason.trim().toLowerCase();

  // Check explicit season property (e.g. "Autumn", "Winter (November to February)")
  if (dish.season && typeof dish.season === 'string') {
    const sLower = dish.season.toLowerCase();
    if (sLower !== 'all year' && sLower !== 'n/a' && sLower !== '-') {
      if (sLower.includes(ts)) return true;
      if (ts === 'winter' && (sLower.includes('dec') || sLower.includes('jan') || sLower.includes('feb'))) return true;
    }
  }

  // Check seasons array
  if (dish.seasons && Array.isArray(dish.seasons)) {
    for (const s of dish.seasons) {
      if (!s) continue;
      const sLower = s.toLowerCase();
      if (sLower !== 'all year' && sLower !== 'n/a' && sLower !== '-') {
        if (sLower.includes(ts)) return true;
        if (ts === 'winter' && (sLower.includes('dec') || sLower.includes('jan') || sLower.includes('feb'))) return true;
      }
    }
  }

  return false;
}

// Helper: Match dish to active calendar season using In_season & season column
export function isDishInActiveSeason(dish: Dish, activeSeason: string): boolean {
  // If explicitly marked as not in season
  if (dish.in_season === false) return false;

  return matchDishSeason(dish, activeSeason);
}

// -------------------------------------------------------------
// 2. useDishesInPeakSeason(regionId?)
// -------------------------------------------------------------
export function useDishesInPeakSeason(regionId?: string | null) {
  const currentSeason = getCurrentSeason();

  return useQuery<Dish[]>({
    queryKey: ['dishesInPeakSeason', regionId, currentSeason],
    queryFn: async () => {
      let dishesToFilter: Dish[] = MOCK_DISHES;

      if (isSupabaseConfigured) {
        try {
          let query = supabase
            .from('dishes')
            .select('*')
            .eq('content_status', 'Published');

          if (regionId) query = query.eq('region_id', regionId);

          const { data } = await query;
          if (data && data.length > 0) {
            dishesToFilter = data as Dish[];
          }
        } catch {
          // fallback to MOCK_DISHES
        }
      }

      let filtered = dishesToFilter.filter(
        d => d.content_status === 'Published' && isDishInActiveSeason(d, currentSeason)
      );

      if (regionId) {
        const rLower = regionId.toLowerCase();
        filtered = filtered.filter(d => {
          if (!d.region_id) return false;
          const drLower = d.region_id.toLowerCase();
          if (rLower.startsWith('kyush') || rLower.startsWith('kyuush')) {
            return drLower.startsWith('kyush') || drLower.startsWith('kyuush');
          }
          return drLower === rLower;
        });
      }

      return filtered.map(normalizeDish);
    },
    staleTime: 1000 * 60 * 10,
  });
}

// -------------------------------------------------------------
// 3. useLocalSpecialities(locationId)
// -------------------------------------------------------------
export function useLocalSpecialities(locationId?: string | null) {
  return useQuery<Dish[]>({
    queryKey: ['localSpecialities', locationId],
    queryFn: async () => {
      if (!locationId) return [];

      if (!isSupabaseConfigured) {
        const matchingLinks = MOCK_DISH_LOCATIONS.filter(
          dl => dl.location_id === locationId && dl.link_status === 'Published'
        );
        const dishIds = new Set(matchingLinks.map(l => l.dish_id));
        const dishes = MOCK_DISHES.filter(d => d.content_status === 'Published' && dishIds.has(d.dish_id));
        const linkMap = new Map(matchingLinks.map(l => [l.dish_id, l]));

        const rankRel = (r: string) => (r === 'best-known' ? 1 : r === 'origin' ? 2 : 3);
        return dishes.map(normalizeDish).sort((a, b) => {
          const linkA = linkMap.get(a.dish_id);
          const linkB = linkMap.get(b.dish_id);
          const rankA = linkA ? rankRel(linkA.relationship) : 99;
          const rankB = linkB ? rankRel(linkB.relationship) : 99;
          if (rankA !== rankB) return rankA - rankB;
          return (linkA?.display_priority || 1) - (linkB?.display_priority || 1);
        });
      }

      try {
        const { data: links } = await supabase
          .from('dish_locations')
          .select('dish_id, relationship, display_priority')
          .eq('location_id', locationId)
          .eq('link_status', 'Published');

        if (links && links.length > 0) {
          const dishIds = links.map(l => l.dish_id);
          const { data: dishes } = await supabase
            .from('dishes')
            .select('*')
            .in('dish_id', dishIds)
            .eq('content_status', 'Published');

          if (dishes && dishes.length > 0) {
            const rankRel = (r: string) => (r === 'best-known' ? 1 : r === 'origin' ? 2 : 3);
            const linkMap = new Map(links.map(l => [l.dish_id, l]));

            return (dishes as Dish[]).map(normalizeDish).sort((a, b) => {
              const linkA = linkMap.get(a.dish_id);
              const linkB = linkMap.get(b.dish_id);
              const rankA = linkA ? rankRel(linkA.relationship) : 99;
              const rankB = linkB ? rankRel(linkB.relationship) : 99;
              if (rankA !== rankB) return rankA - rankB;
              return (linkA?.display_priority || 1) - (linkB?.display_priority || 1);
            });
          }
        }
      } catch {
        // fallback
      }

      const matchingLinks = MOCK_DISH_LOCATIONS.filter(
        dl => dl.location_id === locationId && dl.link_status === 'Published'
      );
      const dishIds = new Set(matchingLinks.map(l => l.dish_id));
      const dishes = MOCK_DISHES.filter(d => d.content_status === 'Published' && dishIds.has(d.dish_id));
      const linkMap = new Map(matchingLinks.map(l => [l.dish_id, l]));

      const rankRel = (r: string) => (r === 'best-known' ? 1 : r === 'origin' ? 2 : 3);
      return dishes.map(normalizeDish).sort((a, b) => {
        const linkA = linkMap.get(a.dish_id);
        const linkB = linkMap.get(b.dish_id);
        const rankA = linkA ? rankRel(linkA.relationship) : 99;
        const rankB = linkB ? rankRel(linkB.relationship) : 99;
        if (rankA !== rankB) return rankA - rankB;
        return (linkA?.display_priority || 1) - (linkB?.display_priority || 1);
      });
    },
    enabled: Boolean(locationId),
    staleTime: 1000 * 60 * 10,
  });
}

// -------------------------------------------------------------
// 4. useFeaturedDishes()
// -------------------------------------------------------------
export function useFeaturedDishes() {
  return useQuery<Dish[]>({
    queryKey: ['featuredDishes'],
    queryFn: async () => {
      if (!isSupabaseConfigured) {
        return MOCK_DISHES.filter(d => d.content_status === 'Published' && d.featured).map(normalizeDish);
      }

      try {
        const { data } = await supabase
          .from('dishes')
          .select('*')
          .eq('content_status', 'Published')
          .eq('featured', true);

        if (data && data.length > 0) return (data as Dish[]).map(normalizeDish);
      } catch {
        // fallback
      }
      return MOCK_DISHES.filter(d => d.content_status === 'Published' && d.featured).map(normalizeDish);
    },
    staleTime: 1000 * 60 * 10,
  });
}

// -------------------------------------------------------------
// 5. useDish(dishId)
// -------------------------------------------------------------
export function useDish(dishId?: string | null) {
  return useQuery<Dish | null>({
    queryKey: ['dish', dishId],
    queryFn: async () => {
      if (!dishId) return null;

      const mockMatch = MOCK_DISHES.find(d => d.dish_id === dishId) || null;

      if (isSupabaseConfigured) {
        try {
          const { data } = await supabase
            .from('dishes')
            .select('*')
            .eq('dish_id', dishId)
            .eq('content_status', 'Published')
            .single();

          if (data) {
            const dbDish = data as Dish;
            const mergedDish: Dish = {
              ...(mockMatch || {}),
              ...dbDish,
            };

            // Ensure rich fields are always populated if database row has empty/null arrays
            if ((!mergedDish.visual_cues || mergedDish.visual_cues.length === 0) && mockMatch?.visual_cues) {
              mergedDish.visual_cues = mockMatch.visual_cues;
            }
            if ((!mergedDish.key_ingredients || mergedDish.key_ingredients.length === 0) && mockMatch?.key_ingredients) {
              mergedDish.key_ingredients = mockMatch.key_ingredients;
            }
            if (!mergedDish.summary && mockMatch?.summary) {
              mergedDish.summary = mockMatch.summary;
            }
            if (!mergedDish.did_you_know && mockMatch?.did_you_know) {
              mergedDish.did_you_know = mockMatch.did_you_know;
            }
            if (!mergedDish.origin_history_preview && mockMatch?.origin_history_preview) {
              mergedDish.origin_history_preview = mockMatch.origin_history_preview;
            }
            if (!mergedDish.origin_history_full && mockMatch?.origin_history_full) {
              mergedDish.origin_history_full = mockMatch.origin_history_full;
            }
            if (!mergedDish.google_maps_query && mockMatch?.google_maps_query) {
              mergedDish.google_maps_query = mockMatch.google_maps_query;
            }

            return normalizeDish(mergedDish);
          }
        } catch {
          // fallback
        }
      }

      return mockMatch ? normalizeDish(mockMatch) : null;
    },
    enabled: Boolean(dishId),
    staleTime: 1000 * 60 * 10,
  });
}

// -------------------------------------------------------------
// 6. useSearch(query)
// -------------------------------------------------------------
export function useSearch(searchQuery: string) {
  const cleanQuery = searchQuery.trim().toLowerCase();

  return useQuery<{ dishes: Dish[]; locations: Location[] }>({
    queryKey: ['search', cleanQuery],
    queryFn: async () => {
      if (!cleanQuery) return { dishes: [], locations: [] };

      // Helper to search mock dataset with location & parent-ward hierarchy resolution
      const executeMockSearch = () => {
        // 1. Find matching stations from station registry
        const matchedStations = findStationsByQuery(searchQuery);
        const stationLocations = matchedStations.map(stationToLocation);

        // 2. Find matching locations from MOCK_LOCATIONS
        const matchedMockLocations = MOCK_LOCATIONS.filter(l =>
          l.content_status === 'Published' && (
            l.location_name.toLowerCase().includes(cleanQuery) ||
            (l.city && l.city.toLowerCase().includes(cleanQuery)) ||
            (l.food_focus && l.food_focus.toLowerCase().includes(cleanQuery)) ||
            (l.admin_note && l.admin_note.toLowerCase().includes(cleanQuery)) ||
            l.location_id.toLowerCase().includes(cleanQuery)
          )
        );

        // 3. Combine locations and prioritize exact or prefix matches
        const combinedLocations: Location[] = [...stationLocations];
        const seenLocIds = new Set<string>(stationLocations.map(l => l.location_id));

        matchedMockLocations.forEach(loc => {
          if (!seenLocIds.has(loc.location_id)) {
            combinedLocations.push(loc);
            seenLocIds.add(loc.location_id);
          }
        });

        // Sort locations: exact station/name matches first
        combinedLocations.sort((a, b) => {
          const aExact = a.location_name.toLowerCase() === cleanQuery || a.location_id.toLowerCase() === cleanQuery;
          const bExact = b.location_name.toLowerCase() === cleanQuery || b.location_id.toLowerCase() === cleanQuery;
          if (aExact && !bExact) return -1;
          if (!aExact && bExact) return 1;

          const aStarts = a.location_name.toLowerCase().startsWith(cleanQuery);
          const bStarts = b.location_name.toLowerCase().startsWith(cleanQuery);
          if (aStarts && !bStarts) return -1;
          if (!aStarts && bStarts) return 1;

          return 0;
        });

        // 4. Collect location IDs & their parent/child location IDs
        const locationIdsToMatch = new Set<string>();
        combinedLocations.forEach(loc => {
          locationIdsToMatch.add(loc.location_id);
          if (loc.parent_location_id) {
            locationIdsToMatch.add(loc.parent_location_id);
          }
        });

        // Also check if any location's parent is in matched list
        MOCK_LOCATIONS.forEach(loc => {
          if (loc.parent_location_id && locationIdsToMatch.has(loc.parent_location_id)) {
            locationIdsToMatch.add(loc.location_id);
          }
        });

        // 5. Find dishes linked to matched locations or their parent/child locations
        const locationLinkedDishIds = new Set<string>();
        MOCK_DISH_LOCATIONS.forEach(dl => {
          if (dl.link_status === 'Published' && locationIdsToMatch.has(dl.location_id)) {
            locationLinkedDishIds.add(dl.dish_id);
          }
        });

        // 6. Categorize and prioritize dishes
        const directNameDishes: Dish[] = [];
        const locationLinkedDishes: Dish[] = [];
        const contentMatchedDishes: Dish[] = [];
        const seenDishIds = new Set<string>();

        MOCK_DISHES.forEach(d => {
          if (d.content_status !== 'Published') return;

          const nameMatch = d.dish_name.toLowerCase().includes(cleanQuery) ||
            (d.japanese_name && d.japanese_name.includes(cleanQuery));

          const locMatch = locationLinkedDishIds.has(d.dish_id);

          const contentMatch = d.summary.toLowerCase().includes(cleanQuery) ||
            (d.season && d.season.toLowerCase().includes(cleanQuery)) ||
            (d.seasons && d.seasons.some(s => s.toLowerCase().includes(cleanQuery))) ||
            (d.tags && d.tags.some(t => t.toLowerCase().includes(cleanQuery))) ||
            (d.key_ingredients && d.key_ingredients.some(k => k.toLowerCase().includes(cleanQuery))) ||
            (d.origin_history_preview && d.origin_history_preview.toLowerCase().includes(cleanQuery));

          if (nameMatch) {
            directNameDishes.push(d);
            seenDishIds.add(d.dish_id);
          } else if (locMatch) {
            if (!seenDishIds.has(d.dish_id)) {
              locationLinkedDishes.push(d);
              seenDishIds.add(d.dish_id);
            }
          } else if (contentMatch) {
            if (!seenDishIds.has(d.dish_id)) {
              contentMatchedDishes.push(d);
              seenDishIds.add(d.dish_id);
            }
          }
        });

        const combinedDishes = [...directNameDishes, ...locationLinkedDishes, ...contentMatchedDishes];
        return { dishes: combinedDishes.map(normalizeDish), locations: combinedLocations };
      };

      if (!isSupabaseConfigured) {
        return executeMockSearch();
      }

      try {
        const { data: dbDishes } = await supabase
          .from('dishes')
          .select('*')
          .eq('content_status', 'Published')
          .or(`dish_name.ilike.%${cleanQuery}%,japanese_name.ilike.%${cleanQuery}%,summary.ilike.%${cleanQuery}%`);

        const { data: dbLocations } = await supabase
          .from('locations')
          .select('*')
          .eq('content_status', 'Published')
          .or(`location_name.ilike.%${cleanQuery}%,city.ilike.%${cleanQuery}%,food_focus.ilike.%${cleanQuery}%`);

        if (dbDishes && dbDishes.length > 0) {
          return {
            dishes: ((dbDishes || []) as Dish[]).map(normalizeDish),
            locations: (dbLocations || []) as Location[],
          };
        }
      } catch {
        // fallback to executeMockSearch
      }

      return executeMockSearch();
    },
    enabled: cleanQuery.length > 0,
    staleTime: 1000 * 60 * 5,
  });
}

// -------------------------------------------------------------
// 7. useSeasonalDishes(season, regionId?)
// -------------------------------------------------------------
export function useSeasonalDishes(season: string, regionId?: string | null) {
  return useQuery<Dish[]>({
    queryKey: ['seasonalDishes', season, regionId],
    queryFn: async () => {
      let dishesToFilter: Dish[] = MOCK_DISHES;

      if (isSupabaseConfigured) {
        try {
          let query = supabase
            .from('dishes')
            .select('*')
            .eq('content_status', 'Published');

          if (regionId) query = query.eq('region_id', regionId);

          const { data } = await query;
          if (data && data.length > 0) {
            dishesToFilter = data as Dish[];
          }
        } catch {
          // fallback to MOCK_DISHES
        }
      }

      let filtered = dishesToFilter.filter(
        d => d.content_status === 'Published' && matchDishSeason(d, season)
      );
      if (regionId) {
        const rLower = regionId.toLowerCase();
        filtered = filtered.filter(d => {
          if (!d.region_id) return false;
          const drLower = d.region_id.toLowerCase();
          if (rLower.startsWith('kyush') || rLower.startsWith('kyuush')) {
            return drLower.startsWith('kyush') || drLower.startsWith('kyuush');
          }
          return drLower === rLower;
        });
      }
      return filtered.map(normalizeDish);
    },
    staleTime: 1000 * 60 * 10,
  });
}

// -------------------------------------------------------------
// 8. useLocationDetail(locationId)
// -------------------------------------------------------------
export function useLocationDetail(locationId?: string | null) {
  return useQuery<{ location: Location; dishes: Dish[]; parentLocation?: Location | null } | null>({
    queryKey: ['locationDetail', locationId],
    queryFn: async () => {
      if (!locationId) return null;

      // Helper function to resolve mock location details with station support
      const resolveMockLocationDetail = () => {
        let loc = MOCK_LOCATIONS.find(l => l.location_id === locationId && l.content_status === 'Published');
        if (!loc) {
          const station = getStationById(locationId);
          if (station) {
            loc = stationToLocation(station);
          }
        }
        if (!loc) {
          loc = MOCK_LOCATIONS.find(l =>
            l.location_name.toLowerCase() === locationId.toLowerCase() ||
            l.location_id.toLowerCase().includes(locationId.toLowerCase())
          );
        }
        if (!loc) return null;

        const directLinks = MOCK_DISH_LOCATIONS.filter(dl => dl.location_id === loc!.location_id && dl.link_status === 'Published');
        const directDishIds = new Set(directLinks.map(l => l.dish_id));
        let dishesList = MOCK_DISHES.filter(d => d.content_status === 'Published' && directDishIds.has(d.dish_id));

        let parentLoc: Location | null = null;
        if (loc.parent_location_id) {
          parentLoc = MOCK_LOCATIONS.find(l => l.location_id === loc!.parent_location_id) || null;
          if (parentLoc) {
            const parentLinks = MOCK_DISH_LOCATIONS.filter(dl => dl.location_id === parentLoc!.location_id && dl.link_status === 'Published');
            const parentDishIds = new Set(parentLinks.map(l => l.dish_id));
            const parentDishes = MOCK_DISHES.filter(d => d.content_status === 'Published' && parentDishIds.has(d.dish_id));

            const existingIds = new Set(dishesList.map(d => d.dish_id));
            parentDishes.forEach(d => {
              if (!existingIds.has(d.dish_id)) dishesList.push(d);
            });
          }
        }

        return { location: loc, dishes: dishesList.map(normalizeDish), parentLocation: parentLoc };
      };

      if (!isSupabaseConfigured) {
        return resolveMockLocationDetail();
      }

      try {
        const { data: locationData } = await supabase
          .from('locations')
          .select('*')
          .eq('location_id', locationId)
          .eq('content_status', 'Published')
          .single();

        if (locationData) {
          const loc = locationData as Location;
          const { data: links } = await supabase
            .from('dish_locations')
            .select('dish_id, relationship, display_priority')
            .eq('location_id', locationId)
            .eq('link_status', 'Published');

          let directDishIds = links ? links.map(l => l.dish_id) : [];
          let dishesList: Dish[] = [];

          if (directDishIds.length > 0) {
            const { data: fetchedDishes } = await supabase
              .from('dishes')
              .select('*')
              .in('dish_id', directDishIds)
              .eq('content_status', 'Published');
            dishesList = (fetchedDishes || []) as Dish[];
          }

          let parentLoc: Location | null = null;
          if (dishesList.length < 4 && loc.parent_location_id) {
            const { data: pLoc } = await supabase
              .from('locations')
              .select('*')
              .eq('location_id', loc.parent_location_id)
              .single();
            parentLoc = pLoc as Location;

            if (parentLoc) {
              const { data: pLinks } = await supabase
                .from('dish_locations')
                .select('dish_id')
                .eq('location_id', parentLoc.location_id)
                .eq('link_status', 'Published');

              if (pLinks && pLinks.length > 0) {
                const parentDishIds = pLinks.map(l => l.dish_id);
                const { data: pDishes } = await supabase
                  .from('dishes')
                  .select('*')
                  .in('dish_id', parentDishIds)
                  .eq('content_status', 'Published');

                const existingIds = new Set(dishesList.map(d => d.dish_id));
                (pDishes || []).forEach(d => {
                  if (!existingIds.has(d.dish_id)) dishesList.push(d as Dish);
                });
              }
            }
          }

          return { location: loc, dishes: dishesList.map(normalizeDish), parentLocation: parentLoc };
        }
      } catch {
        // fallback
      }

      return resolveMockLocationDetail();
    },
    enabled: Boolean(locationId),
    staleTime: 1000 * 60 * 10,
  });
}

// -------------------------------------------------------------
// 9. useNearbyDishes(lat, lng) — Step 2: "Popular Nearby" distance-ranked query
// Expanding radius search (15km -> 40km -> 100km -> 250km)
// -------------------------------------------------------------
export function useNearbyDishes(lat: number | null, lng: number | null) {
  return useQuery<NearbyDish[]>({
    queryKey: ['nearbyDishes', lat, lng],
    queryFn: async () => {
      if (lat === null || lng === null || isNaN(lat) || isNaN(lng)) {
        return [];
      }

      // If outside Japan anywhere in the world, don't return false "nearby" Tokyo dishes
      if (isCoordinatesOutsideJapan(lat, lng)) {
        return [];
      }

      const targetLat = lat;
      const targetLng = lng;

      // 1. Try Supabase RPC get_nearby_dishes if configured
      if (isSupabaseConfigured) {
        try {
          const { data } = await supabase.rpc('get_nearby_dishes', {
            user_lat: targetLat,
            user_lng: targetLng,
          });
          if (data && data.length > 0) {
            return data as NearbyDish[];
          }
        } catch (err) {
          // RPC fallback
        }
      }

      // 2. Client / Mock fallback implementation of expanding radius search (15km -> 40km -> 100km -> 250km)
      const radii = [15, 40, 100, 250];
      let candidates: { dish: Dish; location: LocationWithCoords; link: DishLocation; distance: number }[] = [];

      for (const r of radii) {
        const found: { dish: Dish; location: LocationWithCoords; link: DishLocation; distance: number }[] = [];
        const foundDishIds = new Set<string>();

        for (const loc of MOCK_LOCATIONS) {
          if (loc.content_status !== 'Published') continue;
          const locLat = loc.lat ?? 35.6762;
          const locLng = loc.lng ?? 139.6503;
          const dist = calculateDistanceKm(targetLat, targetLng, locLat, locLng);

          if (dist <= r) {
            const links = MOCK_DISH_LOCATIONS.filter(
              dl => dl.location_id === loc.location_id && dl.link_status === 'Published'
            );

            for (const link of links) {
              const dish = MOCK_DISHES.find(d => d.dish_id === link.dish_id && d.content_status === 'Published');
              if (dish) {
                found.push({ dish, location: loc, link, distance: dist });
                foundDishIds.add(dish.dish_id);
              }
            }
          }
        }

        if (foundDishIds.size >= 6) {
          candidates = found;
          break;
        }
      }

      // If even 250km yields < 6 dishes, fallback to popular featured set
      if (candidates.length === 0) {
        candidates = MOCK_LOCATIONS.flatMap(loc => {
          const dist = calculateDistanceKm(targetLat, targetLng, loc.lat ?? 35.6762, loc.lng ?? 139.6503);
          return MOCK_DISH_LOCATIONS
            .filter(dl => dl.location_id === loc.location_id && dl.link_status === 'Published')
            .map(link => {
              const dish = MOCK_DISHES.find(d => d.dish_id === link.dish_id && d.content_status === 'Published');
              return dish ? { dish, location: loc, link, distance: dist } : null;
            })
            .filter(Boolean) as any[];
        });
      }

      // Deduplicate by dish_id, keeping the best weighted rank score per dish
      const bestPerDish = new Map<string, NearbyDish>();

      for (const item of candidates) {
        const distKm = Math.round(item.distance * 10) / 10;
        const relBonus = (item.link.relationship === 'best-known' || item.link.relationship === 'origin') ? -30 : 0;
        const prioBonus = (item.link.display_priority || 1) * 3;
        const rankScore = (distKm * 1.2) + relBonus + prioBonus;

        const existing = bestPerDish.get(item.dish.dish_id);
        const existingScore = (existing as any)?._rankScore ?? Infinity;

        if (rankScore < existingScore) {
          const nearbyObj: NearbyDish = {
            ...item.dish,
            distance_km: Math.round(distKm),
            nearest_location_name: item.location.location_name,
          };
          (nearbyObj as any)._rankScore = rankScore;
          bestPerDish.set(item.dish.dish_id, nearbyObj);
        }
      }

      const resultList = Array.from(bestPerDish.values()).map(d => ({
        ...normalizeDish(d),
        distance_km: d.distance_km,
        nearest_location_name: d.nearest_location_name,
        _rankScore: (d as any)._rankScore,
      }));
      resultList.sort((a, b) => ((a as any)._rankScore ?? 0) - ((b as any)._rankScore ?? 0));
      return resultList;
    },
    enabled: lat !== null && lng !== null,
    staleTime: 1000 * 60 * 10,
  });
}

// -------------------------------------------------------------
// 10. useIconicJapanDishes() — Curated all-Japan iconic specialties for travelers
// -------------------------------------------------------------
export function useIconicJapanDishes() {
  return useQuery<Dish[]>({
    queryKey: ['iconicJapanDishes'],
    queryFn: async () => {
      // Prioritize dishes with rich image assets and famous regional status across Japan
      const iconicDishIds = [
        'sapporo-miso-ramen',
        'soup-curry-sapporo',
        'hitsumabushi',
        'takoyaki',
        'okonomiyaki-osaka',
        'hakata-ramen',
        'nerima-daikon-manju',
        'inagi-pears',
        'sable-manju-komae',
        'bunka-fry',
      ];

      const foundDishes: Dish[] = [];
      for (const id of iconicDishIds) {
        const d = MOCK_DISHES.find(item => item.dish_id === id && item.content_status === 'Published');
        if (d) foundDishes.push(normalizeDish(d));
      }

      // If we need more, add featured dishes from various regions
      if (foundDishes.length < 8) {
        const featured = MOCK_DISHES.filter(
          d => d.content_status === 'Published' && d.featured && !foundDishes.some(fd => fd.dish_id === d.dish_id)
        );
        foundDishes.push(...featured.slice(0, 8 - foundDishes.length).map(normalizeDish));
      }

      return foundDishes;
    },
    staleTime: 1000 * 60 * 15,
  });
}
