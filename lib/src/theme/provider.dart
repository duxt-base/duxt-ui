import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'colors.dart';

/// Theme mode for dark/light switching
enum UThemeMode { light, dark, system }

/// Theme configuration for DuxtUI
class UThemeConfig {
  final UColor primaryColor;
  final UColor secondaryColor;
  final UColor successColor;
  final UColor infoColor;
  final UColor warningColor;
  final UColor errorColor;
  final UThemeMode mode;

  const UThemeConfig({
    this.primaryColor = UColor.primary,
    this.secondaryColor = UColor.secondary,
    this.successColor = UColor.success,
    this.infoColor = UColor.info,
    this.warningColor = UColor.warning,
    this.errorColor = UColor.error,
    this.mode = UThemeMode.system,
  });

  static const UThemeConfig defaultConfig = UThemeConfig();
}

/// Theme provider that wraps the app and provides theme context
class UThemeProvider extends StatefulComponent {
  final UThemeConfig config;
  final Component child;

  const UThemeProvider({
    super.key,
    this.config = UThemeConfig.defaultConfig,
    required this.child,
  });

  @override
  State createState() => _UThemeProviderState();
}

class _UThemeProviderState extends State<UThemeProvider> {
  late UThemeMode _currentMode;

  @override
  void initState() {
    super.initState();
    _currentMode = component.config.mode;
  }

  String get _themeClass {
    switch (_currentMode) {
      case UThemeMode.dark:
        return 'dark';
      case UThemeMode.light:
        return '';
      case UThemeMode.system:
        // In browser, this would check prefers-color-scheme
        // For now, default to light
        return '';
    }
  }

  void toggleTheme() {
    setState(() {
      _currentMode = _currentMode == UThemeMode.dark ? UThemeMode.light : UThemeMode.dark;
    });
  }

  void setTheme(UThemeMode mode) {
    setState(() {
      _currentMode = mode;
    });
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: _themeClass,
      [component.child],
    );
  }
}

/// App wrapper component that sets up the theme and base styles
class UApp extends StatelessComponent {
  final UThemeConfig theme;
  final Component child;

  const UApp({
    super.key,
    this.theme = UThemeConfig.defaultConfig,
    required this.child,
  });

  @override
  Component build(BuildContext context) {
    return UThemeProvider(
      config: theme,
      child: div(
        classes: 'min-h-screen bg-white dark:bg-gray-900 text-gray-900 dark:text-gray-100 antialiased',
        [child],
      ),
    );
  }
}
