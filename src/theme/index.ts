export const colors = {
  // 1.1 Core
  paper: '#FAF8F5',              // App background
  surface: '#FFFFFF',            // Cards, search bar, nav bar
  ink: '#1C1917',                // Headings, primary text
  body: '#44403C',               // Body/paragraph text
  rust: '#C2410C',               // Primary accent — CTAs, links, active nav, icons
  hairline: 'rgba(28, 25, 23, 0.12)', // Borders, dividers

  // Legacy & Alias Mappings
  primary: '#C2410C',            // rust
  primaryLight: '#E8ECF8',
  primaryDark: '#9A3412',
  secondary: '#D9622C',
  secondaryLight: '#FAF0E2',

  ai: '#C2410C',                 // rust alias
  aiTint: '#E8ECF8',             // indigo tint alias

  background: '#FAF8F5',         // paper
  card: '#FFFFFF',               // surface
  cardElevated: '#FFFFFF',

  textPrimary: '#1C1917',        // ink
  textSecondary: '#44403C',      // body
  textMuted: 'rgba(28, 25, 23, 0.45)',
  textOnPrimary: '#FFFFFF',

  border: 'rgba(28, 25, 23, 0.12)',
  borderLight: 'rgba(28, 25, 23, 0.06)',

  chipBackground: '#FFFFFF',
  chipSelectedBg: '#C2410C',
  chipSelectedText: '#FFFFFF',

  overlay: 'rgba(28, 25, 23, 0.4)',
  shadow: 'rgba(28, 25, 23, 0.08)',

  // 1.2 Seasonal accent (signature element)
  seasonal: {
    spring: '#DB5A73',
    summer: '#5B8C3E',
    autumn: '#D9622C',
    winter: '#4A7C9E',
  },

  // 1.3 Trust card system (exception palette)
  trustGreenTint: '#E4F0E1',
  trustGreenBadge: '#3D7A41',
  trustGreenHeadline: '#2F6B33',
  trustGreenLabel: '#4B7C4F',

  trustIndigoTint: '#E8ECF8',
  trustIndigoBadge: '#2E4C8C',
  trustIndigoLabel: '#3E4E7A',
  trustIndigoSubtext: '#5A6B95',

  cautionTint: '#F5E1E1',
  caution: '#C23B3B',

  // 1.4 Supporting
  peach: '#F3DFC5',              // "Did You Know?" callout background
  gold: '#E7A73E',               // Rating star (flagged)
};

export const spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,      // 2xl
  xxxl: 48,     // 3xl
  heading: 32,
  section: 48,
};

export const typography = {
  fontFamily: {
    japanese: 'NotoSansJP_900Black',
    display: 'PlayfairDisplay_700Bold',
    h1: 'PlayfairDisplay_700Bold',
    h2: 'PlayfairDisplay_700Bold',
    h3: 'PlayfairDisplay_700Bold',
    dishSubtitle: 'Figtree_500Medium',
    body: 'Figtree_400Regular',
    bodyMedium: 'Figtree_500Medium',
    bodySemiBold: 'Figtree_600SemiBold',
    bodyItalic: 'Figtree_400Regular_Italic',
    utility: 'IBMPlexMono_500Medium',
    utilitySemiBold: 'IBMPlexMono_600SemiBold',
  },
  fontSize: {
    xs: 12,
    monoLabel: 10,
    micro: 11,
    caption: 12,
    uiLabel: 13,
    sm: 14,
    body: 16,
    md: 16,
    h3: 18,
    xl: 20,
    englishSubtitle: 20,
    h2: 22,
    display: 22,
    xxl: 24,
    h1: 28,
    japaneseHeader: 36,
    hero: 36,
  },
  fontWeight: {
    regular: '400' as const,
    medium: '500' as const,
    semibold: '600' as const,
    bold: '700' as const,
    black: '900' as const,
  },
  lineHeight: {
    xs: 14,
    sm: 18,
    md: 22,
    lg: 26,
    xl: 28,
    xxl: 32,
    hero: 42,
  },
};

export const borderRadius = {
  sm: 8,        // radius-sm
  md: 12,       // radius-md
  lg: 20,       // radius-lg
  xl: 24,
  full: 999,    // radius-full (pill shape for primary CTA button)
};

export const shadows = {
  hairline: {
    borderWidth: 0.5,
    borderColor: 'rgba(28, 25, 23, 0.12)',
  },
  shadowFloat: {
    shadowColor: '#1C1917',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 12,
    elevation: 3,
  },
  // Legacy aliases
  sm: {
    borderWidth: 0.5,
    borderColor: 'rgba(28, 25, 23, 0.12)',
  },
  md: {
    borderWidth: 0.5,
    borderColor: 'rgba(28, 25, 23, 0.12)',
  },
  lg: {
    shadowColor: '#1C1917',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 12,
    elevation: 3,
  },
};

export const theme = {
  colors,
  spacing,
  typography,
  borderRadius,
  shadows,
};

export default theme;
