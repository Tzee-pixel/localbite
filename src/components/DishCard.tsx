import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, Image, TouchableOpacity, ActivityIndicator } from 'react-native';
import { Bookmark } from 'phosphor-react-native';
import { Dish } from '../types';
import { colors, typography, spacing, borderRadius } from '../theme';
import { isDishFavourite, toggleFavouriteDishId } from '../lib/favourites';
import { getDishPrimaryImageSource } from '../lib/dishImages';

interface DishCardProps {
  dish: Dish & { distance_km?: number };
  variant?: 'grid' | 'carousel' | 'horizontal';
  onPress: () => void;
}

export const DishCard: React.FC<DishCardProps> = ({ dish, variant = 'grid', onPress }) => {
  const [imageLoading, setImageLoading] = useState(true);
  const [isSaved, setIsSaved] = useState(false);

  useEffect(() => {
    if (dish.dish_id) {
      isDishFavourite(dish.dish_id).then(setIsSaved);
    }
  }, [dish.dish_id]);

  const handleToggleBookmark = async (e: any) => {
    e.stopPropagation();
    if (!dish.dish_id) return;
    const newState = await toggleFavouriteDishId(dish.dish_id);
    setIsSaved(newState);
  };

  const imageSource = getDishPrimaryImageSource(dish);

  if (variant === 'carousel' || variant === 'horizontal') {
    return (
      <TouchableOpacity
        style={styles.horizontalCard}
        onPress={onPress}
        activeOpacity={0.88}
      >
        <View style={styles.horizontalImageContainer}>
          {imageLoading && (
            <View style={styles.imagePlaceholder}>
              <ActivityIndicator size="small" color={colors.textMuted} />
            </View>
          )}
          <Image
            source={imageSource}
            style={styles.image}
            resizeMode="cover"
            onLoadEnd={() => setImageLoading(false)}
          />
          {dish.distance_km !== undefined && (
            <View style={styles.distanceBadge}>
              <Text style={styles.distanceBadgeText}>~{dish.distance_km} km away</Text>
            </View>
          )}
        </View>

        <View style={styles.horizontalContent}>
          <View>
            <View style={styles.horizontalHeaderRow}>
              <Text style={styles.horizontalDishName} numberOfLines={1}>
                {dish.dish_name}
              </Text>
              <TouchableOpacity style={styles.inlineBookmark} onPress={handleToggleBookmark} activeOpacity={0.8}>
                <Bookmark
                  size={16}
                  color={isSaved ? colors.primary : 'rgba(28, 25, 23, 0.55)'}
                  weight={isSaved ? 'fill' : 'regular'}
                />
              </TouchableOpacity>
            </View>
            <Text style={styles.horizontalSummary} numberOfLines={2}>
              {dish.summary}
            </Text>
          </View>

          <TouchableOpacity style={styles.knowMoreButton} onPress={onPress}>
            <Text style={styles.knowMoreText}>Know More &gt;</Text>
          </TouchableOpacity>
        </View>
      </TouchableOpacity>
    );
  }

  return (
    <TouchableOpacity
      style={[styles.card, styles.gridCard]}
      onPress={onPress}
      activeOpacity={0.88}
    >
      <View style={styles.imageContainer}>
        {imageLoading && (
          <View style={styles.imagePlaceholder}>
            <ActivityIndicator size="small" color={colors.textMuted} />
          </View>
        )}
        <Image
          source={imageSource}
          style={styles.image}
          resizeMode="cover"
          onLoadEnd={() => setImageLoading(false)}
        />

        {/* Save Bookmark Overlay per §4 */}
        <TouchableOpacity style={styles.bookmarkButton} onPress={handleToggleBookmark} activeOpacity={0.8}>
          <Bookmark
            size={16}
            color={isSaved ? colors.primary : 'rgba(28, 25, 23, 0.55)'}
            weight={isSaved ? 'fill' : 'regular'}
          />
        </TouchableOpacity>

        {dish.distance_km !== undefined && (
          <View style={styles.distanceBadge}>
            <Text style={styles.distanceBadgeText}>~{dish.distance_km} km away</Text>
          </View>
        )}
      </View>

      <View style={styles.content}>
        <Text style={styles.dishName} numberOfLines={1}>
          {dish.dish_name}
        </Text>
        <Text style={styles.summary} numberOfLines={2}>
          {dish.summary}
        </Text>

        <TouchableOpacity style={styles.knowMoreButton} onPress={onPress}>
          <Text style={styles.knowMoreText}>Know More &gt;</Text>
        </TouchableOpacity>
      </View>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  card: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    overflow: 'hidden',
    borderWidth: 1,
    borderColor: colors.hairline,
  },
  gridCard: {
    flex: 1,
    marginBottom: spacing.md,
  },
  horizontalCard: {
    flexDirection: 'row',
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    overflow: 'hidden',
    borderWidth: 1,
    borderColor: colors.hairline,
    width: 310,
    height: 120,
    marginRight: spacing.md,
  },
  horizontalImageContainer: {
    width: 120,
    height: 120,
    backgroundColor: '#EAE6DF',
    position: 'relative',
  },
  horizontalContent: {
    flex: 1,
    padding: spacing.sm + 2,
    justifyContent: 'space-between',
  },
  horizontalHeaderRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 2,
  },
  horizontalDishName: {
    flex: 1,
    fontSize: typography.fontSize.md,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
    marginRight: spacing.xs,
  },
  inlineBookmark: {
    padding: 2,
  },
  horizontalSummary: {
    fontSize: typography.fontSize.xs + 1,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    lineHeight: 16,
  },
  imageContainer: {
    width: '100%',
    aspectRatio: 4 / 3, // 4:3 photo crop per §5.4
    backgroundColor: '#EAE6DF',
    position: 'relative',
  },
  imagePlaceholder: {
    ...StyleSheet.absoluteFill,
    backgroundColor: '#EAE6DF',
    justifyContent: 'center',
    alignItems: 'center',
  },
  image: {
    width: '100%',
    height: '100%',
  },
  bookmarkButton: {
    position: 'absolute',
    top: spacing.xs + 2,
    right: spacing.xs + 2,
    backgroundColor: 'rgba(255, 255, 255, 0.92)',
    borderRadius: borderRadius.full,
    padding: spacing.xs,
    zIndex: 3,
  },
  distanceBadge: {
    position: 'absolute',
    bottom: spacing.xs + 2,
    left: spacing.xs + 2,
    backgroundColor: 'rgba(28, 25, 23, 0.75)',
    borderRadius: borderRadius.sm,
    paddingHorizontal: spacing.xs + 2,
    paddingVertical: 2,
    zIndex: 2,
  },
  distanceBadgeText: {
    color: '#FFFFFF',
    fontSize: typography.fontSize.monoLabel,
    fontFamily: typography.fontFamily.utility,
  },
  content: {
    padding: spacing.md,
    backgroundColor: colors.surface,
  },
  dishName: {
    fontSize: typography.fontSize.md,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
    marginBottom: spacing.xs,
  },
  summary: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    lineHeight: 18,
    marginBottom: spacing.sm,
  },
  knowMoreButton: {
    alignSelf: 'flex-start',
  },
  knowMoreText: {
    fontSize: typography.fontSize.xs + 1,
    fontFamily: typography.fontFamily.bodyMedium,
    color: colors.primary,
  },
});

export default DishCard;
