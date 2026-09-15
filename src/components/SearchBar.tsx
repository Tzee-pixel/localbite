import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, TextInput } from 'react-native';
import { MagnifyingGlass, Sliders, XCircle } from 'phosphor-react-native';
import { colors, typography, spacing, borderRadius, shadows } from '../theme';

interface SearchBarProps {
  placeholder?: string;
  onPress?: () => void;
  editable?: boolean;
  value?: string;
  onChangeText?: (text: string) => void;
  onClear?: () => void;
}

export const SearchBar: React.FC<SearchBarProps> = ({
  placeholder = 'Search by location, dish or season...',
  onPress,
  editable = false,
  value,
  onChangeText,
  onClear,
}) => {
  if (editable) {
    return (
      <View style={styles.container}>
        <MagnifyingGlass size={20} color={colors.textMuted} style={styles.icon} />
        <TextInput
          style={styles.input}
          placeholder={placeholder}
          placeholderTextColor={colors.textMuted}
          value={value}
          onChangeText={onChangeText}
          autoCapitalize="none"
          autoCorrect={false}
        />
        {value && value.length > 0 ? (
          <TouchableOpacity onPress={onClear} style={styles.clearButton}>
            <XCircle size={18} color={colors.textMuted} weight="fill" />
          </TouchableOpacity>
        ) : (
          <Sliders size={18} color={colors.textMuted} />
        )}
      </View>
    );
  }

  return (
    <TouchableOpacity onPress={onPress} activeOpacity={0.8}>
      <View style={styles.container}>
        <MagnifyingGlass size={20} color={colors.textMuted} style={styles.icon} />
        <Text style={[styles.placeholderText, Boolean(value) && styles.activeText]} numberOfLines={1}>
          {value || placeholder}
        </Text>
        <Sliders size={18} color={colors.textMuted} />
      </View>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.surface,
    borderRadius: borderRadius.full,
    paddingHorizontal: spacing.lg + 2,
    paddingVertical: 18,
    minHeight: 60,
    marginBottom: spacing.lg,
    ...shadows.hairline,
  },
  icon: {
    marginRight: spacing.sm,
  },
  input: {
    flex: 1,
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.ink,
    padding: 0,
  },
  placeholderText: {
    flex: 1,
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.textMuted,
  },
  activeText: {
    color: colors.ink,
    fontFamily: typography.fontFamily.bodyMedium,
  },
  clearButton: {
    padding: spacing.xs,
  },
});

export default SearchBar;
