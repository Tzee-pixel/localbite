import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity } from 'react-native';
import { useRoute, useNavigation } from '@react-navigation/native';
import { LinearGradient } from 'expo-linear-gradient';
import Svg, { Defs, RadialGradient, Stop, Rect } from 'react-native-svg';
import { ArrowLeft } from 'phosphor-react-native';
import { useSeasonalDishes } from '../lib/queries';
import DishCard from '../components/DishCard';
import { GridSkeleton } from '../components/SkeletonLoader';
import { colors, typography, spacing, borderRadius, shadows } from '../theme';

const REGION_TABS = [
  { label: 'All', id: null },
  { label: 'Hokkaido', id: 'hokkaido' },
  { label: 'Tohoku', id: 'tohoku' },
  { label: 'Kanto', id: 'kanto' },
  { label: 'Chubu', id: 'chubu' },
  { label: 'Chugoku', id: 'chugoku' },
  { label: 'Kansai', id: 'kansai' },
  { label: 'Shikoku', id: 'shikoku' },
  { label: 'Kyushu', id: 'kyuushuu' },
] as const;

// Region filter color palette
const REGION_FILTER_THEME = {
  regionLabelColor: colors.ink,
  tabSelectedBg: colors.primary,
  tabUnselectedBorder: colors.hairline,
  tabUnselectedText: colors.body,
};

export interface SeasonalThemeConfig {
  seasonKey: string;
  title: string;
  displayTitle: string;
  quote: string;
  desc: string;
  emoji: string;
  badgeText: string;
  gradientColors: [string, string, string, string];
  glowColor1: string;
  glowColor2: string;
  glowColor3: string;
  glowColor4: string;
  shadowColor: string;
  backColor: string;
  titleColor: string;
  quoteColor: string;
  descColor: string;
  badgeBg: string;
  badgeBorder: string;
  badgeTextColor: string;
  regionLabelColor: string;
  tabSelectedBg: string;
  tabUnselectedBorder: string;
  tabUnselectedText: string;
}

export function getSeasonalTheme(season: string): SeasonalThemeConfig {
  const s = season.toLowerCase();
  if (s.includes('spring')) {
    return {
      seasonKey: 'spring',
      title: 'Spring Speciality',
      displayTitle: 'Spring\nSpeciality',
      quote: '“The Season of Renewal & Delicate Flavors”',
      desc: 'Discover dishes blooming with the freshness of Hanami season.',
      emoji: '🌸',
      badgeText: 'CHERRY BLOSSOM SEASON',
      gradientColors: ['#6B2D4E', '#6B2D4E', '#C4607A', '#F2A0B0'],
      glowColor1: 'rgba(255, 255, 255, 0.18)',
      glowColor2: 'rgba(255, 214, 226, 0.22)',
      glowColor3: 'rgba(255, 255, 255, 0.14)',
      glowColor4: 'rgba(246, 197, 208, 0.20)',
      shadowColor: '#5b2237',
      backColor: '#FFD6E2',
      titleColor: '#FFFFFF',
      quoteColor: '#FFE8EE',
      descColor: '#FFD6E2',
      badgeBg: 'rgba(107, 45, 78, 0.60)',
      badgeBorder: '#F2A0B0',
      badgeTextColor: '#FFFFFF',
      ...REGION_FILTER_THEME,
    };
  }
  if (s.includes('summer')) {
    return {
      seasonKey: 'summer',
      title: 'Summer Speciality',
      displayTitle: 'Summer\nSpeciality',
      quote: '“The Season of Vitality & Bold Umami”',
      desc: 'Savor dishes bursting with the heat and energy of Japanese summer festivals.',
      emoji: '☀️',
      badgeText: 'PEAK SUMMER FESTIVAL',
      gradientColors: ['#0A1628', '#0A1628', '#0E7490', '#F59E0B'],
      glowColor1: 'rgba(165, 243, 252, 0.32)',
      glowColor2: 'rgba(34, 211, 238, 0.20)',
      glowColor3: 'rgba(245, 158, 11, 0.38)',
      glowColor4: 'rgba(14, 116, 144, 0.70)',
      shadowColor: '#0A1628',
      backColor: '#A5F3FC',
      titleColor: '#FEFCE8',
      quoteColor: '#FEFCE8',
      descColor: '#E0FBFC',
      badgeBg: 'rgba(10, 22, 40, 0.55)',
      badgeBorder: 'rgba(34, 211, 238, 0.60)',
      badgeTextColor: '#FEFCE8',
      ...REGION_FILTER_THEME,
    };
  }
  if (s.includes('winter')) {
    return {
      seasonKey: 'winter',
      title: 'Winter Speciality',
      displayTitle: 'Winter\nSpeciality',
      quote: '“The Season of Warmth & Deep Comfort”',
      desc: 'Indulge in hearty dishes crafted to warm the soul through Japan\'s coldest months.',
      emoji: '❄️',
      badgeText: 'WINTER HARVEST',
      gradientColors: ['#080C1A', '#142943', '#1E3A5F', '#4A7FA5'],
      glowColor1: 'rgba(240, 248, 255, 0.22)',
      glowColor2: 'rgba(203, 213, 225, 0.16)',
      glowColor3: 'rgba(240, 248, 255, 0.12)',
      glowColor4: 'rgba(186, 230, 253, 0.14)',
      shadowColor: '#080C1A',
      backColor: '#BAE6FD',
      titleColor: '#F0F8FF',
      quoteColor: '#E5F3FC',
      descColor: '#D8EAF4',
      badgeBg: 'rgba(8, 12, 26, 0.45)',
      badgeBorder: 'rgba(186, 230, 253, 0.50)',
      badgeTextColor: '#F0F8FF',
      ...REGION_FILTER_THEME,
    };
  }
  // Default: Autumn
  return {
    seasonKey: 'autumn',
    title: 'Autumn Speciality',
    displayTitle: 'Autumn\nSpeciality',
    quote: '“The Season of Harvest & Rich Flavors”',
    desc: 'Explore dishes capturing peak umami across Japan.',
    emoji: '🍁',
    badgeText: 'LIMITED SEASON',
    gradientColors: ['#3b0a00', '#621707', '#a93613', '#d2601a'],
    glowColor1: 'rgba(236, 157, 79, 0.34)',
    glowColor2: 'rgba(246, 190, 110, 0.18)',
    glowColor3: 'rgba(101, 18, 4, 0.5)',
    glowColor4: 'rgba(210, 96, 26, 0.25)',
    shadowColor: '#441809',
    backColor: '#ffd2a6',
    titleColor: '#fff5e9',
    quoteColor: '#fff0d9',
    descColor: '#f9d9b7',
    badgeBg: 'rgba(91, 22, 8, 0.45)',
    badgeBorder: 'rgba(245, 202, 131, 0.4)',
    badgeTextColor: '#ffe8c8',
    ...REGION_FILTER_THEME,
  };
}

export const SeasonalSearchScreen: React.FC = () => {
  const route = useRoute<any>();
  const navigation = useNavigation<any>();

  const seasonParam = route.params?.season || 'Spring';
  const initialRegion = route.params?.regionId || null;

  const [selectedRegionId, setSelectedRegionId] = useState<string | null>(initialRegion);

  const { data: dishes, isLoading } = useSeasonalDishes(seasonParam, selectedRegionId);
  const theme = getSeasonalTheme(seasonParam);

  const handleBack = () => {
    if (navigation.canGoBack()) {
      navigation.goBack();
    } else {
      try {
        navigation.navigate('ExploreHome');
      } catch (e) {
        navigation.navigate('ExploreTab');
      }
    }
  };

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.scrollContent} showsVerticalScrollIndicator={false}>
      {/* 1. Hero Header with Signature Theme Gradient & Radial Glow */}
      <View style={[styles.heroWrapper, { shadowColor: theme.shadowColor, backgroundColor: theme.gradientColors[0] }]}>
        <LinearGradient
          colors={theme.gradientColors}
          start={{ x: 0, y: 0 }}
          end={{ x: 0.95, y: 1 }}
          style={styles.heroContainer}
        >
          {/* Layered SVG Ambient Radial Glow Accents */}
          <Svg
            style={StyleSheet.absoluteFill}
            width="100%"
            height="100%"
            pointerEvents="none"
          >
            <Defs>
              <RadialGradient id="glowTopRight" cx="86%" cy="18%" r="48%">
                <Stop offset="0%" stopColor={theme.glowColor1} stopOpacity="1" />
                <Stop offset="100%" stopColor="transparent" stopOpacity="0" />
              </RadialGradient>
              <RadialGradient id="glowLeft" cx="16%" cy="35%" r="35%">
                <Stop offset="0%" stopColor={theme.glowColor2} stopOpacity="1" />
                <Stop offset="100%" stopColor="transparent" stopOpacity="0" />
              </RadialGradient>
              <RadialGradient id="glowMidRight" cx="72%" cy="62%" r="42%">
                <Stop offset="0%" stopColor={theme.glowColor3} stopOpacity="1" />
                <Stop offset="100%" stopColor="transparent" stopOpacity="0" />
              </RadialGradient>
              <RadialGradient id="glowBottomLeft" cx="28%" cy="78%" r="38%">
                <Stop offset="0%" stopColor={theme.glowColor4} stopOpacity="1" />
                <Stop offset="100%" stopColor="transparent" stopOpacity="0" />
              </RadialGradient>
            </Defs>
            <Rect x="0" y="0" width="100%" height="100%" fill="url(#glowTopRight)" />
            <Rect x="0" y="0" width="100%" height="100%" fill="url(#glowLeft)" />
            <Rect x="0" y="0" width="100%" height="100%" fill="url(#glowMidRight)" />
            <Rect x="0" y="0" width="100%" height="100%" fill="url(#glowBottomLeft)" />
          </Svg>

          {/* Navigation Bar / Back button */}
          <TouchableOpacity
            style={styles.backButton}
            onPress={handleBack}
            activeOpacity={0.75}
            hitSlop={{ top: 14, bottom: 14, left: 14, right: 14 }}
          >
            <ArrowLeft size={21} color={theme.backColor} weight="bold" style={{ marginRight: 6 }} />
            <Text style={[styles.backText, { color: theme.backColor }]}>Back</Text>
          </TouchableOpacity>

          {/* Main Hero Typography & Content */}
          <View style={styles.heroContent}>
            <Text style={[styles.heroTitle, { color: theme.titleColor }]}>{theme.displayTitle}</Text>
            <Text style={[styles.heroQuote, { color: theme.quoteColor }]}>{theme.quote}</Text>
            <Text style={[styles.heroDescription, { color: theme.descColor }]}>{theme.desc}</Text>

            {/* Limited Season Badge */}
            <View
              style={[
                styles.badgeContainer,
                {
                  backgroundColor: theme.badgeBg,
                  borderColor: theme.badgeBorder,
                },
              ]}
            >
              <Text style={styles.badgeEmoji}>{theme.emoji}</Text>
              <Text style={[styles.badgeText, { color: theme.badgeTextColor }]}>{theme.badgeText}</Text>
            </View>
          </View>
        </LinearGradient>
      </View>

      {/* 2. Lower Content Section */}
      <View style={styles.lowerSection}>
        {/* Discover by Region Heading */}
        <Text style={[styles.regionSectionTitle, { color: theme.regionLabelColor }]}>Discover by region</Text>

        {/* Region Filter Tabs */}
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          style={styles.regionTabBar}
          contentContainerStyle={styles.regionTabContent}
        >
          {REGION_TABS.map((tab) => {
            const isSelected = selectedRegionId === tab.id;
            return (
              <TouchableOpacity
                key={tab.label}
                style={[
                  styles.regionTab,
                  isSelected
                    ? { backgroundColor: theme.tabSelectedBg, borderWidth: 0 }
                    : [styles.regionTabUnselected, { borderColor: theme.tabUnselectedBorder }],
                ]}
                onPress={() => setSelectedRegionId(tab.id)}
                activeOpacity={0.7}
              >
                <Text
                  style={[
                    styles.regionTabText,
                    isSelected ? { color: '#FFFFFF' } : { color: theme.tabUnselectedText },
                  ]}
                >
                  {tab.label}
                </Text>
              </TouchableOpacity>
            );
          })}
        </ScrollView>

        {/* 3. Seasonal Dishes Grid */}
        {isLoading ? (
          <GridSkeleton />
        ) : dishes && dishes.length > 0 ? (
          <View style={styles.gridContainer}>
            {dishes.map((dish) => (
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
            <Text style={styles.emptyText}>No seasonal dishes published for this region yet</Text>
          </View>
        )}
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#FFFFFF',
  },
  scrollContent: {
    paddingBottom: spacing.section,
  },
  heroWrapper: {
    borderBottomLeftRadius: 46,
    borderBottomRightRadius: 46,
    shadowOffset: { width: 0, height: 14 },
    shadowOpacity: 0.22,
    shadowRadius: 28,
    elevation: 8,
  },
  heroContainer: {
    borderBottomLeftRadius: 46,
    borderBottomRightRadius: 46,
    paddingTop: 54,
    paddingHorizontal: 24,
    paddingBottom: 38,
    minHeight: 406,
    position: 'relative',
    overflow: 'hidden',
  },
  backButton: {
    flexDirection: 'row',
    alignItems: 'center',
    alignSelf: 'flex-start',
    paddingVertical: 6,
    paddingRight: 12,
    marginBottom: 28,
    zIndex: 10,
  },
  backText: {
    fontSize: 15,
    fontFamily: typography.fontFamily.bodyMedium,
    fontWeight: '600',
    letterSpacing: -0.1,
  },
  heroContent: {
    maxWidth: 350,
    zIndex: 10,
  },
  heroTitle: {
    fontSize: 48,
    lineHeight: 52,
    fontFamily: typography.fontFamily.h1,
    fontWeight: '700',
    marginBottom: 18,
  },
  heroQuote: {
    fontSize: 17,
    lineHeight: 25,
    fontFamily: typography.fontFamily.bodyItalic,
    marginBottom: 12,
  },
  heroDescription: {
    fontSize: 15,
    lineHeight: 23,
    fontFamily: typography.fontFamily.body,
    fontWeight: '300',
    maxWidth: 335,
    marginBottom: 22,
  },
  badgeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    alignSelf: 'flex-start',
    borderWidth: 1,
    borderRadius: borderRadius.full,
    paddingHorizontal: 14,
    paddingVertical: 6,
    gap: 6,
  },
  badgeEmoji: {
    fontSize: 13,
  },
  badgeText: {
    fontSize: 11,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    letterSpacing: 1.2,
    textTransform: 'uppercase',
  },
  lowerSection: {
    paddingHorizontal: spacing.lg,
    paddingTop: 26,
  },
  regionSectionTitle: {
    fontSize: 11,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    textTransform: 'uppercase',
    letterSpacing: 2,
    marginBottom: 14,
  },
  regionTabBar: {
    marginBottom: spacing.lg,
  },
  regionTabContent: {
    gap: spacing.xs,
  },
  regionTab: {
    height: 32,
    borderRadius: borderRadius.full,
    paddingHorizontal: spacing.md,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.xs,
  },
  regionTabUnselected: {
    backgroundColor: '#FFFFFF',
    borderWidth: 1,
  },
  regionTabText: {
    fontSize: typography.fontSize.uiLabel,
    fontFamily: typography.fontFamily.bodyMedium,
    fontWeight: '500',
  },
  gridContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    gap: spacing.md,
  },
  gridItem: {
    width: '47%',
  },
  emptyCard: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    padding: spacing.xl,
    alignItems: 'center',
    marginTop: spacing.md,
    marginBottom: spacing.lg,
    ...shadows.hairline,
  },
  emptyText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
  },
});

export default SeasonalSearchScreen;
