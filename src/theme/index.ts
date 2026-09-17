export const colors = {
  // 1.1 Core — dual role (system function + season)
  primary: '#EC4900',            // Primary accent — CTAs, links, active nav, primary badges (Autumn)
  success: '#49B019',            // Success — verified dietary status (Spring)
  info: '#3A51F5',               // Info — price/factual data (Winter)
  highlight: '#FFBF00',          // Highlight — "Did You Know," premium/featured tags (Summer)

  // 1.2 Derived tints (for cards/badges)
  successTint: '#E8F4E1',        // Dietary trust card background
  successDark: '#276312',        // Dietary trust card headline text
  successLabel: '#2F7A16',       // Dietary trust card label/subtext
  infoTint: '#E9EBFD',           // Price trust card background
  infoDark: '#2E3EC2',           // Price trust card label / headline
  infoSubtext: '#3E4BA8',        // Price trust card subtext
  highlightTint: '#FFF3D2',      // "Did You Know" callout background
  highlightIconInk: '#5A3D00',   // Icon color on highlight-tint badges

  // 1.3 Caution
  cautionTint: '#F5E1E1',
  caution: '#C23B3B',

  // 1.4 Neutrals
  paper: '#FAF8F5',              // App background
  surface: '#FFFFFF',            // Cards, search bar, nav bar
  ink: '#1C1917',                // Headings, primary text
  body: '#44403C',               // Body/paragraph text
  hairline: 'rgba(28, 25, 23, 0.14)', // Borders, dividers (1px firmer)

  // Backward-compatible aliases
  rust: '#EC4900',               // Primary alias
  primaryLight: '#FFF3D2',
  primaryDark: '#B83800',
  secondary: '#EC4900',
  secondaryLight: '#FFF3D2',

  ai: '#EC4900',
  aiTint: '#E9EBFD',

  background: '#FAF8F5',
  card: '#FFFFFF',
  cardElevated: '#FFFFFF',

  textPrimary: '#1C1917',
  textSecondary: '#44403C',
  textMuted: 'rgba(28, 25, 23, 0.45)',
  textOnPrimary: '#FFFFFF',

  border: 'rgba(28, 25, 23, 0.14)',
  borderLight: 'rgba(28, 25, 23, 0.08)',

  chipBackground: '#FFFFFF',
  chipSelectedBg: '#EC4900',
  chipSelectedText: '#FFFFFF',

  overlay: 'rgba(28, 25, 23, 0.4)',
  shadow: 'rgba(28, 25, 23, 0.08)',

  // Seasonal dual-role mapping
  seasonal: {
    spring: '#49B019',
    summer: '#FFBF00',
    autumn: '#EC4900',
    winter: '#3A51F5',
  },

  // Legacy Trust aliases for backward compatibility
  trustGreenTint: '#E8F4E1',
  trustGreenBadge: '#49B019',
  trustGreenHeadline: '#276312',
  trustGreenLabel: '#2F7A16',

  trustIndigoTint: '#E9EBFD',
  trustIndigoBadge: '#3A51F5',
  trustIndigoLabel: '#2E3EC2',
  trustIndigoSubtext: '#3E4BA8',

  peach: '#FFF3D2',              // Highlight tint alias
  gold: '#FFBF00',
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
    dishSubtitle: 'Figtree_600SemiBold',
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
    body: 14,
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
  sm: 8,        // radius-sm: inputs, icon buttons
  badge: 6,     // square-ish trust card badges
  md: 12,       // radius-md: cards, primary CTA button (rounded rectangle)
  lg: 16,       // radius-lg: modals, sheets (tightened from 20px)
  xl: 24,
  full: 999,    // radius-full: chips/pills only
};

export const shadows = {
  hairline: {
    borderWidth: 1,
    borderColor: 'rgba(28, 25, 23, 0.14)',
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
    borderWidth: 1,
    borderColor: 'rgba(28, 25, 23, 0.14)',
  },
  md: {
    borderWidth: 1,
    borderColor: 'rgba(28, 25, 23, 0.14)',
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
