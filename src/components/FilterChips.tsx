import React from 'react';
import { ScrollView, Text, StyleSheet, TouchableOpacity, View } from 'react-native';
import { colors, typography, spacing, borderRadius } from '../theme';

export const FILTER_OPTIONS = [
  'Quick Bite',
  'Vegetarian',
  'Dine-in',
  'Halal',
  'Seasonal Peak',
] as const;

export type FilterChipOption = typeof FILTER_OPTIONS[number];

// Dot color indicator category rotation per §5.5
const CHIP_DOT_COLORS: Record<string, string> = {
  'Quick Bite': colors.seasonal.autumn,
  'Vegetarian': colors.seasonal.summer,
  'Dine-in': colors.rust,
  'Halal': colors.seasonal.summer,
  'Seasonal Peak': colors.seasonal.spring,
};

interface FilterChipsProps {
  selectedFilters: string[];
  onToggleFilter: (filter: string) => void;
}

export const FilterChips: React.FC<FilterChipsProps> = ({ selectedFilters, onToggleFilter }) => {
  return (
    <View style={styles.container}>
      {FILTER_OPTIONS.map((option) => {
        const isSelected = selectedFilters.includes(option);
        const dotColor = CHIP_DOT_COLORS[option] || colors.rust;

        return (
          <TouchableOpacity
            key={option}
            style={[styles.chip, isSelected ? styles.chipSelected : styles.chipUnselected]}
            onPress={() => onToggleFilter(option)}
            activeOpacity={0.7}
          >
            <View
              style={[
                styles.dot,
                { backgroundColor: isSelected ? '#FFFFFF' : dotColor },
              ]}
            />
            <Text style={[styles.chipText, isSelected ? styles.chipTextSelected : styles.chipTextUnselected]}>
              {option}
            </Text>
          </TouchableOpacity>
        );
      })}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    alignItems: 'center',
    gap: 10,
    marginBottom: spacing.lg,
  },
  chip: {
    height: 34,
    flexDirection: 'row',
    alignItems: 'center',
    borderRadius: borderRadius.full,
    paddingHorizontal: 13,
    marginBottom: spacing.xs,
  },
  chipUnselected: {
    backgroundColor: colors.surface,
    borderWidth: 0.5,
    borderColor: colors.hairline,
  },
  chipSelected: {
    backgroundColor: colors.rust,
    borderWidth: 0,
  },
  dot: {
    width: 6,
    height: 6,
    borderRadius: 3,
    marginRight: spacing.xs,
  },
  chipText: {
    fontSize: typography.fontSize.uiLabel,
    fontFamily: typography.fontFamily.bodyMedium,
  },
  chipTextUnselected: {
    color: colors.ink,
  },
  chipTextSelected: {
    color: '#FFFFFF',
  },
});

export default FilterChips;
