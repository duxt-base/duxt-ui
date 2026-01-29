import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../components/utility/icon.dart';
import 'provider.dart';

/// DuxtUI ColorModeSwitch component - Switch toggle for dark/light mode
///
/// A toggle switch with sun and moon icons for theme switching.
/// Shows current mode visually with animated transition.
class UColorModeSwitch extends StatefulComponent {
  /// Initial mode
  final UThemeMode initialMode;

  /// Callback when mode changes
  final ValueChanged<UThemeMode>? onModeChange;

  /// Custom CSS classes
  final String? classes;

  const UColorModeSwitch({
    super.key,
    this.initialMode = UThemeMode.light,
    this.onModeChange,
    this.classes,
  });

  @override
  State createState() => _UColorModeSwitchState();
}

class _UColorModeSwitchState extends State<UColorModeSwitch> {
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = component.initialMode == UThemeMode.dark;
  }

  void _toggle() {
    setState(() {
      _isDark = !_isDark;
    });
    final newMode = _isDark ? UThemeMode.dark : UThemeMode.light;
    component.onModeChange?.call(newMode);
  }

  @override
  Component build(BuildContext context) {
    return button(
      type: ButtonType.button,
      onClick: _toggle,
      classes: [
        'relative inline-flex h-8 w-16 items-center rounded-full',
        'transition-colors duration-200 ease-in-out',
        'focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2',
        _isDark ? 'bg-indigo-600' : 'bg-gray-200 dark:bg-gray-700',
        if (component.classes != null) component.classes!,
      ].join(' '),
      attributes: {
        'role': 'switch',
        'aria-checked': _isDark ? 'true' : 'false',
        'aria-label': 'Toggle dark mode',
      },
      [
        // Switch track with icons
        span(
          classes: 'sr-only',
          [
            Component.text(_isDark ? 'Dark mode enabled' : 'Light mode enabled')
          ],
        ),

        // Sun icon (left side)
        span(
          classes: [
            'absolute left-1.5 flex items-center justify-center',
            'text-yellow-500 transition-opacity',
            _isDark ? 'opacity-100' : 'opacity-40',
          ].join(' '),
          [
            UIcon(name: UIconNames.sun, size: UIconSize.xs),
          ],
        ),

        // Moon icon (right side)
        span(
          classes: [
            'absolute right-1.5 flex items-center justify-center',
            'text-indigo-300 transition-opacity',
            _isDark ? 'opacity-40' : 'opacity-100',
          ].join(' '),
          [
            UIcon(name: UIconNames.moon, size: UIconSize.xs),
          ],
        ),

        // Switch thumb/knob
        span(
          classes: [
            'inline-block h-6 w-6 transform rounded-full bg-white shadow-lg',
            'transition-transform duration-200 ease-in-out',
            _isDark ? 'translate-x-8' : 'translate-x-1',
          ].join(' '),
          [],
        ),
      ],
    );
  }
}
