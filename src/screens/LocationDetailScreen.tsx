import React from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Image } from 'react-native';
import { useRoute, useNavigation } from '@react-navigation/native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { LinearGradient } from 'expo-linear-gradient';
import { ArrowLeft, MapPin, CaretRight, Train, Buildings } from 'phosphor-react-native';
import { useLocationDetail } from '../lib/queries';
import { getStationById } from '../lib/stationRegistry';
import { getLocationHeroImageSource } from '../lib/locationImages';
import DishCard from '../components/DishCard';
import { GridSkeleton } from '../components/SkeletonLoader';
import { colors, typography, spacing, borderRadius, shadows } from '../theme';

export const LocationDetailScreen: React.FC = () => {
  const route = useRoute<any>();
  const navigation = useNavigation<any>();
  const insets = useSafeAreaInsets();

  const { locationId = 'karuizawa' } = route.params || {};

  const { data: detailData, isLoading, isError } = useLocationDetail(locationId);

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

  if (isLoading) {
    return (
      <View style={[styles.container, { paddingTop: Math.max(insets.top + 10, 24), paddingHorizontal: spacing.lg }]}>
        <TouchableOpacity
          style={styles.backButtonInline}
          onPress={handleBack}
          hitSlop={{ top: 12, bottom: 12, left: 12, right: 12 }}
        >
          <View style={styles.backIconCircle}>
            <ArrowLeft size={16} color={colors.rust} weight="bold" />
          </View>
          <Text style={styles.backText}>Back</Text>
        </TouchableOpacity>
        <GridSkeleton />
      </View>
    );
  }

  if (isError || !detailData) {
    return (
      <View style={[styles.container, { paddingTop: Math.max(insets.top + 10, 24), paddingHorizontal: spacing.lg }]}>
        <TouchableOpacity
          style={styles.backButtonInline}
          onPress={handleBack}
          hitSlop={{ top: 12, bottom: 12, left: 12, right: 12 }}
        >
          <View style={styles.backIconCircle}>
            <ArrowLeft size={16} color={colors.rust} weight="bold" />
          </View>
          <Text style={styles.backText}>Back</Text>
        </TouchableOpacity>
        <Text style={styles.errorText}>Location information unavailable ({locationId})</Text>
      </View>
    );
  }

  const { location, dishes, parentLocation } = detailData;

  const editorialDescription =
    location.food_focus ||
    `Alpine Highland Cuisine. Known for fresh mountain spring water, local produce, and artisanal specialties.`;

  const rawPrefecture = location.prefecture_id || 'tokyo';
  const prefectureName = rawPrefecture.charAt(0).toUpperCase() + rawPrefecture.slice(1);
  const regionName = location.region_id
    ? location.region_id.charAt(0).toUpperCase() + location.region_id.slice(1)
    : 'Kanto';

  // Extra station metadata if applicable
  const stationRecord = getStationById(location.location_id);
  const transitLines = stationRecord?.lines || [];

  const categoryLabel = location.type ? String(location.type).toUpperCase() : 'CITY';
  const heroImageSource = getLocationHeroImageSource(location);

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
      {/* Full-Bleed Edge-to-Edge Hero Photograph */}
      <View style={styles.imageContainer}>
        <Image source={heroImageSource} style={styles.heroImage} resizeMode="cover" />
        {/* Subtle Bottom Black Fade Gradient */}
        <LinearGradient
          colors={['transparent', 'rgba(0, 0, 0, 0.25)', 'rgba(0, 0, 0, 0.65)']}
          locations={[0.2, 0.65, 1]}
          style={StyleSheet.absoluteFill}
          pointerEvents="none"
        />
        {/* Floating Back Navigation Button */}
        <TouchableOpacity
          style={[styles.floatingBackButton, { top: Math.max(insets.top + 8, 16) }]}
          onPress={handleBack}
          activeOpacity={0.85}
          hitSlop={{ top: 12, bottom: 12, left: 12, right: 12 }}
        >
          <ArrowLeft size={15} color={colors.ink} weight="bold" />
          <Text style={styles.floatingBackText}>Back</Text>
        </TouchableOpacity>
      </View>

      {/* Main Content (Seamless with background) */}
      <View style={styles.bodyContent}>
        {/* Parent Location Breadcrumb Pill (if applicable) */}
        {parentLocation && (
          <View style={styles.breadcrumbContainer}>
            <TouchableOpacity
              style={styles.breadcrumbTouch}
              onPress={() => navigation.navigate('LocationDetail', { locationId: parentLocation.location_id })}
              activeOpacity={0.7}
            >
              <Buildings size={13} color={colors.rust} weight="bold" />
              <Text style={styles.breadcrumbParent}>{parentLocation.location_name}</Text>
            </TouchableOpacity>
            <CaretRight size={11} color={colors.textMuted} weight="bold" style={styles.breadcrumbArrow} />
            <View style={styles.breadcrumbCurrentBadge}>
              <Text style={styles.breadcrumbCurrent}>{location.location_name}</Text>
            </View>
          </View>
        )}

        {/* Top Row: Type Tag & Region */}
        <View style={styles.metaHeaderRow}>
          <View style={styles.typeBadge}>
            <Text style={styles.typeBadgeText}>{categoryLabel}</Text>
          </View>
          <Text style={styles.regionItalicText}>
            {prefectureName} • {regionName}
          </Text>
        </View>

        {/* Location Title */}
        <Text style={styles.locationTitle}>{location.location_name}</Text>

        {/* Subtitle with MapPin */}
        <View style={styles.pinSubtitleRow}>
          <MapPin size={16} color={colors.rust} weight="fill" style={styles.pinIcon} />
          <Text style={styles.pinSubtitleText}>{prefectureName}, Japan</Text>
        </View>

        {/* Editorial Note (if present) */}
        {editorialDescription && editorialDescription.trim() !== '' && (
          <Text style={styles.editorialDescription}>{editorialDescription}</Text>
        )}

        {/* Transit Lines (if present) */}
        {transitLines.length > 0 && (
          <View style={styles.transitRow}>
            <Train size={13} color={colors.rust} weight="bold" />
            <Text style={styles.transitText}>{transitLines.slice(0, 2).join(', ')}</Text>
          </View>
        )}

        {/* Hairline Divider */}
        <View style={styles.hairlineDivider} />

        {/* "Top Local Specialities" 2-Column Grid */}
        <View style={styles.sectionHeader}>
          <Text style={styles.sectionHeadingH2}>Top Local Specialities</Text>
        </View>

        {dishes.length > 0 ? (
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
            <Text style={styles.emptyText}>No published specialities found for {location.location_name} yet</Text>
          </View>
        )}
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.paper,
  },
  content: {
    paddingBottom: spacing.section,
  },
  imageContainer: {
    width: '100%',
    height: 240,
    backgroundColor: '#E7E2DA',
    position: 'relative',
  },
  heroImage: {
    width: '100%',
    height: '100%',
  },
  floatingBackButton: {
    position: 'absolute',
    left: 16,
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 255, 255, 0.94)',
    paddingVertical: 7,
    paddingHorizontal: 13,
    borderRadius: borderRadius.full,
    gap: 6,
    borderWidth: 1,
    borderColor: 'rgba(0, 0, 0, 0.06)',
  },
  floatingBackText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
  },
  bodyContent: {
    paddingHorizontal: spacing.lg,
    paddingTop: spacing.lg,
  },
  breadcrumbContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    alignSelf: 'flex-start',
    backgroundColor: '#F2EDE6',
    borderRadius: borderRadius.full,
    paddingVertical: 5,
    paddingHorizontal: 10,
    marginBottom: spacing.md,
    borderWidth: 1,
    borderColor: 'rgba(28, 25, 23, 0.06)',
  },
  breadcrumbTouch: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  breadcrumbParent: {
    fontSize: typography.fontSize.xs,
    fontFamily: typography.fontFamily.bodyMedium,
    color: colors.rust,
  },
  breadcrumbArrow: {
    marginHorizontal: 3,
  },
  breadcrumbCurrentBadge: {
    paddingHorizontal: 2,
  },
  breadcrumbCurrent: {
    fontSize: typography.fontSize.xs,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
  },
  metaHeaderRow: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 12,
  },
  typeBadge: {
    backgroundColor: '#F3EFE9',
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 3,
    alignSelf: 'flex-start',
  },
  typeBadgeText: {
    fontSize: 11,
    fontFamily: typography.fontFamily.utilitySemiBold,
    color: '#8E4A23',
    letterSpacing: 0.8,
    textTransform: 'uppercase',
  },
  regionItalicText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodyItalic,
    color: '#78716C',
  },
  locationTitle: {
    fontSize: 28,
    fontFamily: typography.fontFamily.display,
    color: '#1C1917',
    letterSpacing: -0.5,
    marginBottom: 6,
    lineHeight: 34,
  },
  pinSubtitleRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    marginBottom: 12,
  },
  pinIcon: {
    marginTop: -1,
  },
  pinSubtitleText: {
    fontSize: 14,
    fontFamily: typography.fontFamily.bodyItalic,
    color: '#57534E',
  },
  editorialDescription: {
    fontSize: typography.fontSize.sm + 1,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    lineHeight: 22,
    marginTop: 4,
    marginBottom: 12,
  },
  transitRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    marginBottom: 12,
  },
  transitText: {
    fontSize: 12,
    fontFamily: typography.fontFamily.bodyMedium,
    color: colors.rust,
  },
  hairlineDivider: {
    height: 1,
    backgroundColor: '#E7E2DA',
    width: '100%',
    marginTop: 6,
    marginBottom: 20,
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: spacing.md,
  },
  sectionHeadingH2: {
    fontSize: typography.fontSize.h2,
    fontFamily: typography.fontFamily.h2,
    color: colors.ink,
    flex: 1,
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
    ...shadows.hairline,
  },
  emptyText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
  },
  errorText: {
    fontSize: typography.fontSize.md,
    fontFamily: typography.fontFamily.body,
    color: colors.textMuted,
    marginTop: spacing.xl,
  },
  backButtonInline: {
    flexDirection: 'row',
    alignItems: 'center',
    alignSelf: 'flex-start',
    marginBottom: spacing.md,
    gap: 6,
  },
  backIconCircle: {
    width: 28,
    height: 28,
    borderRadius: 14,
    backgroundColor: '#FAF0E6',
    alignItems: 'center',
    justifyContent: 'center',
  },
  backText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.rust,
  },
});

export default LocationDetailScreen;

