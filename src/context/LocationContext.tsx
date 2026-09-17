import React, { createContext, useContext, useState, useEffect } from 'react';
import { Platform } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import * as Location from 'expo-location';
import { MOCK_LOCATIONS } from '../lib/mockData';

const ONBOARDING_KEY = '@localbite_has_completed_permission_onboarding';
const PERMISSION_DECISION_KEY = '@localbite_permission_decision';

export type ExploreInternalReason =
  | 'GRANTED_RESOLVED'      // Granted + Location resolved to published location in Japan
  | 'GRANTED_OUTSIDE_JAPAN' // Granted + GPS obtained BUT user is outside Japan (Trip Planning / Global Explorer mode)
  | 'GRANTED_UNAVAILABLE'   // Granted + GPS obtained BUT no nearby published location (PRD §7.3 fallback)
  | 'DENIED_MANUAL'        // User clicked "Explore Regions Manually"
  | 'DENIED_REVOKED';       // Permission denied at OS level

export interface Coords {
  latitude: number;
  longitude: number;
}

export interface TripPlanningDestination {
  location_id: string;
  location_name: string;
  city?: string;
  prefecture?: string;
  region?: string;
  lat: number;
  lng: number;
  tagline?: string;
}

interface LocationContextType {
  hasCompletedOnboarding: boolean | null;
  permissionStatus: 'undetermined' | 'granted' | 'denied';
  exploreReason: ExploreInternalReason;
  coords: Coords | null;
  displayLocationName: string | null;
  isOutsideJapan: boolean;
  userDetectedLocationName: string | null;
  tripPlanningDestination: TripPlanningDestination | null;
  isLoadingLocation: boolean;
  requestPermission: () => Promise<void>;
  skipPermission: () => Promise<void>;
  resetOnboarding: () => Promise<void>;
  refreshCurrentLocation: () => Promise<void>;
  setCustomLocation: (latitude: number, longitude: number, nameOverride?: string) => Promise<void>;
  setTripPlanningDestination: (destination: TripPlanningDestination | null) => void;
  clearTripPlanning: () => void;
}

const LocationContext = createContext<LocationContextType | undefined>(undefined);

// Haversine distance formula in km
export function haversineDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
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

// Global helper to check if given coordinates are outside Japan
export function isCoordinatesOutsideJapan(lat: number | null | undefined, lon: number | null | undefined): boolean {
  if (lat === null || lat === undefined || lon === null || lon === undefined || isNaN(lat) || isNaN(lon)) {
    return true;
  }

  // 1. Extreme boundary bounding check: Japan territory is strictly within:
  // Lat: 20° N to 46° N
  // Lng: 122° E to 154° E (including Ogasawara & remote islands)
  if (lat < 20 || lat > 46 || lon < 122 || lon > 154) {
    return true;
  }

  // 2. Special case for Ogasawara Islands (lat: 26.5 to 27.5, lon: 142.0 to 142.5)
  if (lat >= 26.5 && lat <= 27.5 && lon >= 142.0 && lon <= 142.5) {
    return false; // Inside Japan (Ogasawara)
  }

  // 3. For coordinates within the East Asia bounding box:
  // Check distance to the closest Japanese location in MOCK_LOCATIONS
  let minDistanceToJapan = Infinity;
  for (const loc of MOCK_LOCATIONS) {
    const locLat = loc.lat ?? 35.6762;
    const locLng = loc.lng ?? 139.6503;
    const dist = haversineDistance(lat, lon, locLat, locLng);
    if (dist < minDistanceToJapan) {
      minDistanceToJapan = dist;
    }
  }

  // Any point genuinely within Japan's borders is within ~65 km of a prefecture / city / island in MOCK_LOCATIONS.
  // Neighboring foreign cities (Seoul: ~450km, Busan: ~180km, Taipei: ~120km, Vladivostok: ~350km, Shanghai: ~700km) are well over 65km.
  return minDistanceToJapan > 65;
}

// Reverse Geocode Helper for any coordinate worldwide
async function resolveDisplayLocationName(coords: Coords | null): Promise<string | null> {
  if (!coords) return null;

  // On Web, use reverse geocoding API
  if (Platform.OS === 'web') {
    try {
      const res = await fetch(
        `https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${coords.latitude}&longitude=${coords.longitude}`
      );
      if (res.ok) {
        const data = await res.json();
        const rawMain = data.locality || data.city || data.localityInfo?.administrative?.[data.localityInfo?.administrative?.length - 1]?.name;
        const main = rawMain ? rawMain.replace(/-ku$/i, '') : null;
        const country = data.countryName || data.countryCode;
        const region = data.principalSubdivision;

        if (main && country && main !== country) {
          return `${main}, ${country}`;
        }
        if (main && region && main !== region) {
          return `${main}, ${region}`;
        }
        if (main) return main;
        if (country) return country;
        if (region) return region;
      }
    } catch (err) {
      console.warn('Web reverse geocode fetch error:', err);
    }
  }

  // On Native iOS/Android, use expo-location native OS geocoder
  try {
    const result = await Location.reverseGeocodeAsync({
      latitude: coords.latitude,
      longitude: coords.longitude,
    });

    if (result && result.length > 0) {
      const addr = result[0];
      const rawMain = addr.district || addr.city || addr.subregion || addr.name;
      const mainPart = rawMain ? rawMain.replace(/-ku$/i, '') : null;
      const countryPart = addr.country || addr.region;

      if (mainPart && countryPart && mainPart !== countryPart) {
        return `${mainPart}, ${countryPart}`;
      }
      if (mainPart) return mainPart;
      if (countryPart) return countryPart;
    }
  } catch (err) {
    console.log('reverseGeocodeAsync error or unavailable in environment:', err);
  }

  return null;
}

// Client IP Location Helper on Web (detects global location without GPS permission prompt)
async function getClientIpLocation(): Promise<{ coords: Coords; name: string } | null> {
  if (Platform.OS === 'web') {
    try {
      const res = await fetch('https://api.bigdatacloud.net/data/reverse-geocode-client');
      if (res.ok) {
        const data = await res.json();
        if (typeof data.latitude === 'number' && typeof data.longitude === 'number') {
          const rawMain = data.locality || data.city || data.localityInfo?.administrative?.[data.localityInfo?.administrative?.length - 1]?.name;
          const main = rawMain ? rawMain.replace(/-ku$/i, '') : null;
          const country = data.countryName || data.countryCode;
          const region = data.principalSubdivision;

          let name: string | null = null;
          if (main && country && main !== country) {
            name = `${main}, ${country}`;
          } else if (main && region && main !== region) {
            name = `${main}, ${region}`;
          } else {
            name = main || country || region || null;
          }

          return {
            coords: { latitude: data.latitude, longitude: data.longitude },
            name: name || 'International Location',
          };
        }
      }
    } catch (err) {
      console.warn('IP location fetch error:', err);
    }
  }
  return null;
}

// Fetch real GPS device location using native expo-location or browser navigator.geolocation
async function getRealDeviceLocation(): Promise<Coords | null> {
  // Web Browser: prioritize native navigator.geolocation directly for browser permission dialog
  if (Platform.OS === 'web' && typeof navigator !== 'undefined' && navigator.geolocation) {
    const coords = await new Promise<Coords | null>((resolve) => {
      navigator.geolocation.getCurrentPosition(
        (pos) => {
          console.log('Real web browser geolocation:', pos.coords.latitude, pos.coords.longitude);
          resolve({
            latitude: pos.coords.latitude,
            longitude: pos.coords.longitude,
          });
        },
        (err) => {
          console.warn('Web browser geolocation error/denied:', err.message);
          resolve(null);
        },
        { enableHighAccuracy: true, timeout: 8000, maximumAge: 0 }
      );
    });

    if (coords) return coords;
  }

  // Native mobile iOS / Android via expo-location
  try {
    const { status } = await Location.requestForegroundPermissionsAsync();
    if (status === 'granted') {
      const loc = await Location.getCurrentPositionAsync({
        accuracy: Location.Accuracy.Balanced,
      });
      if (loc && loc.coords) {
        return {
          latitude: loc.coords.latitude,
          longitude: loc.coords.longitude,
        };
      }
    }
  } catch (err) {
    console.log('expo-location getCurrentPositionAsync fallback:', err);
  }

  return null;
}

export const LocationProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [hasCompletedOnboarding, setHasCompletedOnboarding] = useState<boolean | null>(null);
  const [permissionStatus, setPermissionStatus] = useState<'undetermined' | 'granted' | 'denied'>('undetermined');
  const [exploreReason, setExploreReason] = useState<ExploreInternalReason>('GRANTED_RESOLVED');
  const [coords, setCoords] = useState<Coords | null>(null);
  const [displayLocationName, setDisplayLocationName] = useState<string | null>(null);
  const [isOutsideJapan, setIsOutsideJapan] = useState<boolean>(false);
  const [userDetectedLocationName, setUserDetectedLocationName] = useState<string | null>(null);
  const [tripPlanningDestination, setTripPlanningDestinationState] = useState<TripPlanningDestination | null>(null);
  const [isLoadingLocation, setIsLoadingLocation] = useState<boolean>(true);

  // Helper to update coords + displayLocationName + outside Japan check
  const updateLocationCoords = async (newCoords: Coords | null, nameOverride?: string) => {
    setCoords(newCoords);
    if (!newCoords) {
      setDisplayLocationName(null);
      setUserDetectedLocationName(null);
      setIsOutsideJapan(false);
      return;
    }

    const outside = isCoordinatesOutsideJapan(newCoords.latitude, newCoords.longitude);
    setIsOutsideJapan(outside);

    if (outside) {
      setExploreReason('GRANTED_OUTSIDE_JAPAN');
    } else {
      setExploreReason('GRANTED_RESOLVED');
    }

    const rawName = nameOverride || (await resolveDisplayLocationName(newCoords));
    const name = rawName ? rawName.replace(/\s*\([^)]*Outside Japan[^)]*\)/gi, '').trim() : null;
    setDisplayLocationName(name);
    setUserDetectedLocationName(name);
  };

  // Set trip planning destination
  const setTripPlanningDestination = (dest: TripPlanningDestination | null) => {
    setTripPlanningDestinationState(dest);
  };

  const clearTripPlanning = () => {
    setTripPlanningDestinationState(null);
  };

  // Manual / Preset Location Setter for testing
  const setCustomLocation = async (latitude: number, longitude: number, nameOverride?: string) => {
    setIsLoadingLocation(true);
    try {
      setPermissionStatus('granted');
      const newCoords = { latitude, longitude };
      setTripPlanningDestinationState(null);
      await updateLocationCoords(newCoords, nameOverride);
    } finally {
      setIsLoadingLocation(false);
    }
  };

  // Explicit location refresh action
  const refreshCurrentLocation = async () => {
    setIsLoadingLocation(true);
    try {
      const realCoords = await getRealDeviceLocation();
      if (realCoords) {
        setPermissionStatus('granted');
        await AsyncStorage.setItem(PERMISSION_DECISION_KEY, 'granted');
        setTripPlanningDestinationState(null);
        await updateLocationCoords(realCoords);
      } else {
        setPermissionStatus('denied');
        setExploreReason('DENIED_REVOKED');
        await AsyncStorage.setItem(PERMISSION_DECISION_KEY, 'denied');
        await updateLocationCoords(null);
      }
    } finally {
      setIsLoadingLocation(false);
    }
  };

  // Initialize and check existing storage + system permission status
  useEffect(() => {
    async function initLocationState() {
      try {
        const storedDecision = await AsyncStorage.getItem(PERMISSION_DECISION_KEY);

        setHasCompletedOnboarding(true);

        if (storedDecision === 'granted') {
          const realCoords = await getRealDeviceLocation();
          if (realCoords) {
            setPermissionStatus('granted');
            await updateLocationCoords(realCoords);
          } else {
            const ipLoc = await getClientIpLocation();
            if (ipLoc) {
              setPermissionStatus('granted');
              await updateLocationCoords(ipLoc.coords, ipLoc.name);
            } else {
              setPermissionStatus('denied');
              setExploreReason('DENIED_REVOKED');
              await updateLocationCoords(null);
            }
          }
        } else if (storedDecision === 'denied' || storedDecision === 'denied_manual') {
          setPermissionStatus('denied');
          setExploreReason('DENIED_MANUAL');
          await updateLocationCoords(null);
        } else {
          // New Visitor / Web load: Auto-detect location via IP or Browser Geolocation
          const ipLoc = await getClientIpLocation();
          if (ipLoc) {
            setPermissionStatus('granted');
            await updateLocationCoords(ipLoc.coords, ipLoc.name);
          } else {
            const realCoords = await getRealDeviceLocation();
            if (realCoords) {
              setPermissionStatus('granted');
              await updateLocationCoords(realCoords);
            } else {
              setPermissionStatus('denied');
              setExploreReason('DENIED_MANUAL');
              await updateLocationCoords(null);
            }
          }
        }
      } catch (err) {
        console.error('Error initializing location state:', err);
        setHasCompletedOnboarding(true);
        setPermissionStatus('denied');
        await updateLocationCoords(null);
      } finally {
        setIsLoadingLocation(false);
      }
    }

    initLocationState();
  }, []);

  // Handler: "Enable Location Access"
  const requestPermission = async () => {
    setIsLoadingLocation(true);
    try {
      const realCoords = await getRealDeviceLocation();
      if (realCoords) {
        await AsyncStorage.setItem(ONBOARDING_KEY, 'true');
        await AsyncStorage.setItem(PERMISSION_DECISION_KEY, 'granted');
        setPermissionStatus('granted');
        await updateLocationCoords(realCoords);
      } else {
        const ipLoc = await getClientIpLocation();
        if (ipLoc) {
          await AsyncStorage.setItem(ONBOARDING_KEY, 'true');
          await AsyncStorage.setItem(PERMISSION_DECISION_KEY, 'granted');
          setPermissionStatus('granted');
          await updateLocationCoords(ipLoc.coords, ipLoc.name);
        } else {
          await AsyncStorage.setItem(ONBOARDING_KEY, 'true');
          await AsyncStorage.setItem(PERMISSION_DECISION_KEY, 'denied');
          setPermissionStatus('denied');
          setExploreReason('DENIED_REVOKED');
          await updateLocationCoords(null);
        }
      }
    } catch (err) {
      console.error('Error requesting location permission:', err);
      setPermissionStatus('denied');
      await updateLocationCoords(null);
    } finally {
      setIsLoadingLocation(false);
    }
  };

  // Handler: "Explore Regions Manually"
  const skipPermission = async () => {
    try {
      await AsyncStorage.setItem(ONBOARDING_KEY, 'true');
      await AsyncStorage.setItem(PERMISSION_DECISION_KEY, 'denied_manual');
      setHasCompletedOnboarding(true);
      setPermissionStatus('denied');
      setExploreReason('DENIED_MANUAL');
      await updateLocationCoords(null);
    } catch (err) {
      console.error('Error skipping permission:', err);
    }
  };

  // Handler: Reset onboarding for testing
  const resetOnboarding = async () => {
    try {
      await AsyncStorage.removeItem(ONBOARDING_KEY);
      await AsyncStorage.removeItem(PERMISSION_DECISION_KEY);
      setHasCompletedOnboarding(false);
      setPermissionStatus('undetermined');
      setExploreReason('DENIED_MANUAL');
      setTripPlanningDestinationState(null);
      await updateLocationCoords(null);
    } catch (err) {
      console.error('Error resetting onboarding:', err);
    }
  };

  return (
    <LocationContext.Provider
      value={{
        hasCompletedOnboarding,
        permissionStatus,
        exploreReason,
        coords,
        displayLocationName,
        isOutsideJapan,
        userDetectedLocationName,
        tripPlanningDestination,
        isLoadingLocation,
        requestPermission,
        skipPermission,
        resetOnboarding,
        refreshCurrentLocation,
        setCustomLocation,
        setTripPlanningDestination,
        clearTripPlanning,
      }}
    >
      {children}
    </LocationContext.Provider>
  );
};

export const useLocation = (): LocationContextType => {
  const context = useContext(LocationContext);
  if (!context) {
    throw new Error('useLocation must be used within a LocationProvider');
  }
  return context;
};
