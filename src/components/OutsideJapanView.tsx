import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  ImageBackground,
} from 'react-native';
import {
  AirplaneTilt,
  Compass,
  MapPin,
  MagnifyingGlass,
  ArrowRight,
  Sparkle,
  CalendarCheck,
  GlobeHemisphereWest,
  CaretRight,
} from 'phosphor-react-native';
import { Dish } from '../types';
import DishCard from './DishCard';
import { CarouselSkeleton, GridSkeleton } from './SkeletonLoader';
import { colors, typography, spacing, borderRadius, shadows } from '../theme';
import { getCurrentSeason } from '../lib/queries';

export interface GatewayCity {
  id: string;
  name: string;
  japaneseName: string;
  region: string;
  prefecture: string;
  tagline: string;
  lat: number;
  lng: number;
  image: string;
}

export const GATEWAY_CITIES: GatewayCity[] = [
  {
    id: 'tokyo-central',
    name: 'Tokyo',
    japaneseName: '東京',
    region: 'Kanto',
    prefecture: 'Tokyo',
    tagline: 'Ramen, Tsukiji Seafood, Edomae Tempura & Sweets',
    lat: 35.6938,
    lng: 139.7034,
    image: 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=800&q=80',
  },
  {
    id: 'osaka-city',
    name: 'Osaka',
    japaneseName: '大阪',
    region: 'Kansai',
    prefecture: 'Osaka',
    tagline: "The Nation's Kitchen: Takoyaki, Okonomiyaki & Kushikatsu",
    lat: 34.6937,
    lng: 135.5023,
    image: 'https://images.unsplash.com/photo-1590559899731-a382839e5549?auto=format&fit=crop&w=800&q=80',
  },
  {
    id: 'kyoto-city',
    name: 'Kyoto',
    japaneseName: '京都',
    region: 'Kansai',
    prefecture: 'Kyoto',
    tagline: 'Centuries of Kaiseki, Matcha, Yuba & Obanzai',
    lat: 35.0116,
    lng: 135.7681,
    image: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=800&q=80',
  },
  {
    id: 'sapporo-city',
    name: 'Sapporo, Hokkaido',
    japaneseName: '札幌',
    region: 'Hokkaido',
    prefecture: 'Hokkaido',
    tagline: 'Miso Ramen, Soup Curry, Fresh Crab & Dairy Sweets',
    lat: 43.0618,
    lng: 141.3545,
    image: 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=800&q=80',
  },
  {
    id: 'fukuoka-city',
    name: 'Fukuoka (Hakata)',
    japaneseName: '福岡',
    region: 'Kyuushuu',
    prefecture: 'Fukuoka',
    tagline: 'Hakata Tonkotsu Ramen, Spicy Mentaiko & Yatai Stalls',
    lat: 33.5904,
    lng: 130.4017,
    image: 'https://images.unsplash.com/photo-1542051841857-5f90071e7989?auto=format&fit=crop&w=800&q=80',
  },
  {
    id: 'nagano-karuizawa',
    name: 'Nagano & Karuizawa',
    japaneseName: '長野',
    region: 'Chubu',
    prefecture: 'Nagano',
    tagline: 'Handcrafted Shinshu Soba, Mountain Hotpots & Fruit',
    lat: 36.3533,
    lng: 138.6358,
    image: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
  },
];

export const JAPAN_REGIONS = [
  { id: 'kanto', name: 'Kanto', japanese: '関東', desc: 'Tokyo, Yokohama, Kamakura' },
  { id: 'kansai', name: 'Kansai', japanese: '関西', desc: 'Osaka, Kyoto, Kobe, Nara' },
  { id: 'hokkaido', name: 'Hokkaido', japanese: '北海道', desc: 'Sapporo, Otaru, Hakodate' },
  { id: 'chubu', name: 'Chubu', japanese: '中部', desc: 'Nagano, Nagoya, Shizuoka' },
  { id: 'kyuushuu', name: 'Kyushu', japanese: '九州', desc: 'Fukuoka, Nagasaki, Kagoshima' },
  { id: 'tohoku', name: 'Tohoku', japanese: '東北', desc: 'Sendai, Aomori, Akita' },
  { id: 'chugoku', name: 'Chugoku', japanese: '中国', desc: 'Hiroshima, Okayama, Shimane' },
  { id: 'shikoku', name: 'Shikoku', japanese: '四国', desc: 'Kagawa (Sanuki Udon), Ehime' },
];

interface OutsideJapanViewProps {
  userLocationName: string | null;
  seasonalDishes: Dish[];
  isLoadingSeasonal: boolean;
  iconicDishes: Dish[];
  isLoadingIconic: boolean;
  onSelectCity: (city: GatewayCity) => void;
  onSelectRegion: (regionId: string) => void;
  onOpenLocationModal: () => void;
  onNavigateToDish: (dishId: string) => void;
  onNavigateToSeasonal: (season: string) => void;
  onNavigateToSearch: () => void;
}

export const OutsideJapanView: React.FC<OutsideJapanViewProps> = ({
  userLocationName,
  seasonalDishes,
  isLoadingSeasonal,
  iconicDishes,
  isLoadingIconic,
  onSelectCity,
  onSelectRegion,
  onOpenLocationModal,
  onNavigateToDish,
  onNavigateToSeasonal,
  onNavigateToSearch,
}) => {
  const currentSeason = getCurrentSeason();
  const rawName = userLocationName ? userLocationName.replace(/\s*\([^)]*Outside Japan[^)]*\)/gi, '').trim() : '';
  const detectedLocationText = rawName || 'Global Explorer';

  return (
    <View style={styles.container}>
      {/* 1. Welcoming Hero Card with London / International Badge */}
      <View style={styles.heroCard}>
        <View style={styles.badgeRow}>
          <View style={styles.detectedBadge}>
            <GlobeHemisphereWest size={13} color={colors.primary} weight="bold" />
            <Text style={styles.detectedBadgeText} numberOfLines={1}>
              {detectedLocationText}
            </Text>
          </View>
          <View style={styles.tripPlanBadge}>
            <AirplaneTilt size={13} color="#2A4B82" weight="bold" />
            <Text style={styles.tripPlanBadgeText}>Trip Planning Mode</Text>
          </View>
        </View>

        <Text style={styles.heroTitle}>
          Planning a Trip{'\n'}to Japan? 🇯🇵
        </Text>
        <Text style={styles.heroSubtitle}>
          You're connecting from outside Japan. Discover regional specialties, explore seasonal foods, and bookmark dishes for your itinerary.
        </Text>

        <TouchableOpacity
          style={styles.searchPromptButton}
          onPress={onNavigateToSearch}
          activeOpacity={0.88}
        >
          <MagnifyingGlass size={17} color={colors.primary} weight="bold" style={{ marginRight: 8 }} />
          <Text style={styles.searchPromptText}>Search any dish, city or station in Japan...</Text>
        </TouchableOpacity>
      </View>

      {/* 2. Gateway Destinations in Japan */}
      <View style={styles.sectionHeader}>
        <View>
          <View style={styles.sectionTitleRow}>
            <AirplaneTilt size={18} color={colors.primary} weight="fill" style={{ marginRight: 6 }} />
            <Text style={styles.sectionHeading}>Choose Your Destination</Text>
          </View>
          <Text style={styles.sectionSubtitle}>
            Tap a gateway city to explore its authentic local dishes
          </Text>
        </View>
      </View>

      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.citiesCarousel}
      >
        {GATEWAY_CITIES.map((city) => (
          <TouchableOpacity
            key={city.id}
            style={styles.cityCard}
            onPress={() => onSelectCity(city)}
            activeOpacity={0.9}
          >
            <ImageBackground
              source={{ uri: city.image }}
              style={styles.cityCardImage}
              imageStyle={{ borderRadius: borderRadius.md }}
            >
              <View style={styles.cityCardOverlay}>
                <View style={styles.cityCardTop}>
                  <View style={styles.regionTag}>
                    <Text style={styles.regionTagText}>{city.region}</Text>
                  </View>
                  <Text style={styles.cityJapaneseName}>{city.japaneseName}</Text>
                </View>

                <View style={styles.cityCardBottom}>
                  <Text style={styles.cityName}>{city.name}</Text>
                  <Text style={styles.cityTagline} numberOfLines={2}>
                    {city.tagline}
                  </Text>
                  <View style={styles.exploreActionRow}>
                    <Text style={styles.exploreActionText}>Explore Dishes</Text>
                    <ArrowRight size={13} color="#FFFFFF" weight="bold" />
                  </View>
                </View>
              </View>
            </ImageBackground>
          </TouchableOpacity>
        ))}
      </ScrollView>

      {/* 3. In Peak Season in Japan Right Now */}
      <View style={[styles.sectionHeader, { marginTop: spacing.xxl }]}>
        <View>
          <View style={styles.sectionTitleRow}>
            <CalendarCheck size={18} color={colors.primary} weight="fill" style={{ marginRight: 6 }} />
            <Text style={styles.sectionHeading}>{currentSeason} in Japan</Text>
          </View>
          <Text style={styles.sectionSubtitle}>
            What's fresh, harvest-ready, and delicious across Japan right now
          </Text>
        </View>
        <TouchableOpacity
          onPress={() => onNavigateToSeasonal(currentSeason)}
          style={styles.moreLinkContainer}
        >
          <Text style={styles.moreLinkText}>View All &gt;</Text>
        </TouchableOpacity>
      </View>

      {isLoadingSeasonal ? (
        <CarouselSkeleton />
      ) : seasonalDishes.length > 0 ? (
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={styles.dishesCarousel}
        >
          {seasonalDishes.map((dish) => (
            <DishCard
              key={dish.dish_id}
              dish={dish}
              variant="carousel"
              onPress={() => onNavigateToDish(dish.dish_id)}
            />
          ))}
        </ScrollView>
      ) : (
        <View style={styles.emptyCard}>
          <Text style={styles.emptyText}>Loading seasonal highlights...</Text>
        </View>
      )}

      {/* 4. Must-Try Iconic Japanese Dishes */}
      <View style={[styles.sectionHeader, { marginTop: spacing.xxl }]}>
        <View>
          <View style={styles.sectionTitleRow}>
            <Sparkle size={18} color={colors.primary} weight="fill" style={{ marginRight: 6 }} />
            <Text style={styles.sectionHeading}>Iconic Dishes to Know</Text>
          </View>
          <Text style={styles.sectionSubtitle}>
            Must-try culinary milestones across Japan's prefectures
          </Text>
        </View>
      </View>

      {isLoadingIconic ? (
        <GridSkeleton />
      ) : iconicDishes.length > 0 ? (
        <View style={styles.gridContainer}>
          {iconicDishes.map((dish) => (
            <View key={dish.dish_id} style={styles.gridItem}>
              <DishCard
                dish={dish}
                variant="grid"
                onPress={() => onNavigateToDish(dish.dish_id)}
              />
            </View>
          ))}
        </View>
      ) : null}

      {/* 5. Explore by Japanese Region */}
      <View style={[styles.sectionHeader, { marginTop: spacing.xxl }]}>
        <View>
          <View style={styles.sectionTitleRow}>
            <Compass size={18} color={colors.primary} weight="fill" style={{ marginRight: 6 }} />
            <Text style={styles.sectionHeading}>Browse Japan by Region</Text>
          </View>
          <Text style={styles.sectionSubtitle}>
            Filter authentic regional cuisine across the 8 island regions
          </Text>
        </View>
      </View>

      <View style={styles.regionsGrid}>
        {JAPAN_REGIONS.map((region) => (
          <TouchableOpacity
            key={region.id}
            style={styles.regionCard}
            onPress={() => onSelectRegion(region.id)}
            activeOpacity={0.8}
          >
            <View style={styles.regionCardHeader}>
              <Text style={styles.regionCardName}>{region.name}</Text>
              <Text style={styles.regionCardJapanese}>{region.japanese}</Text>
            </View>
            <Text style={styles.regionCardDesc} numberOfLines={1}>
              {region.desc}
            </Text>
            <View style={styles.regionCardArrow}>
              <CaretRight size={14} color={colors.primary} weight="bold" />
            </View>
          </TouchableOpacity>
        ))}
      </View>

      {/* 6. Switch Location Banner / Test Helper */}
      <View style={styles.locationSwitcherBanner}>
        <View style={styles.switcherIconContainer}>
          <MapPin size={22} color={colors.primary} weight="fill" />
        </View>
        <View style={{ flex: 1, marginRight: spacing.sm }}>
          <Text style={styles.switcherTitle}>Arrived in Japan or Testing?</Text>
          <Text style={styles.switcherSubtitle}>
            Switch to a specific station or simulate device GPS in Japan.
          </Text>
        </View>
        <TouchableOpacity
          style={styles.switcherButton}
          onPress={onOpenLocationModal}
          activeOpacity={0.85}
        >
          <Text style={styles.switcherButtonText}>Change</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    paddingBottom: spacing.section,
  },
  heroCard: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.lg,
    padding: spacing.xl,
    marginBottom: spacing.xl,
    borderWidth: 1,
    borderColor: colors.hairline,
    ...shadows.shadowFloat,
  },
  badgeRow: {
    flexDirection: 'row',
    alignItems: 'center',
    flexWrap: 'wrap',
    gap: spacing.xs + 2,
    marginBottom: spacing.md,
  },
  detectedBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#FFF7ED',
    borderWidth: 1,
    borderColor: '#FED7AA',
    paddingHorizontal: spacing.sm + 2,
    paddingVertical: 3,
    borderRadius: borderRadius.full,
    gap: 5,
  },
  detectedBadgeText: {
    fontSize: typography.fontSize.caption,
    fontFamily: typography.fontFamily.utilitySemiBold,
    color: colors.primary,
    letterSpacing: 0.3,
  },
  tripPlanBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#EFF6FF',
    borderWidth: 1,
    borderColor: '#BFDBFE',
    paddingHorizontal: spacing.sm + 2,
    paddingVertical: 3,
    borderRadius: borderRadius.full,
    gap: 5,
  },
  tripPlanBadgeText: {
    fontSize: typography.fontSize.caption,
    fontFamily: typography.fontFamily.utilitySemiBold,
    color: '#1E40AF',
    letterSpacing: 0.3,
  },
  heroTitle: {
    fontSize: typography.fontSize.h1,
    fontFamily: typography.fontFamily.display,
    color: colors.ink,
    lineHeight: 34,
    marginBottom: spacing.sm,
  },
  heroSubtitle: {
    fontSize: typography.fontSize.body,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    lineHeight: 22,
    marginBottom: spacing.lg,
  },
  searchPromptButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.paper,
    borderWidth: 1,
    borderColor: colors.hairline,
    borderRadius: borderRadius.md,
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.md - 1,
  },
  searchPromptText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.textMuted,
    flex: 1,
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'flex-end',
    justifyContent: 'space-between',
    marginBottom: spacing.md,
  },
  sectionTitleRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 2,
  },
  sectionHeading: {
    fontSize: typography.fontSize.h2,
    fontFamily: typography.fontFamily.h2,
    color: colors.ink,
  },
  sectionSubtitle: {
    fontSize: typography.fontSize.caption,
    fontFamily: typography.fontFamily.body,
    color: colors.textMuted,
    marginTop: 2,
  },
  moreLinkContainer: {
    paddingVertical: 4,
    paddingHorizontal: 6,
  },
  moreLinkText: {
    fontSize: typography.fontSize.caption,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.primary,
  },
  citiesCarousel: {
    gap: spacing.md,
    paddingRight: spacing.md,
  },
  cityCard: {
    width: 240,
    height: 180,
    borderRadius: borderRadius.md,
    overflow: 'hidden',
    ...shadows.shadowFloat,
  },
  cityCardImage: {
    width: '100%',
    height: '100%',
    justifyContent: 'space-between',
  },
  cityCardOverlay: {
    flex: 1,
    backgroundColor: 'rgba(28, 25, 23, 0.45)',
    padding: spacing.md,
    justifyContent: 'space-between',
  },
  cityCardTop: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
  },
  regionTag: {
    backgroundColor: 'rgba(255, 255, 255, 0.9)',
    borderRadius: borderRadius.sm,
    paddingHorizontal: 8,
    paddingVertical: 3,
  },
  regionTagText: {
    fontSize: 10,
    fontFamily: typography.fontFamily.utilitySemiBold,
    color: colors.ink,
    textTransform: 'uppercase',
    letterSpacing: 0.5,
  },
  cityJapaneseName: {
    fontSize: 18,
    fontFamily: typography.fontFamily.japanese,
    color: 'rgba(255, 255, 255, 0.85)',
  },
  cityCardBottom: {
    gap: 2,
  },
  cityName: {
    fontSize: typography.fontSize.h3,
    fontFamily: typography.fontFamily.display,
    color: '#FFFFFF',
  },
  cityTagline: {
    fontSize: 11,
    fontFamily: typography.fontFamily.body,
    color: 'rgba(255, 255, 255, 0.9)',
    lineHeight: 15,
  },
  exploreActionRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    marginTop: 4,
  },
  exploreActionText: {
    fontSize: 11,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: '#FFFFFF',
  },
  dishesCarousel: {
    paddingRight: spacing.md,
    gap: spacing.md,
  },
  gridContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    marginHorizontal: -spacing.xs,
  },
  gridItem: {
    width: '50%',
    padding: spacing.xs,
  },
  regionsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: spacing.sm,
  },
  regionCard: {
    width: '48%',
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    padding: spacing.md,
    borderWidth: 1,
    borderColor: colors.hairline,
    position: 'relative',
  },
  regionCardHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 4,
  },
  regionCardName: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
  },
  regionCardJapanese: {
    fontSize: 12,
    fontFamily: typography.fontFamily.japanese,
    color: colors.textMuted,
  },
  regionCardDesc: {
    fontSize: 11,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    marginRight: 16,
  },
  regionCardArrow: {
    position: 'absolute',
    right: 10,
    bottom: 12,
  },
  locationSwitcherBanner: {
    marginTop: spacing.xxl,
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#F7F4EF',
    borderRadius: borderRadius.md,
    padding: spacing.md,
    borderWidth: 1,
    borderColor: colors.hairline,
  },
  switcherIconContainer: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: colors.surface,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: spacing.md,
  },
  switcherTitle: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
  },
  switcherSubtitle: {
    fontSize: 11,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    marginTop: 2,
  },
  switcherButton: {
    backgroundColor: colors.surface,
    borderWidth: 1,
    borderColor: colors.hairline,
    borderRadius: borderRadius.full,
    paddingHorizontal: spacing.md,
    paddingVertical: 6,
  },
  switcherButtonText: {
    fontSize: typography.fontSize.caption,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.primary,
  },
  emptyCard: {
    backgroundColor: colors.surface,
    padding: spacing.lg,
    borderRadius: borderRadius.md,
    alignItems: 'center',
  },
  emptyText: {
    fontSize: typography.fontSize.sm,
    color: colors.textMuted,
    fontFamily: typography.fontFamily.body,
  },
});

export default OutsideJapanView;
