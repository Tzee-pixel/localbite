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
  AirplaneTilt,
  GlobeHemisphereWest,
  ArrowRight,
} from 'phosphor-react-native';
import { useLocation, TripPlanningDestination, isCoordinatesOutsideJapan } from '../context/LocationContext';
import {
  useNearbyDishes,
  useDishesInPeakSeason,
  useFeaturedDishes,
  useResolvedLocation,
  useLocalSpecialities,
  useIconicJapanDishes,
  getCurrentSeason,
  calculateDistanceKm,
} from '../lib/queries';
import SearchBar from '../components/SearchBar';
import FilterChips from '../components/FilterChips';
import DishCard from '../components/DishCard';
import OutsideJapanView, { GATEWAY_CITIES, GatewayCity } from '../components/OutsideJapanView';
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
    isOutsideJapan,
    userDetectedLocationName,
    tripPlanningDestination,
    requestPermission,
    setCustomLocation,
    refreshCurrentLocation,
    setTripPlanningDestination,
    clearTripPlanning,
  } = useLocation();

  const [isLocationModalVisible, setIsLocationModalVisible] = useState(false);
  const [showAllNearby, setShowAllNearby] = useState(false);
  const [simulatedDenied, setSimulatedDenied] = useState(false);

  const LOCATION_PRESETS = [
    { name: 'London, UK', lat: 51.5074, lng: -0.1278 },
    { name: 'New York, USA', lat: 40.7128, lng: -74.0060 },
    { name: 'Paris, France', lat: 48.8566, lng: 2.3522 },
    { name: 'Sydney, Australia', lat: -33.8688, lng: 151.2093 },
    { name: 'Singapore', lat: 1.3521, lng: 103.8198 },
    { name: 'Seoul, South Korea', lat: 37.5665, lng: 126.9780 },
    { name: 'Tokyo (Shinjuku)', lat: 35.6938, lng: 139.7034 },
    { name: 'Tokyo (Bunkyo)', lat: 35.7080, lng: 139.7519 },
    { name: 'Tokyo (Nerima)', lat: 35.7356, lng: 139.6517 },
    { name: 'Osaka City', lat: 34.6937, lng: 135.5023 },
    { name: 'Kyoto City', lat: 35.0116, lng: 135.7681 },
    { name: 'Sapporo, Hokkaido', lat: 43.0618, lng: 141.3545 },
    { name: 'Fukuoka (Hakata)', lat: 33.5904, lng: 130.4017 },
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

  // Determine active coordinates and location resolution
  const isPlanningMode = isOutsideJapan && tripPlanningDestination !== null;
  const isOutsideJapanRoot = isOutsideJapan && !isPlanningMode && !simulatedDenied;

  const lat = isPlanningMode
    ? tripPlanningDestination.lat
    : (coords?.latitude ?? 35.7356);
  const lng = isPlanningMode
    ? tripPlanningDestination.lng
    : (coords?.longitude ?? 139.6517);

  const showGrantedState = !simulatedDenied && (
    permissionStatus === 'granted' || isPlanningMode
  ) && Boolean(displayLocationName || tripPlanningDestination);

  const { data: resolvedLocation } = useResolvedLocation(lat, lng);

  const activeLocationId = isPlanningMode
    ? tripPlanningDestination.location_id
    : (resolvedLocation?.location_id || 'shinjuku-ward');

  const { data: localSpecialityDishes, isLoading: isLoadingLocal } = useLocalSpecialities(activeLocationId);
  const { data: nearbyDishes, isLoading: isLoadingNearby } = useNearbyDishes(lat, lng);
  const { data: peakDishes, isLoading: isLoadingPeak } = useDishesInPeakSeason();
  const { data: featuredDishes, isLoading: isLoadingFeatured } = useFeaturedDishes();
  const { data: iconicDishes, isLoading: isLoadingIconic } = useIconicJapanDishes();

  const rawLocationName = isPlanningMode
    ? tripPlanningDestination.location_name
    : (displayLocationName || resolvedLocation?.location_name || 'Tokyo');

  const shortLocationName = rawLocationName
    .replace(/ Ward| City|, Tokyo| Prefecture|, Japan/g, '')
    .trim() || 'Tokyo';

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
        const homeTags = Array.isArray(dish.home_filter_tags) ? dish.home_filter_tags : [];
        if (filter === 'Vegetarian') {
          return dish.vegetarian_status === 'Verified vegetarian' || homeTags.includes('Vegetarian');
        }
        if (filter === 'Halal') {
          return dish.halal_status === 'Verified halal' || homeTags.includes('Halal');
        }
        return homeTags.includes(filter);
      });
    });
  };

  const filteredPeakDishes = applyFilters(peakDishes);
  const filteredIconicDishes = applyFilters(iconicDishes);

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
              <NavigationArrow size={18} color={colors.primary} weight="bold" style={{ marginRight: 8 }} />
              <Text style={styles.presetTextLive}>Detect Live Device GPS</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.presetItemLive} onPress={handleSimulateDenied}>
              <Info size={18} color="#2A4B82" weight="bold" style={{ marginRight: 8 }} />
              <Text style={[styles.presetTextLive, { color: '#2A4B82' }]}>Simulate Location Denied View</Text>
            </TouchableOpacity>

            <View style={styles.divider} />

            <Text style={styles.modalSubheader}>Test Locations & Presets</Text>
            {LOCATION_PRESETS.map((preset, idx) => (
              <TouchableOpacity
                key={idx}
                style={styles.presetItem}
                onPress={() => handleSelectPreset(preset)}
              >
                {isCoordinatesOutsideJapan(preset.lat, preset.lng) ? (
                  <GlobeHemisphereWest size={18} color={colors.primary} weight="bold" style={{ marginRight: 8 }} />
                ) : (
                  <MapPin size={18} color={colors.body} style={{ marginRight: 8 }} />
                )}
                <Text style={styles.presetText}>
                  {preset.name}
                </Text>
              </TouchableOpacity>
            ))}
          </View>
        </TouchableOpacity>
      </Modal>

      {/* 1. Top Location Header */}
      <View style={styles.header}>
        {isOutsideJapan && !isPlanningMode ? (
          <TouchableOpacity
            style={styles.locationHeaderContainer}
            onPress={() => setIsLocationModalVisible(true)}
            activeOpacity={0.7}
          >
            <GlobeHemisphereWest size={22} color={colors.primary} weight="bold" style={{ marginRight: 10, marginTop: 2 }} />
            <View style={styles.locationTextStack}>
              <Text style={styles.currentLocationSublabel}>CONNECTED FROM</Text>
              <View style={styles.locationNameRow}>
                <Text style={styles.locationNameText}>
                  {userDetectedLocationName || displayLocationName || 'London, UK'}
                </Text>
                <CaretDown size={16} color={colors.primary} weight="bold" style={{ marginLeft: 6 }} />
              </View>
            </View>
          </TouchableOpacity>
        ) : isPlanningMode ? (
          <TouchableOpacity
            style={styles.locationHeaderContainer}
            onPress={() => setIsLocationModalVisible(true)}
            activeOpacity={0.7}
          >
            <AirplaneTilt size={22} color="#1E40AF" weight="bold" style={{ marginRight: 10, marginTop: 2 }} />
            <View style={styles.locationTextStack}>
              <Text style={[styles.currentLocationSublabel, { color: '#1E40AF' }]}>TRIP DESTINATION</Text>
              <View style={styles.locationNameRow}>
                <Text style={styles.locationNameText}>
                  {tripPlanningDestination.location_name}
                </Text>
                <CaretDown size={16} color="#1E40AF" weight="bold" style={{ marginLeft: 6 }} />
              </View>
            </View>
          </TouchableOpacity>
        ) : showGrantedState ? (
          <TouchableOpacity
            style={styles.locationHeaderContainer}
            onPress={() => setIsLocationModalVisible(true)}
            activeOpacity={0.7}
          >
            <MapPin size={22} color={colors.primary} weight="bold" style={{ marginRight: 10, marginTop: 2 }} />
            <View style={styles.locationTextStack}>
              <Text style={styles.currentLocationSublabel}>CURRENT LOCATION</Text>
              <View style={styles.locationNameRow}>
                <Text style={styles.locationNameText}>
                  {displayLocationName || resolvedLocation?.location_name || 'Tokyo'}
                </Text>
                <CaretDown size={16} color={colors.primary} weight="bold" style={{ marginLeft: 6 }} />
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

        <TouchableOpacity
          style={styles.savedCollectionButton}
          onPress={() => navigation.navigate('FavouritesTab')}
          activeOpacity={0.8}
        >
          <Bookmark size={15} color={colors.primary} weight="fill" />
          <Text style={styles.savedCollectionText}>Saved</Text>
        </TouchableOpacity>
      </View>

      <View style={styles.subtleDividerLine} />

      {/* ========================================================== */}
      {/* 2. SPECIAL SCREEN: When user is outside Japan (e.g. London) */}
      {/* ========================================================== */}
      {isOutsideJapanRoot ? (
        <OutsideJapanView
          userLocationName={userDetectedLocationName || displayLocationName}
          seasonalDishes={filteredPeakDishes}
          isLoadingSeasonal={isLoadingPeak}
          iconicDishes={filteredIconicDishes}
          isLoadingIconic={isLoadingIconic}
          onSelectCity={(city: GatewayCity) => {
            setTripPlanningDestination({
              location_id: city.id === 'tokyo-central' ? 'shinjuku-ward' : city.id,
              location_name: city.name,
              city: city.name,
              prefecture: city.prefecture,
              region: city.region,
              lat: city.lat,
              lng: city.lng,
              tagline: city.tagline,
            });
          }}
          onSelectRegion={(regionId) => {
            navigation.navigate('SeasonalSearch', { season: currentSeason, regionId });
          }}
          onOpenLocationModal={() => setIsLocationModalVisible(true)}
          onNavigateToDish={(dishId) => navigation.navigate('DishDetail', { dishId })}
          onNavigateToSeasonal={(season) => navigation.navigate('SeasonalSearch', { season })}
          onNavigateToSearch={() => navigation.navigate('SearchTab')}
        />
      ) : (
        /* ========================================================== */
        /* 3. STANDARD / TRIP PLANNING EXPLORE SCREEN                  */
        /* ========================================================== */
        <>
          {/* Trip Planning Banner when exploring a specific destination */}
          {isPlanningMode && tripPlanningDestination && (
            <View style={styles.tripPlanningBanner}>
              <View style={styles.tripPlanningLeft}>
                <View style={styles.tripPlanningIconCircle}>
                  <AirplaneTilt size={18} color="#1E40AF" weight="bold" />
                </View>
                <View style={{ flex: 1 }}>
                  <Text style={styles.tripPlanningTag}>TRIP PLANNING DESTINATION</Text>
                  <Text style={styles.tripPlanningTitle}>{tripPlanningDestination.location_name}, Japan</Text>
                </View>
              </View>
              <TouchableOpacity
                style={styles.switchDestinationBtn}
                onPress={clearTripPlanning}
                activeOpacity={0.8}
              >
                <Text style={styles.switchDestinationBtnText}>All Destinations</Text>
              </TouchableOpacity>
            </View>
          )}

          {/* Main Page H1 Heading */}
          {showGrantedState && !isPlanningMode && (
            <Text style={styles.homepageH1Title}>
              Discover{'\n'}Local Speciality Nearby
            </Text>
          )}

          {/* Persistent Search Bar & Filter Chips */}
          <SearchBar
            placeholder="Search by location, dish or season..."
            onPress={() => navigation.navigate('SearchTab')}
          />

          <FilterChips selectedFilters={selectedFilters} onToggleFilter={handleToggleFilter} />

          {/* Location Permission Hero Card (When Location Access is Denied / Unavailable) */}
          {!showGrantedState && (
            <View style={styles.locationHeroCard}>
              <View style={styles.locationIconBadge}>
                <MapPin size={30} color={colors.primary} weight="fill" />
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

          {/* "In Peak Season Right Now" Carousel */}
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

          {/* Local Specialities Section */}
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

              {/* More Results Nearby (only when within Japan) */}
              {!isPlanningMode && (
                <>
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
            </>
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
    marginLeft: 4,
  },
  locationHeaderContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  locationTextStack: {
    justifyContent: 'center',
  },
  currentLocationSublabel: {
    fontSize: 10,
    fontFamily: typography.fontFamily.utilitySemiBold,
    color: '#78716C',
    letterSpacing: 0.8,
    marginBottom: 2,
    textTransform: 'uppercase',
  },
  locationNameRow: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  locationNameText: {
    fontSize: 20,
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
  tripPlanningBanner: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    backgroundColor: '#EFF6FF',
    borderWidth: 1,
    borderColor: '#BFDBFE',
    borderRadius: borderRadius.md,
    padding: spacing.md,
    marginBottom: spacing.lg,
  },
  tripPlanningLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
    marginRight: spacing.sm,
  },
  tripPlanningIconCircle: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: '#DBEAFE',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: spacing.sm,
  },
  tripPlanningTag: {
    fontSize: 9,
    fontFamily: typography.fontFamily.utilitySemiBold,
    color: '#1E40AF',
    letterSpacing: 0.5,
  },
  tripPlanningTitle: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
  },
  switchDestinationBtn: {
    backgroundColor: colors.surface,
    borderWidth: 1,
    borderColor: '#BFDBFE',
    borderRadius: borderRadius.full,
    paddingHorizontal: spacing.sm + 2,
    paddingVertical: 5,
  },
  switchDestinationBtnText: {
    fontSize: 11,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: '#1E40AF',
  },
  sectionHeaderRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.md,
  },
  sectionHeadingH2: {
    fontSize: typography.fontSize.h2,
    fontFamily: typography.fontFamily.h2,
    color: colors.ink,
  },
  viewAllText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodyMedium,
    color: colors.primary,
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
    backgroundColor: colors.infoTint,
    padding: spacing.md,
    borderRadius: borderRadius.md,
    marginBottom: spacing.xs,
  },
  presetTextLive: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.primary,
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
    height: 1,
    backgroundColor: colors.hairline,
    marginVertical: spacing.sm,
  },
  seeMoreButton: {
    width: '100%',
    marginTop: spacing.lg,
    marginBottom: spacing.sm,
    backgroundColor: colors.surface,
    borderColor: colors.primary,
    borderWidth: 1.5,
    borderRadius: borderRadius.md,
    paddingVertical: 14,
    alignItems: 'center',
    justifyContent: 'center',
  },
  seeMoreButtonText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.primary,
  },
  setHeaderTitleText: {
    fontSize: 20,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    color: colors.ink,
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
    backgroundColor: '#FFF1EC',
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
    backgroundColor: colors.primary,
    borderRadius: borderRadius.md, // 12px rounded rectangle CTA per §3 & §5.1
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
    color: colors.primary,
    textDecorationLine: 'underline',
  },
});

export default ExploreScreen;
