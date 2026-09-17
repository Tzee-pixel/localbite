import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TextInput,
  TouchableOpacity,
  Image,
  ActivityIndicator,
} from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { useNavigation } from '@react-navigation/native';
import {
  MagnifyingGlass,
  XCircle,
  MapPin,
  CaretRight,
  Clock,
} from 'phosphor-react-native';
import FilterChips from '../components/FilterChips';
import DishCard from '../components/DishCard';
import SearchBar from '../components/SearchBar';
import SeasonalHintBanner, { SeasonType } from '../components/SeasonalHintBanner';
import { useSearch, getCurrentSeason } from '../lib/queries';
import { MOCK_LOCATIONS, MOCK_DISHES } from '../lib/mockData';
import { getDishPrimaryImageSource } from '../lib/dishImages';
import { colors, typography, spacing, borderRadius, shadows } from '../theme';
import { Dish } from '../types';

const RECENT_SEARCHES_KEY = '@localbite_recent_searches';

interface RecentSearchItem {
  id: string;
  query: string;
  type: 'DISH' | 'PLACE' | 'SEASON' | 'KEYWORD';
}


export const SearchScreen: React.FC = () => {
  const navigation = useNavigation<any>();

  const [query, setQuery] = useState('');
  const [debouncedQuery, setDebouncedQuery] = useState('');
  const [selectedFilters, setSelectedFilters] = useState<string[]>([]);
  const [recentSearches, setRecentSearches] = useState<RecentSearchItem[]>([]);

  useEffect(() => {
    async function loadRecentSearches() {
      try {
        const stored = await AsyncStorage.getItem(RECENT_SEARCHES_KEY);
        if (stored) {
          const parsed = JSON.parse(stored);
          if (Array.isArray(parsed) && parsed.length > 0) {
            setRecentSearches(parsed);
            return;
          }
        }
        const initialDefaults: RecentSearchItem[] = [
          { id: '1', query: 'Tonkotsu Ramen', type: 'DISH' },
          { id: '2', query: 'Karuizawa', type: 'PLACE' },
          { id: '3', query: 'Autumn dishes', type: 'SEASON' },
        ];
        setRecentSearches(initialDefaults);
        await AsyncStorage.setItem(RECENT_SEARCHES_KEY, JSON.stringify(initialDefaults));
      } catch (err) {
        console.error('Error loading recent searches:', err);
      }
    }
    loadRecentSearches();
  }, []);

  const saveRecentSearch = async (queryText: string, type: 'DISH' | 'PLACE' | 'SEASON' | 'KEYWORD') => {
    if (!queryText || queryText.trim().length === 0) return;
    const cleanQuery = queryText.trim();

    setRecentSearches((prev) => {
      const filtered = prev.filter((item) => item.query.toLowerCase() !== cleanQuery.toLowerCase());
      const updated: RecentSearchItem[] = [{ id: String(Date.now()), query: cleanQuery, type }, ...filtered].slice(0, 5);
      AsyncStorage.setItem(RECENT_SEARCHES_KEY, JSON.stringify(updated)).catch(console.error);
      return updated;
    });
  };

  const handleClearRecentSearches = async () => {
    setRecentSearches([]);
    await AsyncStorage.removeItem(RECENT_SEARCHES_KEY).catch(console.error);
  };

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedQuery(query.trim());
    }, 300);
    return () => clearTimeout(handler);
  }, [query]);

  const { data: searchResults, isLoading: isSearching } = useSearch(debouncedQuery);

  const handleToggleFilter = (filter: string) => {
    setSelectedFilters((prev) =>
      prev.includes(filter) ? prev.filter((f) => f !== filter) : [...prev, filter]
    );
  };

  const filterDishes = (dishes: Dish[] | undefined) => {
    if (!dishes) return [];
    if (selectedFilters.length === 0) return dishes;

    return dishes.filter((dish) =>
      selectedFilters.every((filter) => {
        const homeTags = Array.isArray(dish.home_filter_tags) ? dish.home_filter_tags : [];
        if (filter === 'Vegetarian') {
          return dish.vegetarian_status === 'Verified vegetarian' || homeTags.includes('Vegetarian');
        }
        if (filter === 'Halal') {
          return dish.halal_status === 'Verified halal' || homeTags.includes('Halal');
        }
        return homeTags.includes(filter);
      })
    );
  };

  const isPreQuery = debouncedQuery.length === 0;
  const filteredSearchDishes = filterDishes(searchResults?.dishes);
  const filteredSearchLocations = searchResults?.locations || [];

  const currentSeason = getCurrentSeason();

  const handleSelectDishResult = (dishId: string, dishName: string) => {
    saveRecentSearch(dishName, 'DISH');
    navigation.navigate('DishDetail', { dishId });
  };

  const handleSelectLocationResult = (locationId: string, locationName: string) => {
    saveRecentSearch(locationName, 'PLACE');
    navigation.navigate('LocationDetail', { locationId });
  };

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content}>
      {/* Search Input Bar */}
      <SearchBar
        editable
        placeholder="Search by location, dish or season..."
        value={query}
        onChangeText={setQuery}
        onClear={() => setQuery('')}
      />

      {/* PRE-QUERY STATE */}
      {isPreQuery ? (
        <View style={styles.preQueryContainer}>
          {/* 1. Dynamic Active Seasonal Hint Banner */}
          <SeasonalHintBanner
            season={currentSeason as SeasonType}
            onPress={() => {
              saveRecentSearch(`${currentSeason} dishes`, 'SEASON');
              navigation.navigate('SeasonalSearch', { season: currentSeason });
            }}
          />


          {/* 3. Recent Searches (rendered ONLY when recent searches exist) */}
          {recentSearches.length > 0 && (
            <View style={styles.recentSearchesSection}>
              <View style={styles.recentHeaderRow}>
                <Text style={styles.recentHeaderTitle}>Recent Searches</Text>
                <TouchableOpacity onPress={handleClearRecentSearches} activeOpacity={0.7}>
                  <Text style={styles.clearRecentText}>Clear</Text>
                </TouchableOpacity>
              </View>

              <View style={styles.recentListCard}>
                {recentSearches.map((item, idx) => (
                  <React.Fragment key={item.id || idx}>
                    <TouchableOpacity
                      style={styles.recentItemRow}
                      onPress={() => setQuery(item.query)}
                      activeOpacity={0.7}
                    >
                      <View style={styles.clockIconBadge}>
                        <Clock size={16} color={colors.body} />
                      </View>
                      <View style={styles.recentItemTextStack}>
                        <Text style={styles.recentItemQueryText}>{item.query}</Text>
                        <Text style={styles.recentItemTypeText}>{item.type}</Text>
                      </View>
                      <CaretRight size={16} color={colors.textMuted} />
                    </TouchableOpacity>
                    {idx < recentSearches.length - 1 && <View style={styles.itemDividerLine} />}
                  </React.Fragment>
                ))}
              </View>
            </View>
          )}
        </View>
      ) : (
        /* IN-QUERY STATE */
        <View style={styles.resultsContainer}>
          {isSearching ? (
            <View style={styles.loadingBox}>
              <ActivityIndicator size="large" color={colors.rust} />
              <Text style={styles.loadingText}>Searching for "{debouncedQuery}"...</Text>
            </View>
          ) : filteredSearchDishes.length === 0 && filteredSearchLocations.length === 0 ? (
            <View style={styles.emptyResultsBox}>
              <MagnifyingGlass size={32} color={colors.textMuted} />
              <Text style={styles.emptyTitle}>No results found</Text>
              <Text style={styles.emptySubtitle}>
                No dishes or locations matched "{debouncedQuery}". Try another keyword or season.
              </Text>
            </View>
          ) : (
            <View>
              {/* Group 1: Matching Dishes */}
              {filteredSearchDishes.length > 0 && (
                <View style={styles.resultGroup}>
                  <Text style={styles.sectionHeadingH2}>
                    Dishes ({filteredSearchDishes.length})
                  </Text>
                  <View style={styles.dishesList}>
                    {filteredSearchDishes.map((dish) => (
                      <TouchableOpacity
                        key={dish.dish_id}
                        style={styles.dishResultRow}
                        onPress={() => handleSelectDishResult(dish.dish_id, dish.dish_name)}
                        activeOpacity={0.8}
                      >
                        <Image
                          source={getDishPrimaryImageSource(dish)}
                          style={styles.dishResultThumb}
                        />
                        <View style={styles.dishResultInfo}>
                          <Text style={styles.dishResultName}>{dish.dish_name}</Text>
                          <Text style={styles.dishResultJapanese}>{dish.japanese_name}</Text>
                          <Text style={styles.dishResultSummary} numberOfLines={1}>
                            {dish.summary}
                          </Text>
                        </View>
                        <CaretRight size={18} color={colors.textMuted} />
                      </TouchableOpacity>
                    ))}
                  </View>
                </View>
              )}

              {/* Group 2: Matching Locations */}
              {filteredSearchLocations.length > 0 && (
                <View style={styles.resultGroup}>
                  <Text style={styles.sectionHeadingH2}>
                    Locations ({filteredSearchLocations.length})
                  </Text>
                  <View style={styles.locationsList}>
                    {filteredSearchLocations.map((loc) => (
                      <TouchableOpacity
                        key={loc.location_id}
                        style={styles.locationResultRow}
                        onPress={() => handleSelectLocationResult(loc.location_id, loc.location_name)}
                        activeOpacity={0.8}
                      >
                        <View style={styles.locationIconBox}>
                          <MapPin size={20} color={colors.rust} />
                        </View>
                        <View style={styles.locationResultInfo}>
                          <Text style={styles.locationResultName}>
                            {loc.location_name}
                            {loc.city && loc.city !== loc.location_name ? ` • ${loc.city}` : ''}
                          </Text>
                          <Text style={styles.locationResultFocus} numberOfLines={1}>
                            {loc.food_focus || `${loc.type} in Japan`}
                          </Text>
                        </View>
                        <CaretRight size={18} color={colors.textMuted} />
                      </TouchableOpacity>
                    ))}
                  </View>
                </View>
              )}
            </View>
          )}
        </View>
      )}
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.paper,
  },
  content: {
    padding: spacing.lg,
    paddingTop: spacing.xxl + 10,
    paddingBottom: spacing.section,
  },
  searchInputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.surface,
    borderRadius: borderRadius.full,
    paddingHorizontal: spacing.lg + 2,
    paddingVertical: 18,
    minHeight: 60,
    marginBottom: spacing.lg,
    ...shadows.hairline,
  },
  searchIcon: {
    marginRight: spacing.sm,
  },
  searchInput: {
    flex: 1,
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.ink,
    padding: 0,
  },
  clearButton: {
    padding: spacing.xs,
  },
  preQueryContainer: {
    width: '100%',
    paddingTop: spacing.xs,
  },
  preQueryTitle: {
    fontSize: typography.fontSize.h2,
    fontFamily: typography.fontFamily.h2,
    color: colors.ink,
    marginBottom: spacing.xs,
  },
  preQuerySubtitle: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    textAlign: 'center',
    lineHeight: 20,
    maxWidth: 280,
  },
  sectionHeaderRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.md,
    marginTop: spacing.sm,
  },
  sectionHeadingH2: {
    fontSize: typography.fontSize.h2,
    fontFamily: typography.fontFamily.h2, // Playfair Display 700 Bold
    color: colors.ink,
  },
  moreLinkText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodyMedium,
    color: colors.rust,
  },
  shortcutCarousel: {
    marginBottom: spacing.xl,
  },
  locationShortcutCard: {
    width: 140,
    borderRadius: borderRadius.md,
    overflow: 'hidden',
    backgroundColor: colors.surface,
    marginRight: spacing.md,
    ...shadows.hairline,
  },
  locationImagePlaceholder: {
    width: '100%',
    height: 90,
    backgroundColor: colors.trustIndigoTint,
    justifyContent: 'center',
    alignItems: 'center',
  },
  locationCardFooter: {
    padding: spacing.sm,
    backgroundColor: colors.surface,
  },
  locationShortcutName: {
    fontSize: typography.fontSize.xs + 1,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
    textAlign: 'center',
  },
  resultsContainer: {
    marginTop: spacing.sm,
  },
  loadingBox: {
    padding: spacing.xxl,
    alignItems: 'center',
  },
  loadingText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    marginTop: spacing.md,
  },
  emptyResultsBox: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    padding: spacing.xxl,
    alignItems: 'center',
    ...shadows.hairline,
  },
  emptyTitle: {
    fontSize: typography.fontSize.h2,
    fontFamily: typography.fontFamily.h2,
    color: colors.ink,
    marginTop: spacing.sm,
    marginBottom: spacing.xs,
  },
  emptySubtitle: {
    fontSize: typography.fontSize.xs + 1,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    textAlign: 'center',
    lineHeight: 18,
  },
  resultGroup: {
    marginBottom: spacing.xl,
  },
  dishesList: {
    gap: spacing.sm,
  },
  dishResultRow: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    padding: spacing.md,
    ...shadows.hairline,
  },
  dishResultThumb: {
    width: 50,
    height: 50,
    borderRadius: borderRadius.sm,
    marginRight: spacing.md,
    backgroundColor: '#EAE6DF',
  },
  dishResultInfo: {
    flex: 1,
  },
  dishResultName: {
    fontSize: typography.fontSize.sm + 1,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
  },
  dishResultJapanese: {
    fontSize: typography.fontSize.xs,
    fontFamily: typography.fontFamily.japanese,
    color: colors.rust,
    marginBottom: 2,
  },
  dishResultSummary: {
    fontSize: typography.fontSize.xs,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
  },
  locationsList: {
    gap: spacing.sm,
  },
  locationResultRow: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    padding: spacing.md,
    ...shadows.hairline,
  },
  locationIconBox: {
    width: 40,
    height: 40,
    borderRadius: borderRadius.sm,
    backgroundColor: colors.trustIndigoTint,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.md,
  },
  locationResultInfo: {
    flex: 1,
  },
  locationResultName: {
    fontSize: typography.fontSize.sm + 1,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
  },
  locationResultFocus: {
    fontSize: typography.fontSize.xs,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
  },
  seasonalBanner: {
    flexDirection: 'row',
    alignItems: 'center',
    borderRadius: borderRadius.md + 4,
    padding: spacing.lg,
    marginBottom: spacing.lg,
    overflow: 'hidden',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.06,
    shadowRadius: 8,
    elevation: 2,
  },
  seasonalIconBadge: {
    width: 50,
    height: 50,
    borderRadius: 25,
    backgroundColor: 'rgba(255, 255, 255, 0.22)',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.md,
  },
  seasonalTextStack: {
    flex: 1,
  },
  seasonalTitleText: {
    fontSize: typography.fontSize.h3 + 1,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    color: '#FFFFFF',
    marginBottom: 4,
  },
  seasonalSubtitleText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: '#FFFFFF',
    opacity: 0.95,
    lineHeight: 19,
  },
  recentSearchesSection: {
    width: '100%',
    marginTop: spacing.xs,
  },
  recentHeaderRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.md,
  },
  recentHeaderTitle: {
    fontSize: typography.fontSize.h3,
    fontFamily: typography.fontFamily.h3,
    fontWeight: '700',
    color: colors.ink,
  },
  clearRecentText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.rust,
  },
  recentListCard: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    overflow: 'hidden',
    borderWidth: 0.5,
    borderColor: colors.hairline,
  },
  recentItemRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 14,
    paddingHorizontal: spacing.md,
    backgroundColor: colors.surface,
  },
  clockIconBadge: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: '#F2ECE4',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.md,
  },
  recentItemTextStack: {
    flex: 1,
  },
  recentItemQueryText: {
    fontSize: typography.fontSize.sm + 1,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '600',
    color: colors.ink,
    marginBottom: 2,
  },
  recentItemTypeText: {
    fontSize: 10,
    fontFamily: typography.fontFamily.utilitySemiBold,
    color: colors.textMuted,
    letterSpacing: 0.8,
    textTransform: 'uppercase',
  },
  itemDividerLine: {
    height: 0.5,
    backgroundColor: colors.hairline,
    marginLeft: 64,
  },
});

export default SearchScreen;
