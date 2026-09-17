import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';
import Svg, { Path, Circle } from 'react-native-svg';
import { colors, typography, spacing, borderRadius } from '../theme';
import { getCurrentSeason } from '../lib/queries';

export type SeasonType = 'Spring' | 'Summer' | 'Autumn' | 'Winter';

interface SeasonalHintBannerProps {
  season?: SeasonType;
  onPress?: () => void;
}

// 1. Autumn Leaf Icons
const LeafIcon: React.FC<{ size?: number; color?: string; strokeWidth?: number; style?: any }> = ({
  size = 24,
  color = '#FFFFFF',
  strokeWidth = 2,
  style,
}) => (
  <Svg
    width={size}
    height={size}
    viewBox="0 0 24 24"
    fill="none"
    stroke={color}
    strokeWidth={strokeWidth}
    strokeLinecap="round"
    strokeLinejoin="round"
    style={style}
  >
    <Path d="M11 20A9 9 0 0 1 2.5 8.5 9.9 9.9 0 0 1 11 2c5.5 0 10.5 4.5 10.5 10.5a9.9 9.9 0 0 1-6.5 9.5M11 20v-8M21.5 12.5C16 12.5 11 17.5 11 20" />
  </Svg>
);

const FilledLeafIcon: React.FC<{ size?: number; color?: string; style?: any }> = ({
  size = 24,
  color = '#FFFFFF',
  style,
}) => (
  <Svg width={size} height={size} viewBox="0 0 24 24" fill={color} style={style}>
    <Path d="M11 20A9 9 0 0 1 2.5 8.5 9.9 9.9 0 0 1 11 2c5.5 0 10.5 4.5 10.5 10.5a9.9 9.9 0 0 1-6.5 9.5Z" />
  </Svg>
);

// 2. Spring Flower Icon
const FlowerIcon: React.FC<{ size?: number; color?: string; strokeWidth?: number; style?: any }> = ({
  size = 24,
  color = '#FFFFFF',
  strokeWidth = 2,
  style,
}) => (
  <Svg
    width={size}
    height={size}
    viewBox="0 0 24 24"
    fill="none"
    stroke={color}
    strokeWidth={strokeWidth}
    strokeLinecap="round"
    strokeLinejoin="round"
    style={style}
  >
    <Circle cx="12" cy="12" r="3" />
    <Path d="M12 16.5A4.5 4.5 0 1 1 7.5 12M12 7.5A4.5 4.5 0 1 1 16.5 12M16.5 12A4.5 4.5 0 1 1 12 16.5M7.5 12A4.5 4.5 0 1 1 12 7.5" />
    <Path d="M12 19.5v3M12 1.5v3M19.5 12h3M1.5 12h3" />
  </Svg>
);

// 3. Summer Sun Icon
const SunIcon: React.FC<{ size?: number; color?: string; strokeWidth?: number; style?: any }> = ({
  size = 24,
  color = '#FFFFFF',
  strokeWidth = 2,
  style,
}) => (
  <Svg
    width={size}
    height={size}
    viewBox="0 0 24 24"
    fill="none"
    stroke={color}
    strokeWidth={strokeWidth}
    strokeLinecap="round"
    strokeLinejoin="round"
    style={style}
  >
    <Circle cx="12" cy="12" r="4" />
    <Path d="M12 2v2M12 20v2M4.93 4.93l1.41 1.41M17.66 17.66l1.41 1.41M2 12h2M20 12h2M6.34 17.66l-1.41 1.41M19.07 4.93l-1.41 1.41" />
  </Svg>
);

// 4. Winter Snowflake Icon
const SnowflakeIcon: React.FC<{ size?: number; color?: string; strokeWidth?: number; style?: any }> = ({
  size = 24,
  color = '#FFFFFF',
  strokeWidth = 2,
  style,
}) => (
  <Svg
    width={size}
    height={size}
    viewBox="0 0 24 24"
    fill="none"
    stroke={color}
    strokeWidth={strokeWidth}
    strokeLinecap="round"
    strokeLinejoin="round"
    style={style}
  >
    <Path d="m10 20-1.25-2.5L6 18M14 20l1.25-2.5L18 18M10 4l-1.25 2.5L6 6M14 4l1.25 2.5L18 6M2 12h20M12 2v20M20 10l-2.5 1.25L18 14M4 10l2.5 1.25L6 14M20 14l-2.5-1.25L18 10M4 14l2.5-1.25L6 10" />
  </Svg>
);

const SEASON_THEMES: Record<
  SeasonType,
  {
    bgColor: string;
    shadowColor: string;
    bgIconColorLight: string;
    bgIconColorDark: string;
    textColor?: string;
    iconColor?: string;
    iconCircleBg?: string;
    BadgeIcon: React.FC<any>;
    BgIcon: React.FC<any>;
  }
> = {
  Autumn: {
    bgColor: colors.primary, // #EC4900
    shadowColor: '#802600',
    bgIconColorLight: 'rgba(255, 255, 255, 0.25)',
    bgIconColorDark: 'rgba(128, 38, 0, 0.35)',
    textColor: '#FFFFFF',
    iconColor: '#FFFFFF',
    BadgeIcon: LeafIcon,
    BgIcon: FilledLeafIcon,
  },
  Spring: {
    bgColor: colors.success, // #49B019
    shadowColor: '#20550B',
    bgIconColorLight: 'rgba(255, 255, 255, 0.25)',
    bgIconColorDark: 'rgba(32, 85, 11, 0.35)',
    textColor: '#FFFFFF',
    iconColor: '#FFFFFF',
    BadgeIcon: FlowerIcon,
    BgIcon: FlowerIcon,
  },
  Summer: {
    bgColor: colors.highlight, // #FFBF00
    shadowColor: '#806000',
    bgIconColorLight: 'rgba(255, 255, 255, 0.35)',
    bgIconColorDark: 'rgba(90, 61, 0, 0.25)',
    textColor: colors.highlightIconInk, // #5A3D00 for high contrast on amber
    iconColor: colors.highlightIconInk,
    iconCircleBg: 'rgba(90, 61, 0, 0.12)',
    BadgeIcon: SunIcon,
    BgIcon: SunIcon,
  },
  Winter: {
    bgColor: colors.info, // #3A51F5
    shadowColor: '#1A2578',
    bgIconColorLight: 'rgba(255, 255, 255, 0.25)',
    bgIconColorDark: 'rgba(26, 37, 120, 0.35)',
    textColor: '#FFFFFF',
    iconColor: '#FFFFFF',
    BadgeIcon: SnowflakeIcon,
    BgIcon: SnowflakeIcon,
  },
};

export const SeasonalHintBanner: React.FC<SeasonalHintBannerProps> = ({
  season,
  onPress,
}) => {
  const activeSeason: SeasonType = (season || getCurrentSeason()) as SeasonType;
  const theme = SEASON_THEMES[activeSeason] || SEASON_THEMES.Autumn;

  const BadgeIconComponent = theme.BadgeIcon;
  const BgIconComponent = theme.BgIcon;
  const textColor = theme.textColor || '#FFFFFF';
  const iconColor = theme.iconColor || '#FFFFFF';

  return (
    <TouchableOpacity
      style={[
        styles.container,
        {
          backgroundColor: theme.bgColor,
          shadowColor: theme.shadowColor,
        },
      ]}
      onPress={onPress}
      activeOpacity={0.9}
      accessibilityRole="button"
      accessibilityLabel={`Seasonal search hint for ${activeSeason}`}
    >
      {/* Absolute Decorative Floating Background Icons */}
      <View style={styles.floating1Wrapper} pointerEvents="none">
        <BgIconComponent size={54} color={theme.bgIconColorLight} />
      </View>
      <View style={styles.floating2Wrapper} pointerEvents="none">
        <BgIconComponent size={37} color={theme.bgIconColorDark} />
      </View>
      <View style={styles.floating3Wrapper} pointerEvents="none">
        <BgIconComponent size={27} color={theme.bgIconColorLight} />
      </View>
      <View style={styles.floating4Wrapper} pointerEvents="none">
        <BgIconComponent size={23} color={theme.bgIconColorDark} />
      </View>

      {/* Main Content Layout */}
      <View style={styles.contentRow}>
        <View
          style={[
            styles.iconCircle,
            theme.iconCircleBg ? { backgroundColor: theme.iconCircleBg } : undefined,
          ]}
        >
          <BadgeIconComponent size={28} color={iconColor} strokeWidth={2.2} />
        </View>

        <View style={styles.textStack}>
          <Text style={[styles.titleText, { color: textColor }]}>It's {activeSeason}</Text>
          <Text style={[styles.subtitleText, { color: textColor }]}>
            Try searching "seasonal" to see what's peaking
          </Text>
        </View>
      </View>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  container: {
    width: '100%',
    borderRadius: borderRadius.md,
    overflow: 'hidden',
    marginBottom: spacing.lg,
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.14,
    shadowRadius: 24,
    elevation: 4,
  },
  floating1Wrapper: {
    position: 'absolute',
    right: -8,
    top: -16,
    transform: [{ rotate: '22deg' }],
  },
  floating2Wrapper: {
    position: 'absolute',
    right: '22%',
    bottom: -13,
    transform: [{ rotate: '-28deg' }],
  },
  floating3Wrapper: {
    position: 'absolute',
    left: '42%',
    top: -12,
    transform: [{ rotate: '64deg' }],
  },
  floating4Wrapper: {
    position: 'absolute',
    left: '27%',
    bottom: -7,
    transform: [{ rotate: '20deg' }],
  },
  contentRow: {
    flexDirection: 'row',
    minHeight: 90,
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 16,
    gap: 16,
  },
  iconCircle: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: 'rgba(255, 248, 237, 0.15)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  textStack: {
    flex: 1,
    justifyContent: 'center',
  },
  titleText: {
    fontSize: 19,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '800',
    letterSpacing: -0.4,
    lineHeight: 22,
  },
  subtitleText: {
    fontSize: 14,
    fontFamily: typography.fontFamily.bodyMedium,
    lineHeight: 18,
    marginTop: 4,
  },
});

export default SeasonalHintBanner;
