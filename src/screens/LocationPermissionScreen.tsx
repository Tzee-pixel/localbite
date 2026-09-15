import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ActivityIndicator } from 'react-native';
import { MapPin } from 'phosphor-react-native';
import { colors, typography, spacing, borderRadius, shadows } from '../theme';
import { useLocation } from '../context/LocationContext';

export const LocationPermissionScreen: React.FC = () => {
  const { requestPermission, skipPermission, isLoadingLocation } = useLocation();

  return (
    <View style={styles.outerContainer}>
      <View style={styles.card}>
        <View style={styles.iconCircle}>
          <MapPin size={28} color={colors.ai} weight="fill" />
        </View>

        <Text style={styles.title}>Local Speciality Finder</Text>
        <Text style={styles.body}>
          Find what to eat right here, right now. Discover authentic regional dishes, seasonal delicacies, and local ordering tips nearby.
        </Text>

        <TouchableOpacity
          style={styles.primaryButton}
          onPress={requestPermission}
          disabled={isLoadingLocation}
          activeOpacity={0.88}
        >
          {isLoadingLocation ? (
            <ActivityIndicator color="#FFFFFF" size="small" />
          ) : (
            <Text style={styles.primaryButtonText}>Enable Location Access</Text>
          )}
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.secondaryButton}
          onPress={skipPermission}
          disabled={isLoadingLocation}
          activeOpacity={0.85}
        >
          <Text style={styles.secondaryButtonText}>Explore Regions Manually</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  outerContainer: {
    flex: 1,
    backgroundColor: colors.paper,
    justifyContent: 'center',
    alignItems: 'center',
    padding: spacing.xl,
  },
  card: {
    width: '100%',
    maxWidth: 360,
    backgroundColor: colors.surface,
    borderRadius: borderRadius.lg,
    padding: spacing.xxl,
    ...shadows.shadowFloat,
  },
  iconCircle: {
    width: 56,
    height: 56,
    borderRadius: 28,
    backgroundColor: colors.aiTint,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: spacing.lg,
  },
  title: {
    fontSize: typography.fontSize.display,
    fontFamily: typography.fontFamily.display,
    color: colors.ink,
    marginBottom: spacing.md,
    lineHeight: typography.lineHeight.xxl,
  },
  body: {
    fontSize: typography.fontSize.body,
    fontFamily: typography.fontFamily.body,
    color: colors.textSecondary,
    lineHeight: 22,
    marginBottom: spacing.xxl,
  },
  primaryButton: {
    backgroundColor: colors.ai,
    borderRadius: borderRadius.sm,
    paddingVertical: spacing.lg,
    paddingHorizontal: spacing.xl,
    alignItems: 'center',
    marginBottom: spacing.md,
  },
  primaryButtonText: {
    color: '#FFFFFF',
    fontSize: typography.fontSize.md,
    fontFamily: typography.fontFamily.bodySemiBold,
  },
  secondaryButton: {
    backgroundColor: colors.surface,
    borderColor: colors.ai,
    borderWidth: 1.5,
    borderRadius: borderRadius.sm,
    paddingVertical: spacing.lg,
    paddingHorizontal: spacing.xl,
    alignItems: 'center',
  },
  secondaryButtonText: {
    color: colors.ai,
    fontSize: typography.fontSize.md,
    fontFamily: typography.fontFamily.bodySemiBold,
  },
});

export default LocationPermissionScreen;
