import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Platform,
  Linking,
  Modal,
  Alert,
} from 'react-native';
import { useNavigation } from '@react-navigation/native';
import {
  Compass,
  CaretDown,
  NavigationArrow,
  MapPin,
  Bookmark,
  Snowflake,
  Sun,
  Wind,
  FlowerLotus,
  Info,
} from 'phosphor-react-native';
import { useLocation } from '../context/LocationContext';
import {
  useNearbyDishes,
  useDishesInPeakSeason,
  useFeaturedDishes,
  useResolvedLocation,
  useLocalSpecialities,
  getCurrentSeason,
  calculateDistanceKm,
} from '../lib/queries';
import SearchBar from '../components/SearchBar';
import FilterChips from '../components/FilterChips';
import DishCard from '../components/DishCard';
import { CarouselSkeleton, GridSkeleton } from '../components/SkeletonLoader';
import { colors, typography, spacing, borderRadius, shadows } from '../theme';
import { Dish } from '../types';

export function getSeasonalHeaderCopy(): { header: string; copy: string; color: string } {
  const season = getCurrentSeason();
  if (season === 'Spring') {
    return {
      header: 'Spring in Japan',
      copy: 'Cherry blossoms bloom as fresh bamboo shoots, wild mountain vegetables, and coastal delicacies arrive.',
      color: colors.seasonal.spring,
    };
  }
  if (season === 'Summer') {
    return {
      header: 'Summer in Japan',
      copy: 'Chilled noodles, grilled eel, festival street foods, and refreshing cold sweets for warm sunny days.',
      color: colors.seasonal.summer,
    };
  }
  if (season === 'Autumn') {
    return {
      header: 'Autumn in Japan',
      copy: 'Harvest season delights: aromatic matsutake mushrooms, fresh Pacific saury, and roasted sweet potatoes.',
      color: colors.seasonal.autumn,
    };
  }
  return {
    header: 'Winter in Japan',
    copy: 'Hearty hot pots, savory ramen, warm steamed buns, and rich winter stews to comfort body and soul.',
    color: colors.seasonal.winter,
  };
}

export const ExploreScreen: React.FC = () => {
  const navigation = useNavigation<any>();

  const {
    permissionStatus,
    displayLocationName,
    coords,
    requestPermission,
    setCustomLocation,
    refreshCurrentLocation,
  } = useLocation();

  const [isLocationModalVisible, setIsLocationModalVisible] = useState(false);
  const [showAllNearby, setShowAllNearby] = useState(false);
  const [simulatedDenied, setSimulatedDenied] = useState(false);

  const LOCATION_PRESETS = [
    { name: 'Bunkyo, Tokyo', lat: 35.7080, lng: 139.7519 },
    { name: 'Chiyoda, Tokyo', lat: 35.6938, lng: 139.7530 },
    { name: 'Shinjuku, Tokyo', lat: 35.6938, lng: 139.7034 },
    { name: 'Nerima, Tokyo', lat: 35.7356, lng: 139.6517 },
    { name: 'Osaka City', lat: 34.6937, lng: 135.5023 },
    { name: 'Sapporo, Hokkaido', lat: 43.0618, lng: 141.3545 },
  ];

  const handleSelectPreset = async (preset: { name: string; lat: number; lng: number }) => {
    setIsLocationModalVisible(false);
    setSimulatedDenied(false);
    await setCustomLocation(preset.lat, preset.lng, preset.name);
  };

  const handleSimulateDenied = () => {
    setIsLocationModalVisible(false);
    setSimulatedDenied(true);
  };

  const handleLiveGPS = async () => {
    setIsLocationModalVisible(false);
    setSimulatedDenied(false);
    await refreshCurrentLocation();
  };

  const lat = coords?.latitude ?? 35.7356;
  const lng = coords?.longitude ?? 139.6517;

  const showGrantedState = !simulatedDenied && permissionStatus === 'granted' && Boolean(displayLocationName);

  const { data: resolvedLocation } = useResolvedLocation(lat, lng);
  const activeLocationId = resolvedLocation?.location_id || 'nerima-ward';

  const { data: localSpecialityDishes, isLoading: isLoadingLocal } = useLocalSpecialities(activeLocationId);
  const { data: nearbyDishes, isLoading: isLoadingNearby } = useNearbyDishes(lat, lng);
  const { data: peakDishes, isLoading: isLoadingPeak } = useDishesInPeakSeason();
  const { data: featuredDishes, isLoading: isLoadingFeatured } = useFeaturedDishes();

  const rawLocationName = displayLocationName || resolvedLocation?.location_name || 'Nerima Ward';
  const shortLocationName = rawLocationName
    .replace(/ Ward| City|, Tokyo| Prefecture/g, '')
    .trim() || 'Nerima';

  const [selectedFilters, setSelectedFilters] = useState<string[]>([]);

  const handleToggleFilter = (filter: string) => {
    setSelectedFilters((prev) =>
      prev.includes(filter) ? prev.filter((f) => f !== filter) : [...prev, filter]
    );
  };

  const applyFilters = <T extends Dish>(dishes: T[] | undefined): T[] => {
    if (!dishes) return [];
    if (selectedFilters.length === 0) return dishes;

    return dishes.filter((dish) => {
      return selectedFilters.every((filter) => {
        if (filter === 'Vegetarian') {
          return dish.vegetarian_status === 'Verified vegetarian';
        }
        if (filter === 'Halal') {
          return dish.halal_status === 'Verified halal';
        }
        return dish.home_filter_tags.includes(filter);
      });
    });
  };

  const filteredPeakDishes = applyFilters(peakDishes);

  const baseLocalDishes = (localSpecialityDishes && localSpecialityDishes.length > 0)
    ? localSpecialityDishes
    : (featuredDishes || []);
  const filteredLocalDishes = applyFilters(baseLocalDishes);

  const localDishIds = new Set(baseLocalDishes.map(d => d.dish_id));
  const rawNearbyDishes = (nearbyDishes && nearbyDishes.length > 0)
    ? nearbyDishes.filter(d => !localDishIds.has(d.dish_id))
    : (featuredDishes || []).filter(d => !localDishIds.has(d.dish_id)).map(d => ({ ...d, distance_km: 3 }));
  
  const filteredNearbyDishes = applyFilters(rawNearbyDishes);
  const displayedNearbyDishes = showAllNearby ? filteredNearbyDishes : filteredNearbyDishes.slice(0, 4);

  const handleAllowLocationAccess = async () => {
    setSimulatedDenied(false);
    try {
      await requestPermission();
    } catch {
      if (Platform.OS === 'ios') {
        Linking.openURL('app-settings:');
      } else {
        Alert.alert('Permission Needed', 'Please enable location permissions in App Settings.');
      }
    }
  };

  const currentSeason = getCurrentSeason();

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content}>
      {/* Location Selector Modal */}
      <Modal
        visible={isLocationModalVisible}
        transparent
        animationType="fade"
        onRequestClose={() => setIsLocationModalVisible(false)}
      >
        <TouchableOpacity
          style={styles.modalOverlay}
          activeOpacity={1}
          onPress={() => setIsLocationModalVisible(false)}
        >
          <View style={styles.modalContent}>
            <Text style={styles.modalTitle}>Set Your Location</Text>

            <TouchableOpacity style={styles.presetItemLive} onPress={handleLiveGPS}>
              <NavigationArrow size={18} color={colors.rust} weight="bold" style={{ marginRight: 8 }} />
              <Text style={styles.presetTextLive}>Detect Live Device GPS</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.presetItemLive} onPress={handleSimulateDenied}>
              <Info size={18} color="#2A4B82" weight="bold" style={{ marginRight: 8 }} />
              <Text style={[styles.presetTextLive, { color: '#2A4B82' }]}>Simulate Location Denied View</Text>
            </TouchableOpacity>

            <View style={styles.divider} />

            <Text style={styles.modalSubheader}>Test Locations / Presets</Text>
            {LOCATION_PRESETS.map((preset, idx) => (
              <TouchableOpacity
                key={idx}
                style={styles.presetItem}
                onPress={() => handleSelectPreset(preset)}
              >
                <MapPin size={18} color={colors.body} style={{ marginRight: 8 }} />
                <Text style={styles.presetText}>{preset.name}</Text>
              </TouchableOpacity>
            ))}
          </View>
        </TouchableOpacity>
      </Modal>

      {/* 1. Top Location Header */}
      <View style={styles.header}>
        {showGrantedState ? (
          <TouchableOpacity
            style={styles.locationHeaderContainer}
            onPress={() => setIsLocationModalVisible(true)}
            activeOpacity={0.7}
          >
            <MapPin size={22} color={colors.rust} weight="bold" style={{ marginRight: 10, marginTop: 2 }} />
            <View style={styles.locationTextStack}>
              <Text style={styles.currentLocationSublabel}>CURRENT LOCATION</Text>
              <View style={styles.locationNameRow}>
                <Text style={styles.locationNameText}>
                  {displayLocationName || resolvedLocation?.location_name || 'Nerima, Tokyo'}
                </Text>
                <CaretDown size={16} color={colors.rust} weight="bold" style={{ marginLeft: 6 }} />
              </View>
            </View>
          </TouchableOpacity>
        ) : (
          <TouchableOpacity
            style={styles.locationHeaderContainer}
            onPress={() => setIsLocationModalVisible(true)}
            activeOpacity={0.7}
          >
            <MapPin size={20} color={colors.ink} weight="bold" style={{ marginRight: 8, marginTop: 2 }} />
            <Text style={styles.setHeaderTitleText}>Set Your Location</Text>
          </TouchableOpacity>
        )}

        {showGrantedState ? (
          <TouchableOpacity
            style={styles.savedCollectionButton}
            onPress={() => navigation.navigate('FavouritesTab')}
            activeOpacity={0.8}
          >
            <Bookmark size={15} color={colors.rust} weight="fill" />
            <Text style={styles.savedCollectionText}>Saved Collection</Text>
          </TouchableOpacity>
        ) : (
          <TouchableOpacity
            style={styles.infoIconButton}
            onPress={() => setIsLocationModalVisible(true)}
            activeOpacity={0.8}
          >
            <Info size={18} color={colors.ink} weight="regular" />
          </TouchableOpacity>
        )}
      </View>

      <View style={styles.subtleDividerLine} />

      {/* 2. Main Page H1 Heading (when location is granted) */}
      {showGrantedState && (
        <Text style={styles.homepageH1Title}>
          Discover{'\n'}Local Speciality Nearby
        </Text>
      )}

      {/* 3. Persistent Search Bar & Filter Chips */}
      <SearchBar
        placeholder="Search by location, dish or season..."
        onPress={() => navigation.navigate('SearchTab')}
      />

      <FilterChips selectedFilters={selectedFilters} onToggleFilter={handleToggleFilter} />

      {/* 4. Location Permission Hero Card (When Location Access is Denied / Unavailable) */}
      {!showGrantedState && (
        <View style={styles.locationHeroCard}>
          <View style={styles.locationIconBadge}>
            <MapPin size={30} color={colors.rust} weight="fill" />
          </View>
          <Text style={styles.locationHeroTitle}>See What's Good Nearby</Text>
          <Text style={styles.locationHeroSubtitle}>
            Turn on location to find local specialities close to you.
          </Text>
          <TouchableOpacity
            style={styles.enableLocationButton}
            onPress={handleAllowLocationAccess}
            activeOpacity={0.85}
          >
            <Text style={styles.enableLocationButtonText}>Enable Location</Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={styles.searchCityButton}
            onPress={() => setIsLocationModalVisible(true)}
            activeOpacity={0.7}
          >
            <Text style={styles.searchCityButtonText}>Select a city manually</Text>
          </TouchableOpacity>
        </View>
      )}

      {/* 4. "In Peak Season Right Now" Carousel */}
      <View style={styles.sectionHeaderRow}>
        <Text style={styles.sectionHeadingH2}>In Peak Season Right Now</Text>
        <TouchableOpacity onPress={() => navigation.navigate('SeasonalSearch', { season: currentSeason })}>
          <Text style={styles.viewAllText}>More &gt;</Text>
        </TouchableOpacity>
      </View>

      {isLoadingPeak ? (
        <CarouselSkeleton />
      ) : filteredPeakDishes.length > 0 ? (
        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.carousel}>
          {filteredPeakDishes.map((dish) => (
            <DishCard
              key={dish.dish_id}
              dish={dish}
              variant="carousel"
              onPress={() => navigation.navigate('DishDetail', { dishId: dish.dish_id })}
            />
          ))}
        </ScrollView>
      ) : (
        <View style={styles.emptyCard}>
          <Text style={styles.emptyText}>No seasonal dishes match the selected filters.</Text>
        </View>
      )}

      {/* 5. Section 5 & 6 (Only shown when location is granted / selected) */}
      {showGrantedState && (
        <>
          <View style={styles.sectionHeaderRow}>
            <Text style={styles.sectionHeadingH2}>
              Local Speciality in {shortLocationName}
            </Text>
          </View>

          {isLoadingLocal ? (
            <GridSkeleton />
          ) : filteredLocalDishes.length > 0 ? (
            <View style={styles.gridContainer}>
              {filteredLocalDishes.map((dish) => (
                <View key={dish.dish_id} style={styles.gridItem}>
                  <DishCard
                    dish={dish}
                    variant="grid"
                    onPress={() => navigation.navigate('DishDetail', { dishId: dish.dish_id })}
                  />
                </View>
              ))}
            </View>
          ) : (
            <View style={styles.emptyCard}>
              <Text style={styles.emptyText}>No local specialties match the selected filters.</Text>
            </View>
          )}

          <View style={[styles.sectionHeaderRow, { marginTop: spacing.xl }]}>
            <Text style={styles.sectionHeadingH2}>More Results Nearby</Text>
          </View>

          {isLoadingNearby ? (
            <GridSkeleton />
          ) : displayedNearbyDishes.length > 0 ? (
            <View>
              <View style={styles.gridContainer}>
                {displayedNearbyDishes.map((dish) => (
                  <View key={dish.dish_id} style={styles.gridItem}>
                    <DishCard
                      dish={dish}
                      variant="grid"
                      onPress={() => navigation.navigate('DishDetail', { dishId: dish.dish_id })}
                    />
                  </View>
                ))}
              </View>

              {!showAllNearby && filteredNearbyDishes.length > 4 && (
                <TouchableOpacity
                  style={styles.seeMoreButton}
                  onPress={() => setShowAllNearby(true)}
                  activeOpacity={0.8}
                >
                  <Text style={styles.seeMoreButtonText}>See More</Text>
                </TouchableOpacity>
              )}
            </View>
          ) : (
            <View style={styles.emptyCard}>
              <Text style={styles.emptyText}>No nearby dishes match the selected filters.</Text>
            </View>
          )}
        </>
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
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: spacing.sm,
  },
  subtleDividerLine: {
    height: 1,
    backgroundColor: colors.hairline,
    marginBottom: spacing.lg,
  },
  savedCollectionButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.surface,
    borderRadius: borderRadius.full,
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.xs + 3,
    ...shadows.hairline,
  },
  savedCollectionText: {
    fontSize: typography.fontSize.xs,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
  },
  locationHeaderContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  locationTextStack: {
    justifyContent: 'center',
  },
  currentLocationSublabel: {
    fontSize: 11,
    fontFamily: typography.fontFamily.bodyMedium,
    fontWeight: '700',
    color: '#78716C', // Warm muted gray
    letterSpacing: 0.8,
    marginBottom: 2,
  },
  locationNameRow: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  locationNameText: {
    fontSize: 22,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    color: colors.ink,
  },
  homepageH1Title: {
    fontSize: 32,
    fontFamily: typography.fontFamily.h1,
    fontWeight: '700',
    color: colors.ink,
    marginTop: spacing.xl,
    marginBottom: spacing.xl,
    lineHeight: 38,
  },
  refreshLocButton: {
    marginLeft: spacing.sm,
    padding: spacing.xs,
    backgroundColor: colors.trustIndigoTint,
    borderRadius: borderRadius.full,
  },
  allowLinkContainer: {
    marginTop: spacing.xs,
  },
  allowLinkText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodyMedium,
    color: colors.rust,
  },
  seasonHeaderBlock: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    padding: spacing.lg,
    marginBottom: spacing.xl,
    borderLeftWidth: 4,
    ...shadows.hairline,
  },
  seasonTitleRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: spacing.xs,
  },
  seasonTitle: {
    fontSize: typography.fontSize.h2,
    fontFamily: typography.fontFamily.display,
  },
  seasonCopy: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    lineHeight: 20,
  },
  sectionHeaderRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.md,
  },
  sectionHeadingH2: {
    fontSize: typography.fontSize.h2, // 22px
    fontFamily: typography.fontFamily.h2, // Playfair Display 700 Bold
    color: colors.ink,
  },
  viewAllText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodyMedium,
    color: colors.rust,
  },
  carousel: {
    marginBottom: spacing.xl,
  },
  gridContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    gap: 10,
  },
  gridItem: {
    width: '48.5%',
  },
  emptyCard: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    padding: spacing.xl,
    alignItems: 'center',
    marginBottom: spacing.lg,
    ...shadows.hairline,
  },
  emptyText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(28, 25, 23, 0.4)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: spacing.lg,
  },
  modalContent: {
    width: '90%',
    maxWidth: 380,
    backgroundColor: colors.surface,
    borderRadius: borderRadius.lg,
    padding: spacing.lg,
    ...shadows.shadowFloat,
  },
  modalTitle: {
    fontSize: typography.fontSize.h2,
    fontFamily: typography.fontFamily.h2,
    color: colors.ink,
    marginBottom: spacing.md,
  },
  modalSubheader: {
    fontSize: typography.fontSize.monoLabel,
    fontFamily: typography.fontFamily.utility,
    color: colors.textMuted,
    marginTop: spacing.sm,
    marginBottom: spacing.xs,
    textTransform: 'uppercase',
  },
  presetItemLive: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.trustIndigoTint,
    padding: spacing.md,
    borderRadius: borderRadius.md,
    marginBottom: spacing.xs,
  },
  presetTextLive: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.rust,
  },
  presetItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: spacing.md - 2,
    paddingHorizontal: spacing.sm,
    borderRadius: borderRadius.sm,
  },
  presetText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.ink,
  },
  divider: {
    height: 0.5,
    backgroundColor: colors.hairline,
    marginVertical: spacing.sm,
  },
  seeMoreButton: {
    width: '100%',
    marginTop: spacing.lg,
    marginBottom: spacing.sm,
    backgroundColor: colors.surface,
    borderColor: colors.rust,
    borderWidth: 1.5,
    borderRadius: borderRadius.full,
    paddingVertical: 14,
    alignItems: 'center',
    justifyContent: 'center',
  },
  seeMoreButtonText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.rust,
  },
  setHeaderTitleText: {
    fontSize: 22,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    color: colors.ink,
  },
  infoIconButton: {
    width: 34,
    height: 34,
    borderRadius: 17,
    backgroundColor: '#F5F2EC',
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 0.5,
    borderColor: colors.hairline,
  },
  locationHeroCard: {
    backgroundColor: 'rgba(255, 255, 255, 0.5)',
    borderRadius: borderRadius.md,
    padding: spacing.xl,
    paddingVertical: spacing.xl,
    alignItems: 'center',
    marginTop: spacing.md,
    marginBottom: spacing.xl,
    borderWidth: 1,
    borderColor: 'rgba(28, 25, 23, 0.08)',
  },
  locationIconBadge: {
    width: 68,
    height: 68,
    borderRadius: 34,
    backgroundColor: '#FFF1EC', // Soft warm rust tint
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: spacing.md,
  },
  locationHeroTitle: {
    fontSize: 22,
    fontFamily: typography.fontFamily.display,
    fontWeight: '700',
    color: colors.ink,
    textAlign: 'center',
    marginBottom: spacing.xs,
  },
  locationHeroSubtitle: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    textAlign: 'center',
    lineHeight: 20,
    maxWidth: 280,
    marginBottom: spacing.xl,
  },
  enableLocationButton: {
    width: '100%',
    backgroundColor: colors.rust,
    borderRadius: borderRadius.full,
    paddingVertical: 14,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.md,
  },
  enableLocationButtonText: {
    fontSize: typography.fontSize.md - 1,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: '#FFFFFF',
    fontWeight: '700',
  },
  searchCityButton: {
    paddingVertical: spacing.xs,
  },
  searchCityButtonText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.rust,
    textDecorationLine: 'underline',
  },
});

export default ExploreScreen;
