export const colors = {
  // 1.1 Core — dual role (system function + season, tuned for 100% WCAG AA compliance)
  primary: '#D33800',            // Primary accent — CTAs, links, active nav, primary badges (Autumn, 4.84:1 on white, 4.57:1 on paper)
  success: '#2A7E0B',            // Success — verified dietary status (Spring, 5.14:1 with white text, 4.52:1 on successTint)
  info: '#3A51F5',               // Info — price/factual data (Winter, 5.71:1 with white icon)
  highlight: '#FFBF00',          // Highlight — "Did You Know," premium/featured tags (Summer)

  // 1.2 Derived tints (for cards/badges)
  successTint: '#E8F4E1',        // Dietary trust card background
  successDark: '#276312',        // Dietary trust card headline text (6.41:1 on successTint)
  successLabel: '#2F7A16',       // Dietary trust card label/subtext (4.71:1 on successTint)
  infoTint: '#E9EBFD',           // Price trust card background
  infoDark: '#2E3EC2',           // Price trust card label / headline (6.87:1 on infoTint)
  infoSubtext: '#3E4BA8',        // Price trust card subtext (6.40:1 on infoTint)
  highlightTint: '#FFF3D2',      // "Did You Know" callout background
  highlightIconInk: '#5A3D00',   // Icon color on highlight-tint badges (6.04:1 on highlight)

  // 1.3 Caution (tuned for 100% WCAG AA)
  cautionTint: '#F5E1E1',
  caution: '#B82C2C',            // 4.87:1 on cautionTint, 6.11:1 on white

  // 1.4 Neutrals
  paper: '#FAF8F5',              // App background
  surface: '#FFFFFF',            // Cards, search bar, nav bar
  ink: '#1C1917',                // Headings, primary text (16.5:1 on paper, 17.5:1 on surface)
  body: '#44403C',               // Body/paragraph text (9.69:1 on paper, 10.27:1 on surface)
  hairline: 'rgba(28, 25, 23, 0.14)', // Borders, dividers (1px firmer)

  // Backward-compatible aliases
  rust: '#D33800',               // Primary alias
  primaryLight: '#FFF3D2',
  primaryDark: '#B83800',
  secondary: '#D33800',
  secondaryLight: '#FFF3D2',

  ai: '#D33800',
  aiTint: '#E9EBFD',

  background: '#FAF8F5',
  card: '#FFFFFF',
  cardElevated: '#FFFFFF',

  textPrimary: '#1C1917',
  textSecondary: '#44403C',
  textMuted: 'rgba(28, 25, 23, 0.64)', // 5.24:1 on white, 5.13:1 on paper (WCAG AA pass)
  textOnPrimary: '#FFFFFF',

  border: 'rgba(28, 25, 23, 0.14)',
  borderLight: 'rgba(28, 25, 23, 0.08)',

  chipBackground: '#FFFFFF',
  chipSelectedBg: '#D33800',
  chipSelectedText: '#FFFFFF',

  overlay: 'rgba(28, 25, 23, 0.4)',
  shadow: 'rgba(28, 25, 23, 0.08)',

  // Seasonal dual-role mapping
  seasonal: {
    spring: '#2A7E0B',
    summer: '#FFBF00',
    autumn: '#D33800',
    winter: '#3A51F5',
  },

  // Legacy Trust aliases for backward compatibility
  trustGreenTint: '#E8F4E1',
  trustGreenBadge: '#2A7E0B',
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
