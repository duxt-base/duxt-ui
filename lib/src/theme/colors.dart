/// DuxtUI Color System - Matches Nuxt UI semantic colors
library;

/// Semantic color names used throughout DuxtUI
enum DColor {
  primary,
  secondary,
  success,
  info,
  warning,
  error,
  neutral,
}

/// Color shade levels (50-950)
enum DColorShade {
  s50,
  s100,
  s200,
  s300,
  s400,
  s500,
  s600,
  s700,
  s800,
  s900,
  s950,
}

/// Default color palette mapping to Tailwind colors
/// Primary = Green, Secondary = Blue, etc (matches Nuxt UI defaults)
const Map<DColor, String> defaultColorMapping = {
  DColor.primary: 'green',
  DColor.secondary: 'blue',
  DColor.success: 'green',
  DColor.info: 'blue',
  DColor.warning: 'yellow',
  DColor.error: 'red',
  DColor.neutral: 'slate',
};

/// Get Tailwind class for a semantic color
String colorClass(DColor color, [int shade = 500]) {
  final base = defaultColorMapping[color] ?? 'gray';
  return '$base-$shade';
}

/// Get background class for a color
String bgColor(DColor color, [int shade = 500]) => 'bg-${colorClass(color, shade)}';

/// Get text class for a color
String textColor(DColor color, [int shade = 500]) => 'text-${colorClass(color, shade)}';

/// Get border/ring class for a color
String ringColor(DColor color, [int shade = 500]) => 'ring-${colorClass(color, shade)}';

/// Semantic text colors based on Nuxt UI
class DTextColors {
  static const String highlighted = 'text-gray-900 dark:text-white';
  static const String muted = 'text-gray-500 dark:text-gray-400';
  static const String dimmed = 'text-gray-400 dark:text-gray-500';
  static const String inverted = 'text-white dark:text-gray-900';
  static const String defaultText = 'text-gray-700 dark:text-gray-200';
}

/// Semantic background colors based on Nuxt UI
class DBgColors {
  static const String defaultBg = 'bg-white dark:bg-gray-900';
  static const String elevated = 'bg-gray-50 dark:bg-gray-800';
  static const String inverted = 'bg-gray-900 dark:bg-white';
  static const String muted = 'bg-gray-100 dark:bg-gray-800';
}

/// Semantic ring/border colors based on Nuxt UI
class DRingColors {
  static const String defaultRing = 'ring-gray-200 dark:ring-gray-800';
  static const String accented = 'ring-gray-300 dark:ring-gray-700';
}

/// Semantic divide colors
class DDivideColors {
  static const String defaultDivide = 'divide-gray-200 dark:divide-gray-800';
}

/// Legacy color hex values (for compatibility)
class DuxtColors {
  // Primary (Indigo)
  static const primary50 = '#eef2ff';
  static const primary100 = '#e0e7ff';
  static const primary500 = '#6366f1';
  static const primary600 = '#4f46e5';
  static const primary700 = '#4338ca';

  // Gray
  static const gray50 = '#f9fafb';
  static const gray100 = '#f3f4f6';
  static const gray200 = '#e5e7eb';
  static const gray300 = '#d1d5db';
  static const gray400 = '#9ca3af';
  static const gray500 = '#6b7280';
  static const gray600 = '#4b5563';
  static const gray700 = '#374151';
  static const gray800 = '#1f2937';
  static const gray900 = '#111827';

  // Success (Green)
  static const success50 = '#f0fdf4';
  static const success500 = '#22c55e';
  static const success600 = '#16a34a';

  // Warning (Yellow)
  static const warning50 = '#fffbeb';
  static const warning500 = '#f59e0b';
  static const warning600 = '#d97706';

  // Error (Red)
  static const error50 = '#fef2f2';
  static const error500 = '#ef4444';
  static const error600 = '#dc2626';

  // Info (Blue)
  static const info50 = '#eff6ff';
  static const info500 = '#3b82f6';
  static const info600 = '#2563eb';
}
