import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Check, Info, Tag } from 'phosphor-react-native';
import { colors, typography, spacing, borderRadius } from '../theme';
import { Dish } from '../types';

interface TrustCardsProps {
  dish: Dish;
  formattedPrice: string;
}

export const TrustCards: React.FC<TrustCardsProps> = ({ dish, formattedPrice }) => {
  const isVegetarianVerified = dish.vegetarian_status === 'Verified vegetarian';
  const isHalalVerified = dish.halal_status === 'Verified halal';
  const isDietaryVerified = isVegetarianVerified || isHalalVerified;

  const dietaryHeadline = isVegetarianVerified
    ? 'Verified Vegetarian'
    : isHalalVerified
    ? 'Verified Halal'
    : 'Not Yet Reviewed';

  const dietarySupporting = dish.dietary_guidance || (isDietaryVerified ? 'Confirmed ingredients.' : 'Standard broth & ingredients.');

  return (
    <View style={styles.container}>
      {/* 1. Dietary Trust Card */}
      <View
        style={[
          styles.trustCard,
          isDietaryVerified ? styles.greenCardBg : styles.cautionCardBg,
        ]}
      >
        <View style={styles.topRow}>
          <View
            style={[
              styles.badge,
              isDietaryVerified ? styles.greenBadgeBg : styles.cautionBadgeBg,
            ]}
          >
            {isDietaryVerified ? (
              <Check size={12} color="#FFFFFF" weight="bold" />
            ) : (
              <Info size={12} color="#FFFFFF" weight="bold" />
            )}
          </View>
          <Text
            style={[
              styles.monoLabel,
              isDietaryVerified ? styles.greenLabelText : styles.cautionLabelText,
            ]}
          >
            DIETARY TRUST
          </Text>
        </View>

        <Text
          style={[
            styles.headline,
            isDietaryVerified ? styles.greenHeadlineText : styles.cautionHeadlineText,
          ]}
        >
          {dietaryHeadline}
        </Text>

        <Text
          style={[
            styles.subtext,
            isDietaryVerified ? styles.greenSubtextText : styles.cautionSubtextText,
          ]}
        >
          {dietarySupporting}
        </Text>
      </View>

      {/* 2. Typical Price Card */}
      <View style={[styles.trustCard, styles.indigoCardBg]}>
        <View style={styles.topRow}>
          <View style={[styles.badge, styles.indigoBadgeBg]}>
            <Tag size={12} color="#FFFFFF" weight="bold" />
          </View>
          <Text style={[styles.monoLabel, styles.indigoLabelText]}>
            TYPICAL PRICE
          </Text>
        </View>

        <Text style={[styles.headline, styles.monoPriceHeadline]}>
          {formattedPrice}
        </Text>

        <Text style={[styles.subtext, styles.indigoSubtextText]}>
          Average per serving
        </Text>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    gap: spacing.md,
    marginBottom: spacing.md, // Reduced gap under boxes to 16px
  },
  trustCard: {
    flex: 1,
    borderRadius: borderRadius.md,
    padding: spacing.lg, // 16px internal padding
  },
  greenCardBg: {
    backgroundColor: colors.successTint, // #E8F4E1
  },
  cautionCardBg: {
    backgroundColor: colors.cautionTint, // #F5E1E1
  },
  indigoCardBg: {
    backgroundColor: colors.infoTint,    // #E9EBFD
  },
  topRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: spacing.xs,
  },
  badge: {
    width: 20,
    height: 20,
    borderRadius: borderRadius.badge, // 6px square-ish badge per §5.4
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.xs,
  },
  greenBadgeBg: {
    backgroundColor: colors.success,     // #49B019
  },
  cautionBadgeBg: {
    backgroundColor: colors.caution,     // #C23B3B
  },
  indigoBadgeBg: {
    backgroundColor: colors.info,        // #3A51F5
  },
  monoLabel: {
    fontSize: typography.fontSize.monoLabel, // 10px
    fontFamily: typography.fontFamily.utilitySemiBold, // IBM Plex Mono
    letterSpacing: 0.5,
  },
  greenLabelText: {
    color: colors.successLabel,          // #2F7A16
  },
  cautionLabelText: {
    color: colors.caution,               // #C23B3B
  },
  indigoLabelText: {
    color: colors.infoDark,              // #2E3EC2
  },
  headline: {
    fontSize: 15,
    fontFamily: typography.fontFamily.bodySemiBold,
    marginBottom: 2,
  },
  greenHeadlineText: {
    color: colors.successDark,           // #276312
  },
  cautionHeadlineText: {
    color: colors.caution,               // #C23B3B
  },
  monoPriceHeadline: {
    fontFamily: typography.fontFamily.utilitySemiBold, // IBM Plex Mono
    color: colors.infoDark,              // #2E3EC2 dark variant
  },
  subtext: {
    fontSize: 13,
    fontFamily: typography.fontFamily.body,
    lineHeight: 18,
  },
  greenSubtextText: {
    color: colors.successLabel,          // #2F7A16
  },
  cautionSubtextText: {
    color: colors.caution,
  },
  indigoSubtextText: {
    color: colors.infoSubtext,           // #3E4BA8
  },
});

export default TrustCards;
