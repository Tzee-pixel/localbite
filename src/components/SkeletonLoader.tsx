import React from 'react';
import { View, StyleSheet } from 'react-native';
import { borderRadius, spacing } from '../theme';

export const CarouselSkeleton: React.FC = () => {
  return (
    <View style={styles.carouselRow}>
      <View style={styles.carouselSkeletonCard} />
      <View style={styles.carouselSkeletonCard} />
    </View>
  );
};

export const GridSkeleton: React.FC = () => {
  return (
    <View style={styles.gridRow}>
      <View style={styles.gridSkeletonCard} />
      <View style={styles.gridSkeletonCard} />
    </View>
  );
};

const styles = StyleSheet.create({
  carouselRow: {
    flexDirection: 'row',
    marginBottom: spacing.lg,
  },
  carouselSkeletonCard: {
    width: 240,
    height: 200,
    backgroundColor: '#E0E0E0',
    borderRadius: borderRadius.md,
    marginRight: spacing.md,
  },
  gridRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    gap: spacing.md,
    marginBottom: spacing.md,
  },
  gridSkeletonCard: {
    flex: 1,
    height: 220,
    backgroundColor: '#E0E0E0',
    borderRadius: borderRadius.md,
  },
});
