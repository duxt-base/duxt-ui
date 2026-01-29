import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../components/utility/icon.dart';
import 'provider.dart';

/// Button sizes for color mode toggle
enum UColorModeButtonSize { xs, sm, md, lg, xl }

/// DuxtUI ColorModeButton component - Toggle dark/light mode
///
/// An icon button that toggles between light and dark themes.
/// Shows sun icon in dark mode and moon icon in light mode.
class UColorModeButton extends StatefulComponent {
  /// Size of the button
  final UColorModeButtonSize size;

  /// Custom CSS classes
  final String? classes;

  /// Callback when theme changes
  final ValueChanged<UThemeMode>? onModeChange;

  const UColorModeButton({
    super.key,
    this.size = UColorModeButtonSize.md,
    this.classes,
    this.onModeChange,
  });

  @override
  State createState() => _UColorModeButtonState();
}

class _UColorModeButtonState extends State<UColorModeButton> {
  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    // Check initial state from DOM
    _checkDarkMode();
  }

  void _checkDarkMode() {
    // In browser context, check if dark class is on html/body
    // For now, default to false
    _isDark = false;
  }

  void _toggleMode() {
    setState(() {
      _isDark = !_isDark;
    });
    final newMode = _isDark ? UThemeMode.dark : UThemeMode.light;
    component.onModeChange?.call(newMode);

    // Toggle dark class on document
    // This is a simplified implementation - in production,
    // you'd use a proper theme context/provider
  }

  String get _buttonSizeClasses {
    switch (component.size) {
      case UColorModeButtonSize.xs:
        return 'p-1';
      case UColorModeButtonSize.sm:
        return 'p-1.5';
      case UColorModeButtonSize.md:
        return 'p-2';
      case UColorModeButtonSize.lg:
        return 'p-2.5';
      case UColorModeButtonSize.xl:
        return 'p-3';
    }
  }

  UIconSize get _iconSize {
    switch (component.size) {
      case UColorModeButtonSize.xs:
        return UIconSize.xs;
      case UColorModeButtonSize.sm:
        return UIconSize.sm;
      case UColorModeButtonSize.md:
        return UIconSize.md;
      case UColorModeButtonSize.lg:
        return UIconSize.lg;
      case UColorModeButtonSize.xl:
        return UIconSize.xl;
    }
  }

  @override
  Component build(BuildContext context) {
    return button(
      type: ButtonType.button,
      onClick: _toggleMode,
      classes: [
        'inline-flex items-center justify-center rounded-lg',
        'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200',
        'hover:bg-gray-100 dark:hover:bg-gray-800',
        'focus:outline-none focus:ring-2 focus:ring-gray-300 dark:focus:ring-gray-600',
        'transition-colors',
        _buttonSizeClasses,
        if (component.classes != null) component.classes!,
      ].join(' '),
      attributes: {
        'aria-label': _isDark ? 'Switch to light mode' : 'Switch to dark mode',
      },
      [
        // Show sun in dark mode (to switch to light), moon in light mode (to switch to dark)
        if (_isDark)
          UIcon(name: UIconNames.sun, size: _iconSize)
        else
          UIcon(name: UIconNames.moon, size: _iconSize),
      ],
    );
  }
}
