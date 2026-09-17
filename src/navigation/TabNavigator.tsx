import React from 'react';
import { Platform } from 'react-native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Compass, MagnifyingGlass, Bookmark, Gear } from 'phosphor-react-native';

import { ExploreScreen } from '../screens/ExploreScreen';
import { SearchScreen } from '../screens/SearchScreen';
import { FavouritesScreen } from '../screens/FavouritesScreen';
import { SettingsScreen } from '../screens/SettingsScreen';
import { DishDetailScreen } from '../screens/DishDetailScreen';
import { LocationDetailScreen } from '../screens/LocationDetailScreen';
import { SeasonalSearchScreen } from '../screens/SeasonalSearchScreen';

import { colors, typography } from '../theme';
import {
  RootTabParamList,
  ExploreStackParamList,
  SearchStackParamList,
  FavouritesStackParamList,
  SettingsStackParamList,
} from './types';

const Tab = createBottomTabNavigator<RootTabParamList>();

const ExploreStack = createNativeStackNavigator<ExploreStackParamList>();
const SearchStack = createNativeStackNavigator<SearchStackParamList>();
const FavouritesStack = createNativeStackNavigator<FavouritesStackParamList>();
const SettingsStack = createNativeStackNavigator<SettingsStackParamList>();

function ExploreNavigator() {
  return (
    <ExploreStack.Navigator screenOptions={{ headerShown: false }}>
      <ExploreStack.Screen name="ExploreHome" component={ExploreScreen} />
      <ExploreStack.Screen name="DishDetail" component={DishDetailScreen} />
      <ExploreStack.Screen name="LocationDetail" component={LocationDetailScreen} />
      <ExploreStack.Screen name="SeasonalSearch" component={SeasonalSearchScreen} />
    </ExploreStack.Navigator>
  );
}

function SearchNavigator() {
  return (
    <SearchStack.Navigator screenOptions={{ headerShown: false }}>
      <SearchStack.Screen name="SearchHome" component={SearchScreen} />
      <SearchStack.Screen name="DishDetail" component={DishDetailScreen} />
      <SearchStack.Screen name="LocationDetail" component={LocationDetailScreen} />
      <SearchStack.Screen name="SeasonalSearch" component={SeasonalSearchScreen} />
    </SearchStack.Navigator>
  );
}

function FavouritesNavigator() {
  return (
    <FavouritesStack.Navigator screenOptions={{ headerShown: false }}>
      <FavouritesStack.Screen name="FavouritesHome" component={FavouritesScreen} />
      <FavouritesStack.Screen name="DishDetail" component={DishDetailScreen} />
    </FavouritesStack.Navigator>
  );
}

function SettingsNavigator() {
  return (
    <SettingsStack.Navigator screenOptions={{ headerShown: false }}>
      <SettingsStack.Screen name="SettingsHome" component={SettingsScreen} />
    </SettingsStack.Navigator>
  );
}

export const TabNavigator: React.FC = () => {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        headerShown: false,
        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.textMuted, // rgba(28, 25, 23, 0.60) — 4.59:1 contrast (WCAG AA pass)
        tabBarStyle: {
          backgroundColor: colors.surface,
          borderTopColor: colors.hairline,
          borderTopWidth: 1, // 1px firmer border
          height: 64,
          paddingTop: 4,
          paddingBottom: 4,
          elevation: 0,
        },
        tabBarItemStyle: {
          justifyContent: 'center',
          alignItems: 'center',
          paddingVertical: 2,
        },
        tabBarLabelStyle: {
          fontSize: 10,
          fontFamily: typography.fontFamily.bodyMedium,
          marginTop: 2,
        },
        tabBarIcon: ({ focused, color }) => {
          const iconSize = 20;
          const weight = focused ? 'fill' : 'regular';

          if (route.name === 'ExploreTab') {
            return <Compass size={iconSize} color={color} weight={weight} />;
          } else if (route.name === 'SearchTab') {
            return <MagnifyingGlass size={iconSize} color={color} weight={weight} />;
          } else if (route.name === 'FavouritesTab') {
            return <Bookmark size={iconSize} color={color} weight={weight} />;
          } else if (route.name === 'SettingsTab') {
            return <Gear size={iconSize} color={color} weight={weight} />;
          }

          return <Compass size={iconSize} color={color} weight={weight} />;
        },
      })}
    >
      <Tab.Screen
        name="ExploreTab"
        component={ExploreNavigator}
        options={{ tabBarLabel: 'Explore' }}
        listeners={({ navigation }) => ({
          tabPress: (e) => {
            navigation.navigate('ExploreTab', { screen: 'ExploreHome' });
          },
        })}
      />
      <Tab.Screen
        name="SearchTab"
        component={SearchNavigator}
        options={{ tabBarLabel: 'Search' }}
        listeners={({ navigation }) => ({
          tabPress: (e) => {
            navigation.navigate('SearchTab', { screen: 'SearchHome' });
          },
        })}
      />
      <Tab.Screen
        name="FavouritesTab"
        component={FavouritesNavigator}
        options={{ tabBarLabel: 'Favourites' }}
        listeners={({ navigation }) => ({
          tabPress: (e) => {
            navigation.navigate('FavouritesTab', { screen: 'FavouritesHome' });
          },
        })}
      />
      <Tab.Screen
        name="SettingsTab"
        component={SettingsNavigator}
        options={{ tabBarLabel: 'Settings' }}
      />
    </Tab.Navigator>
  );
};

export default TabNavigator;
