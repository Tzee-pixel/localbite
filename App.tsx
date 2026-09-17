import React, { useState, useEffect } from 'react';
import { View, ActivityIndicator, Platform } from 'react-native';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import {
  NavigationContainer,
  LinkingOptions,
  getStateFromPath as defaultGetStateFromPath,
  getPathFromState as defaultGetPathFromState,
} from '@react-navigation/native';
import { QueryClientProvider } from '@tanstack/react-query';
import * as Linking from 'expo-linking';
import { useFonts, NotoSansJP_900Black } from '@expo-google-fonts/noto-sans-jp';
import {
  Figtree_400Regular,
  Figtree_400Regular_Italic,
  Figtree_500Medium,
  Figtree_600SemiBold,
} from '@expo-google-fonts/figtree';
import { PlayfairDisplay_700Bold } from '@expo-google-fonts/playfair-display';
import { IBMPlexMono_500Medium, IBMPlexMono_600SemiBold } from '@expo-google-fonts/ibm-plex-mono';

import { queryClient } from './src/lib/queryClient';
import { LocationProvider, useLocation } from './src/context/LocationContext';
import { TabNavigator } from './src/navigation/TabNavigator';
import { LocationPermissionScreen } from './src/screens/LocationPermissionScreen';
import { colors } from './src/theme';
import { RootTabParamList } from './src/navigation/types';

const prefix = Linking.createURL('/');

const isSubpathDeployment =
  Platform.OS === 'web' &&
  typeof window !== 'undefined' &&
  (window.location.pathname.startsWith('/localbite') || window.location.hostname.includes('github.io'));

const linking: LinkingOptions<RootTabParamList> = {
  prefixes: [
    prefix,
    'localbite://',
    'https://tzee-pixel.github.io/localbite',
    'https://tzee-pixel.github.io/localbite/',
    'https://tzee-pixel.github.io',
    'https://localbite.app',
  ],
  config: {
    screens: {
      ExploreTab: {
        screens: {
          ExploreHome: '',
          DishDetail: 'dish/:dishId',
          LocationDetail: 'location/:locationId',
          SeasonalSearch: 'seasonal/:season',
        },
      },
      SearchTab: {
        screens: {
          SearchHome: 'search',
          DishDetail: 'search/dish/:dishId',
          LocationDetail: 'search/location/:locationId',
          SeasonalSearch: 'search/seasonal/:season',
        },
      },
      FavouritesTab: {
        screens: {
          FavouritesHome: 'favourites',
          DishDetail: 'favourites/dish/:dishId',
        },
      },
      SettingsTab: {
        screens: {
          SettingsHome: 'settings',
        },
      },
    },
  },
  getStateFromPath: (path, options) => {
    const cleanPath = path.replace(/^\/?localbite\/?/, '');
    return defaultGetStateFromPath(cleanPath || '', options);
  },
  getPathFromState: (state, options) => {
    const rawPath = defaultGetPathFromState(state, options);
    if (isSubpathDeployment) {
      return `/localbite${rawPath.startsWith('/') ? rawPath : '/' + rawPath}`;
    }
    return rawPath;
  },
};

function MainAppShell() {
  const { hasCompletedOnboarding, isLoadingLocation } = useLocation();

  if (isLoadingLocation || hasCompletedOnboarding === null) {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', backgroundColor: colors.paper }}>
        <ActivityIndicator size="large" color={colors.rust} />
      </View>
    );
  }

  if (!hasCompletedOnboarding) {
    return <LocationPermissionScreen />;
  }

  return (
    <NavigationContainer linking={linking}>
      <TabNavigator />
      <StatusBar style="dark" />
    </NavigationContainer>
  );
}

export default function App() {
  const [fontsLoaded] = useFonts({
    NotoSansJP_900Black,
    Figtree_400Regular,
    Figtree_400Regular_Italic,
    Figtree_500Medium,
    Figtree_600SemiBold,
    PlayfairDisplay_700Bold,
    IBMPlexMono_500Medium,
    IBMPlexMono_600SemiBold,
  });

  const [fontTimeoutPassed, setFontTimeoutPassed] = useState(false);

  useEffect(() => {
    const timer = setTimeout(() => {
      setFontTimeoutPassed(true);
    }, 500);
    return () => clearTimeout(timer);
  }, []);

  if (!fontsLoaded && !fontTimeoutPassed) {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', backgroundColor: colors.paper }}>
        <ActivityIndicator size="large" color={colors.rust} />
      </View>
    );
  }

  return (
    <SafeAreaProvider>
      <QueryClientProvider client={queryClient}>
        <LocationProvider>
          <MainAppShell />
        </LocationProvider>
      </QueryClientProvider>
    </SafeAreaProvider>
  );
}
