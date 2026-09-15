import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';
import Svg, { Path, Circle } from 'react-native-svg';
import { colors, typography, spacing } from '../theme';
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
    BadgeIcon: React.FC<any>;
    BgIcon: React.FC<any>;
  }
> = {
  Autumn: {
    bgColor: '#C45C1A',
    shadowColor: '#692F0E',
    bgIconColorLight: 'rgba(232, 138, 63, 0.35)',
    bgIconColorDark: 'rgba(143, 60, 22, 0.45)',
    BadgeIcon: LeafIcon,
    BgIcon: FilledLeafIcon,
  },
  Spring: {
    bgColor: '#D42B76',
    shadowColor: '#6E0D3A',
    bgIconColorLight: 'rgba(255, 179, 218, 0.35)',
    bgIconColorDark: 'rgba(145, 15, 75, 0.45)',
    BadgeIcon: FlowerIcon,
    BgIcon: FlowerIcon,
  },
  Summer: {
    bgColor: '#E89214',
    shadowColor: '#784400',
    bgIconColorLight: 'rgba(255, 220, 120, 0.35)',
    bgIconColorDark: 'rgba(170, 95, 0, 0.45)',
    BadgeIcon: SunIcon,
    BgIcon: SunIcon,
  },
  Winter: {
    bgColor: '#2B4C7E',
    shadowColor: '#0F213E',
    bgIconColorLight: 'rgba(145, 188, 245, 0.35)',
    bgIconColorDark: 'rgba(20, 48, 90, 0.45)',
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
        <View style={styles.iconCircle}>
          <BadgeIconComponent size={28} color="#FFF8ED" strokeWidth={2.2} />
        </View>

        <View style={styles.textStack}>
          <Text style={styles.titleText}>It's {activeSeason}</Text>
          <Text style={styles.subtitleText}>
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
    borderRadius: 12,
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
    color: '#FFFFFF',
    letterSpacing: -0.4,
    lineHeight: 22,
  },
  subtitleText: {
    fontSize: 14,
    fontFamily: typography.fontFamily.bodyMedium,
    color: '#FFFFFF',
    lineHeight: 18,
    marginTop: 4,
  },
});

export default SeasonalHintBanner;
