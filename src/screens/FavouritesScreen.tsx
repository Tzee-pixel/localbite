import React, { useState, useCallback } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Image } from 'react-native';
import { useNavigation, useFocusEffect } from '@react-navigation/native';
import { Bookmark, CaretRight, Compass } from 'phosphor-react-native';
import { getFavouriteDishIds } from '../lib/favourites';
import { MOCK_DISHES } from '../lib/mockData';
import { colors, typography, spacing, borderRadius, shadows } from '../theme';
import { getDishPrimaryImageSource } from '../lib/dishImages';
import { useFeaturedDishes } from '../lib/queries';

export const FavouritesScreen: React.FC = () => {
  const navigation = useNavigation<any>();
  const [favouriteDishIds, setFavouriteDishIds] = useState<string[]>([]);
  const { data: allDishes, isLoading } = useFeaturedDishes();

  useFocusEffect(
    useCallback(() => {
      let isMounted = true;
      getFavouriteDishIds().then((ids) => {
        if (isMounted) setFavouriteDishIds(ids);
      });
      return () => {
        isMounted = false;
      };
    }, [])
  );

  const savedDishes = (allDishes || []).filter((d) => favouriteDishIds.includes(d.dish_id));

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content}>
      <Text style={styles.title}>Favourites</Text>

      {isLoading ? (
        <Text style={styles.loadingText}>Loading saved dishes...</Text>
      ) : savedDishes.length > 0 ? (
        <View style={styles.dishesList}>
          {savedDishes.map((dish) => (
            <TouchableOpacity
              key={dish.dish_id}
              style={styles.dishRow}
              onPress={() => navigation.navigate('DishDetail', { dishId: dish.dish_id })}
              activeOpacity={0.85}
            >
              <Image
                source={getDishPrimaryImageSource(dish)}
                style={styles.thumb}
              />
              <View style={styles.info}>
                <Text style={styles.dishName}>{dish.dish_name}</Text>
                <Text style={styles.japaneseName}>{dish.japanese_name}</Text>
                <Text style={styles.summary} numberOfLines={1}>
                  {dish.summary}
                </Text>
              </View>
              <CaretRight size={18} color={colors.textMuted} />
            </TouchableOpacity>
          ))}
        </View>
      ) : (
        /* Empty State */
        <View style={styles.emptyStateContainer}>
          <View style={styles.emptyIconBox}>
            <Bookmark size={32} color={colors.rust} weight="regular" />
          </View>
          <Text style={styles.emptyTitle}>No saved dishes yet</Text>
          <Text style={styles.emptySubtitle}>
            Save regional delicacies while exploring to build your personal Japan food bucket list.
          </Text>

          <TouchableOpacity
            style={styles.exploreCtaButton}
            onPress={() => navigation.navigate('ExploreTab')}
            activeOpacity={0.85}
          >
            <Compass size={18} color="#FFFFFF" weight="fill" style={{ marginRight: 6 }} />
            <Text style={styles.exploreCtaText}>Discover Regional Specialities</Text>
          </TouchableOpacity>
        </View>
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
  title: {
    fontSize: typography.fontSize.h2,
    fontFamily: typography.fontFamily.display, // Playfair Display 700 Bold
    color: colors.ink,
    marginBottom: spacing.xl,
  },
  loadingText: {
    fontSize: typography.fontSize.md,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
  },
  dishesList: {
    gap: spacing.md,
  },
  dishRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: spacing.md,
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    padding: spacing.md,
    ...shadows.hairline,
  },
  thumb: {
    width: 60,
    height: 60,
    borderRadius: borderRadius.sm,
    marginRight: spacing.md,
    backgroundColor: '#EAE6DF',
  },
  info: {
    flex: 1,
  },
  dishName: {
    fontSize: typography.fontSize.md,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
  },
  japaneseName: {
    fontSize: typography.fontSize.xs + 1,
    fontFamily: typography.fontFamily.japanese,
    color: colors.rust,
    marginBottom: 2,
  },
  summary: {
    fontSize: typography.fontSize.xs,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
  },
  emptyStateContainer: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.lg,
    padding: spacing.xxl,
    alignItems: 'center',
    marginTop: spacing.md,
    ...shadows.hairline,
  },
  emptyIconBox: {
    width: 64,
    height: 64,
    borderRadius: 32,
    backgroundColor: colors.trustIndigoTint,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: spacing.md,
  },
  emptyTitle: {
    fontSize: typography.fontSize.h3,
    fontFamily: typography.fontFamily.h3,
    color: colors.ink,
    marginBottom: spacing.xs,
  },
  emptySubtitle: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    textAlign: 'center',
    lineHeight: 20,
    marginBottom: spacing.xl,
  },
  exploreCtaButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.rust,
    borderRadius: borderRadius.full, // radius-full pill shape
    paddingVertical: spacing.md,
    paddingHorizontal: spacing.xl,
  },
  exploreCtaText: {
    color: '#FFFFFF',
    fontSize: typography.fontSize.sm + 1,
    fontFamily: typography.fontFamily.bodySemiBold,
  },
});

export default FavouritesScreen;
