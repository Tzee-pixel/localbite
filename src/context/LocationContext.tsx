import React, { createContext, useContext, useState, useEffect } from 'react';
import { Platform } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import * as Location from 'expo-location';

const ONBOARDING_KEY = '@localbite_has_completed_permission_onboarding';
const PERMISSION_DECISION_KEY = '@localbite_permission_decision';

export type ExploreInternalReason =
  | 'GRANTED_RESOLVED'      // Granted + Location resolved to published location
  | 'GRANTED_UNAVAILABLE'   // Granted + GPS obtained BUT no nearby published location (PRD §7.3 fallback)
  | 'DENIED_MANUAL'        // User clicked "Explore Regions Manually"
  | 'DENIED_REVOKED';       // Permission denied at OS level

interface Coords {
  latitude: number;
  longitude: number;
}

interface LocationContextType {
  hasCompletedOnboarding: boolean | null;
  permissionStatus: 'undetermined' | 'granted' | 'denied';
  exploreReason: ExploreInternalReason;
  coords: Coords | null;
  displayLocationName: string | null;
  isLoadingLocation: boolean;
  requestPermission: () => Promise<void>;
  skipPermission: () => Promise<void>;
  resetOnboarding: () => Promise<void>;
  refreshCurrentLocation: () => Promise<void>;
  setCustomLocation: (latitude: number, longitude: number, nameOverride?: string) => Promise<void>;
}

const LocationContext = createContext<LocationContextType | undefined>(undefined);

// Default test coordinates: Sapporo, Hokkaido (43.0618, 141.3545) used only as fallback when real GPS is unavailable
const DEFAULT_TEST_COORDS = { latitude: 43.0618, longitude: 141.3545 };

// Reverse Geocode Helper (Step 1)
async function resolveDisplayLocationName(coords: Coords | null): Promise<string | null> {
  if (!coords) return null;

  // On Web, expo-location reverseGeocodeAsync is unsupported by Expo SDK, so use free client API
  if (Platform.OS === 'web') {
    try {
      const res = await fetch(
        `https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${coords.latitude}&longitude=${coords.longitude}`
      );
      if (res.ok) {
        const data = await res.json();
        const rawMain = data.locality || data.city || data.localityInfo?.administrative?.[data.localityInfo?.administrative?.length - 1]?.name;
        const main = rawMain ? rawMain.replace(/-ku$/i, '') : null;
        const region = data.principalSubdivision || data.countryName;

        if (main && region && main !== region) {
          return `${main}, ${region}`;
        }
        if (main) return main;
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
      const regionPart = addr.region || addr.city;

      if (mainPart && regionPart && mainPart !== regionPart) {
        return `${mainPart}, ${regionPart}`;
      }
      if (mainPart) return mainPart;
      if (regionPart) return regionPart;
    }
  } catch (err) {
    console.log('reverseGeocodeAsync error or unavailable in environment:', err);
  }

  // Fallback for default test coordinates (Sapporo, Hokkaido)
  if (coords.latitude === 43.0618 && coords.longitude === 141.3545) {
    return 'Sapporo, Hokkaido';
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
  const [isLoadingLocation, setIsLoadingLocation] = useState<boolean>(true);

  // Helper to update coords + displayLocationName
  const updateLocationCoords = async (newCoords: Coords | null) => {
    setCoords(newCoords);
    if (!newCoords) {
      setDisplayLocationName(null);
      return;
    }
    const name = await resolveDisplayLocationName(newCoords);
    setDisplayLocationName(name);
  };

  // Manual / Preset Location Setter for testing
  const setCustomLocation = async (latitude: number, longitude: number, nameOverride?: string) => {
    setIsLoadingLocation(true);
    try {
      setPermissionStatus('granted');
      setExploreReason('GRANTED_RESOLVED');
      const newCoords = { latitude, longitude };
      setCoords(newCoords);
      if (nameOverride) {
        setDisplayLocationName(nameOverride);
      } else {
        const name = await resolveDisplayLocationName(newCoords);
        setDisplayLocationName(name);
      }
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
        setExploreReason('GRANTED_RESOLVED');
        await AsyncStorage.setItem(PERMISSION_DECISION_KEY, 'granted');
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
            setExploreReason('GRANTED_RESOLVED');
            await updateLocationCoords(realCoords);
          } else {
            setPermissionStatus('denied');
            setExploreReason('DENIED_REVOKED');
            await updateLocationCoords(null);
          }
        } else {
          setPermissionStatus('denied');
          setExploreReason('DENIED_MANUAL');
          await updateLocationCoords(null);
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
        setExploreReason('GRANTED_RESOLVED');
        await updateLocationCoords(realCoords);
      } else {
        await AsyncStorage.setItem(ONBOARDING_KEY, 'true');
        await AsyncStorage.setItem(PERMISSION_DECISION_KEY, 'denied');
        setPermissionStatus('denied');
        setExploreReason('DENIED_REVOKED');
        await updateLocationCoords(null);
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
        isLoadingLocation,
        requestPermission,
        skipPermission,
        resetOnboarding,
        refreshCurrentLocation,
        setCustomLocation,
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
