import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Linking, Platform, Image } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import {
  CaretLeft,
  NavigationArrow,
  MapTrifold,
  Globe,
  CreditCard,
  BowlFood,
} from 'phosphor-react-native';
import { colors, typography, spacing, borderRadius, shadows } from '../theme';
import { useLocation } from '../context/LocationContext';

export const SettingsScreen: React.FC = () => {
  const navigation = useNavigation<any>();
  const { permissionStatus, exploreReason, resetOnboarding, requestPermission } = useLocation();

  const handleOpenSystemSettings = () => {
    if (Platform.OS === 'ios') {
      Linking.openURL('app-settings:');
    } else {
      Linking.openSettings();
    }
  };

  const isGranted = permissionStatus === 'granted';

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content}>
      {/* Top Navigation Header */}
      <View style={styles.topHeader}>
        <TouchableOpacity
          style={styles.backButton}
          onPress={() => navigation.goBack()}
          activeOpacity={0.7}
          accessibilityLabel="Back"
        >
          <CaretLeft size={20} color={colors.ink} weight="bold" />
        </TouchableOpacity>

        <Text style={styles.headerTitle}>Settings</Text>

        <View style={styles.headerRightSpacer} />
      </View>

      {/* 1. Location Services Card */}
      <View style={styles.cardContainer}>
        <Text style={styles.cardSectionTitle}>LOCATION SERVICES</Text>

        <View style={styles.row}>
          <View style={styles.rowLeft}>
            <View style={styles.rowIconBadge}>
              <NavigationArrow size={18} color={colors.ink} weight="regular" />
            </View>
            <Text style={styles.rowLabel}>Permission Status</Text>
          </View>
          <View style={[styles.statusBadge, isGranted ? styles.statusGrantedBadge : styles.statusDeniedBadge]}>
            <Text style={[styles.statusDot, isGranted ? styles.statusGrantedDot : styles.statusDeniedDot]}>•</Text>
            <Text style={[styles.statusBadgeText, isGranted ? styles.statusGrantedText : styles.statusDeniedText]}>
              {permissionStatus.toUpperCase()}
            </Text>
          </View>
        </View>

        <View style={styles.row}>
          <View style={styles.rowLeft}>
            <View style={styles.rowIconBadge}>
              <MapTrifold size={18} color={colors.ink} weight="regular" />
            </View>
            <Text style={styles.rowLabel}>Explore Context</Text>
          </View>
          <View style={[styles.statusBadge, isGranted ? styles.statusGrantedBadge : styles.statusDeniedBadge]}>
            <Text style={[styles.statusDot, isGranted ? styles.statusGrantedDot : styles.statusDeniedDot]}>•</Text>
            <Text style={[styles.statusBadgeText, isGranted ? styles.statusGrantedText : styles.statusDeniedText]}>
              {exploreReason ? exploreReason.toUpperCase() : 'UNKNOWN'}
            </Text>
          </View>
        </View>

        <View style={styles.hairlineDivider} />

        {permissionStatus === 'denied' ? (
          <TouchableOpacity style={styles.primaryOutlineButton} onPress={handleOpenSystemSettings} activeOpacity={0.8}>
            <Text style={styles.primaryOutlineButtonText}>Open Device System Settings</Text>
          </TouchableOpacity>
        ) : (
          <TouchableOpacity style={styles.primaryOutlineButton} onPress={requestPermission} activeOpacity={0.8}>
            <Text style={styles.primaryOutlineButtonText}>Re-request Location Access</Text>
          </TouchableOpacity>
        )}

        <TouchableOpacity style={styles.tintedDangerButton} onPress={resetOnboarding} activeOpacity={0.8}>
          <Text style={styles.tintedDangerButtonText}>Reset Onboarding Permission (Testing)</Text>
        </TouchableOpacity>
      </View>

      {/* 2. Preferences & Units Card */}
      <View style={styles.cardContainer}>
        <Text style={styles.cardSectionTitle}>PREFERENCES & UNITS</Text>

        <View style={styles.row}>
          <View style={styles.rowLeft}>
            <View style={styles.rowIconBadge}>
              <Globe size={18} color={colors.ink} weight="regular" />
            </View>
            <Text style={styles.rowLabel}>Language</Text>
          </View>
          <View style={styles.greyPillBadge}>
            <Text style={styles.greyPillBadgeText}>English</Text>
          </View>
        </View>

        <View style={styles.row}>
          <View style={styles.rowLeft}>
            <View style={styles.rowIconBadge}>
              <CreditCard size={18} color={colors.ink} weight="regular" />
            </View>
            <Text style={styles.rowLabel}>Currency Display</Text>
          </View>
          <View style={styles.greyPillBadge}>
            <Text style={styles.greyPillBadgeText}>¥ JPY (Yen)</Text>
          </View>
        </View>
      </View>

      {/* 3. About LocalBite Card */}
      <View style={styles.cardContainer}>
        <Text style={styles.cardSectionTitle}>ABOUT LOCALBITE</Text>

        <View style={styles.aboutHeaderRow}>
          <View style={styles.appIconBadge}>
            <Image source={require('../../assets/localbite-logo.jpg')} style={{ width: 48, height: 48, borderRadius: 14 }} />
          </View>
          <View style={styles.aboutTextStack}>
            <Text style={styles.appNameText}>LocalBite</Text>
            <Text style={styles.appVersionText}>Version 3.0</Text>
          </View>
        </View>

        <View style={styles.hairlineDivider} />

        <Text style={styles.aboutBodyText}>
          A dish-first food discovery app designed specifically for travelers seeking authentic, local food experiences in Japan.
        </Text>
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
    padding: spacing.md + 2,
    paddingTop: spacing.xl,
    paddingBottom: spacing.xxxl,
  },
  topHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: spacing.xl,
  },
  backButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#FFFFFF',
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: colors.hairline,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.04,
    shadowRadius: 4,
    elevation: 2,
  },
  headerTitle: {
    fontSize: 20,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    color: colors.ink,
  },
  headerRightSpacer: {
    width: 40,
  },
  cardContainer: {
    backgroundColor: '#FFFFFF',
    borderRadius: borderRadius.lg,
    padding: spacing.lg,
    marginBottom: spacing.lg,
    borderWidth: 1,
    borderColor: colors.hairline,
    ...shadows.shadowFloat,
  },
  cardSectionTitle: {
    fontSize: 12,
    fontFamily: typography.fontFamily.utilitySemiBold,
    fontWeight: '700',
    color: colors.textMuted,
    letterSpacing: 0.8,
    textTransform: 'uppercase',
    marginBottom: spacing.md,
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.md,
  },
  rowLeft: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  rowIconBadge: {
    width: 34,
    height: 34,
    borderRadius: borderRadius.sm,
    backgroundColor: '#F5F2EC',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.md,
  },
  rowLabel: {
    fontSize: 15,
    fontFamily: typography.fontFamily.bodyMedium,
    fontWeight: '600',
    color: colors.ink,
  },
  statusBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 10,
    paddingVertical: 5,
    borderRadius: 12,
  },
  statusGrantedBadge: {
    backgroundColor: colors.successTint,
  },
  statusDeniedBadge: {
    backgroundColor: colors.cautionTint,
  },
  statusDot: {
    fontSize: 14,
    marginRight: 4,
    lineHeight: 16,
  },
  statusGrantedDot: {
    color: colors.success,
  },
  statusDeniedDot: {
    color: colors.caution,
  },
  statusBadgeText: {
    fontSize: 11,
    fontFamily: typography.fontFamily.utilitySemiBold,
    fontWeight: '700',
    letterSpacing: 0.4,
  },
  statusGrantedText: {
    color: colors.successDark,
  },
  statusDeniedText: {
    color: colors.caution,
  },
  hairlineDivider: {
    height: 1,
    backgroundColor: colors.hairline,
    marginVertical: spacing.md,
  },
  primaryOutlineButton: {
    width: '100%',
    backgroundColor: '#FFFFFF',
    borderWidth: 1,
    borderColor: colors.hairline,
    borderRadius: borderRadius.md,
    paddingVertical: 14,
    alignItems: 'center',
    marginBottom: spacing.sm + 2,
  },
  primaryOutlineButtonText: {
    fontSize: 14,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    color: colors.ink,
  },
  tintedDangerButton: {
    width: '100%',
    backgroundColor: colors.cautionTint,
    borderWidth: 1,
    borderColor: '#E8B6A8',
    borderRadius: borderRadius.md,
    paddingVertical: 14,
    alignItems: 'center',
  },
  tintedDangerButtonText: {
    fontSize: 14,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    color: colors.caution,
  },
  greyPillBadge: {
    backgroundColor: '#F3F0EC',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 8,
  },
  greyPillBadgeText: {
    fontSize: 13,
    fontFamily: typography.fontFamily.bodyMedium,
    color: colors.body,
  },
  aboutHeaderRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: spacing.xs,
  },
  appIconBadge: {
    width: 48,
    height: 48,
    borderRadius: 14,
    backgroundColor: colors.primary,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.md,
  },
  aboutTextStack: {
    flex: 1,
  },
  appNameText: {
    fontSize: 18,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    color: colors.ink,
  },
  appVersionText: {
    fontSize: 14,
    fontFamily: typography.fontFamily.body,
    color: colors.textMuted,
    marginTop: 2,
  },
  aboutBodyText: {
    fontSize: 14,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    lineHeight: 20,
  },
});

export default SettingsScreen;
