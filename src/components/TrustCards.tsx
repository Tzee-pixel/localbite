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
    borderRadius: borderRadius.md + 2,
    padding: spacing.lg, // 16px internal padding
  },
  greenCardBg: {
    backgroundColor: colors.trustGreenTint, // #E4F0E1
  },
  cautionCardBg: {
    backgroundColor: colors.cautionTint,     // #F5E1E1
  },
  indigoCardBg: {
    backgroundColor: colors.trustIndigoTint,  // #E8ECF8
  },
  topRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: spacing.xs,
  },
  badge: {
    width: 20,
    height: 20,
    borderRadius: 10,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.xs,
  },
  greenBadgeBg: {
    backgroundColor: colors.trustGreenBadge, // #3D7A41
  },
  cautionBadgeBg: {
    backgroundColor: colors.caution,         // #C23B3B
  },
  indigoBadgeBg: {
    backgroundColor: colors.trustIndigoBadge, // #2E4C8C
  },
  monoLabel: {
    fontSize: typography.fontSize.monoLabel, // 10px
    fontFamily: typography.fontFamily.utilitySemiBold, // IBM Plex Mono
    letterSpacing: 0.5,
  },
  greenLabelText: {
    color: colors.trustGreenLabel,           // #4B7C4F
  },
  cautionLabelText: {
    color: colors.caution,                   // #C23B3B
  },
  indigoLabelText: {
    color: colors.trustIndigoLabel,          // #3E4E7A
  },
  headline: {
    fontSize: 15,
    fontFamily: typography.fontFamily.bodySemiBold,
    marginBottom: 2,
  },
  greenHeadlineText: {
    color: colors.trustGreenHeadline,        // #2F6B33
  },
  cautionHeadlineText: {
    color: colors.caution,                   // #C23B3B
  },
  monoPriceHeadline: {
    fontFamily: typography.fontFamily.utilitySemiBold, // IBM Plex Mono
    color: colors.ink,                       // #1C1917
  },
  subtext: {
    fontSize: 13, // 13px per user request
    fontFamily: typography.fontFamily.body,
    lineHeight: 18,
  },
  greenSubtextText: {
    color: colors.trustGreenLabel,
  },
  cautionSubtextText: {
    color: colors.caution,
  },
  indigoSubtextText: {
    color: colors.trustIndigoSubtext,        // #5A6B95
  },
});

export default TrustCards;
