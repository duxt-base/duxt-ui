
/// Color with light and dark mode variants
class ThemeColor {
  final String light;
  final String dark;

  const ThemeColor(this.light, {String? dark}) : dark = dark ?? light;

  /// Get the CSS variable value based on mode
  String get lightValue => light;
  String get darkValue => dark;
}

/// Named color token for CSS variables
class ColorToken {
  final String name;
  final String light;
  final String dark;

  const ColorToken(this.name, this.light, {String? dark}) : dark = dark ?? light;

  /// CSS variable name
  String get cssVar => '--$name';

  /// CSS variable reference
  String get ref => 'var($cssVar)';
}

/// Pre-defined theme colors matching Nuxt UI / Tailwind
class ThemeColors {
  // Slate
  static const slate = _ColorScale(
    $50: '#f8fafc', $100: '#f1f5f9', $200: '#e2e8f0', $300: '#cbd5e1',
    $400: '#94a3b8', $500: '#64748b', $600: '#475569', $700: '#334155',
    $800: '#1e293b', $900: '#0f172a', $950: '#020617',
  );

  // Gray
  static const gray = _ColorScale(
    $50: '#f9fafb', $100: '#f3f4f6', $200: '#e5e7eb', $300: '#d1d5db',
    $400: '#9ca3af', $500: '#6b7280', $600: '#4b5563', $700: '#374151',
    $800: '#1f2937', $900: '#111827', $950: '#030712',
  );

  // Green (Primary)
  static const green = _ColorScale(
    $50: '#f0fdf4', $100: '#dcfce7', $200: '#bbf7d0', $300: '#86efac',
    $400: '#4ade80', $500: '#22c55e', $600: '#16a34a', $700: '#15803d',
    $800: '#166534', $900: '#14532d', $950: '#052e16',
  );

  // Blue (Secondary)
  static const blue = _ColorScale(
    $50: '#eff6ff', $100: '#dbeafe', $200: '#bfdbfe', $300: '#93c5fd',
    $400: '#60a5fa', $500: '#3b82f6', $600: '#2563eb', $700: '#1d4ed8',
    $800: '#1e40af', $900: '#1e3a8a', $950: '#172554',
  );

  // Red (Error)
  static const red = _ColorScale(
    $50: '#fef2f2', $100: '#fee2e2', $200: '#fecaca', $300: '#fca5a5',
    $400: '#f87171', $500: '#ef4444', $600: '#dc2626', $700: '#b91c1c',
    $800: '#991b1b', $900: '#7f1d1d', $950: '#450a0a',
  );

  // Yellow (Warning)
  static const yellow = _ColorScale(
    $50: '#fefce8', $100: '#fef9c3', $200: '#fef08a', $300: '#fde047',
    $400: '#facc15', $500: '#eab308', $600: '#ca8a04', $700: '#a16207',
    $800: '#854d0e', $900: '#713f12', $950: '#422006',
  );

  // Amber
  static const amber = _ColorScale(
    $50: '#fffbeb', $100: '#fef3c7', $200: '#fde68a', $300: '#fcd34d',
    $400: '#fbbf24', $500: '#f59e0b', $600: '#d97706', $700: '#b45309',
    $800: '#92400e', $900: '#78350f', $950: '#451a03',
  );
}

class _ColorScale {
  final String $50, $100, $200, $300, $400, $500, $600, $700, $800, $900, $950;

  const _ColorScale({
    required String $50, required String $100, required String $200,
    required String $300, required String $400, required String $500,
    required String $600, required String $700, required String $800,
    required String $900, required String $950,
  }) : $50 = $50, $100 = $100, $200 = $200, $300 = $300, $400 = $400,
       $500 = $500, $600 = $600, $700 = $700, $800 = $800, $900 = $900, $950 = $950;
}

/// DuxtUI Theme configuration matching jaspr_content pattern
class DuxtTheme {
  /// Primary color for links, buttons, highlights
  final ThemeColor primary;

  /// Secondary color
  final ThemeColor secondary;

  /// Background color
  final ThemeColor background;

  /// Text color
  final ThemeColor text;

  /// Success color
  final ThemeColor success;

  /// Warning color
  final ThemeColor warning;

  /// Error color
  final ThemeColor error;

  /// Info color
  final ThemeColor info;

  /// Font family
  final String? font;

  /// Code font family
  final String? codeFont;

  /// Custom color tokens
  final List<ColorToken> colors;

  const DuxtTheme({
    this.primary = const ThemeColor('#22c55e', dark: '#4ade80'),
    this.secondary = const ThemeColor('#3b82f6', dark: '#60a5fa'),
    this.background = const ThemeColor('#ffffff', dark: '#0f172a'),
    this.text = const ThemeColor('#1f2937', dark: '#f1f5f9'),
    this.success = const ThemeColor('#22c55e', dark: '#4ade80'),
    this.warning = const ThemeColor('#f59e0b', dark: '#fbbf24'),
    this.error = const ThemeColor('#ef4444', dark: '#f87171'),
    this.info = const ThemeColor('#3b82f6', dark: '#60a5fa'),
    this.font,
    this.codeFont,
    this.colors = const [],
  });

  /// Default theme with no styling
  static const DuxtTheme none = DuxtTheme();

  /// Generate CSS variables for the theme
  String toCssVariables() {
    final buffer = StringBuffer();
    buffer.writeln(':root {');
    buffer.writeln('  --color-primary: ${primary.lightValue};');
    buffer.writeln('  --color-secondary: ${secondary.lightValue};');
    buffer.writeln('  --color-background: ${background.lightValue};');
    buffer.writeln('  --color-text: ${text.lightValue};');
    buffer.writeln('  --color-success: ${success.lightValue};');
    buffer.writeln('  --color-warning: ${warning.lightValue};');
    buffer.writeln('  --color-error: ${error.lightValue};');
    buffer.writeln('  --color-info: ${info.lightValue};');
    if (font != null) buffer.writeln('  --font-sans: $font;');
    if (codeFont != null) buffer.writeln('  --font-mono: $codeFont;');
    for (final token in colors) {
      buffer.writeln('  ${token.cssVar}: ${token.light};');
    }
    buffer.writeln('}');

    buffer.writeln('.dark {');
    buffer.writeln('  --color-primary: ${primary.darkValue};');
    buffer.writeln('  --color-secondary: ${secondary.darkValue};');
    buffer.writeln('  --color-background: ${background.darkValue};');
    buffer.writeln('  --color-text: ${text.darkValue};');
    buffer.writeln('  --color-success: ${success.darkValue};');
    buffer.writeln('  --color-warning: ${warning.darkValue};');
    buffer.writeln('  --color-error: ${error.darkValue};');
    buffer.writeln('  --color-info: ${info.darkValue};');
    for (final token in colors) {
      buffer.writeln('  ${token.cssVar}: ${token.dark};');
    }
    buffer.writeln('}');

    return buffer.toString();
  }
}
