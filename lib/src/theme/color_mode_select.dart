import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../components/utility/icon.dart';
import 'provider.dart';

/// DuxtUI ColorModeSelect component - Dropdown for theme selection
///
/// A dropdown select that allows choosing between Light, Dark, and System
/// theme modes. Shows current selection with icon.
class UColorModeSelect extends StatefulComponent {
  /// Currently selected mode
  final UThemeMode selectedMode;

  /// Callback when mode changes
  final ValueChanged<UThemeMode>? onModeChange;

  /// Custom CSS classes
  final String? classes;

  const UColorModeSelect({
    super.key,
    this.selectedMode = UThemeMode.system,
    this.onModeChange,
    this.classes,
  });

  @override
  State createState() => _UColorModeSelectState();
}

class _UColorModeSelectState extends State<UColorModeSelect> {
  late UThemeMode _currentMode;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _currentMode = component.selectedMode;
  }

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _selectMode(UThemeMode mode) {
    setState(() {
      _currentMode = mode;
      _isOpen = false;
    });
    component.onModeChange?.call(mode);
  }

  String _getModeLabel(UThemeMode mode) {
    switch (mode) {
      case UThemeMode.light:
        return 'Light';
      case UThemeMode.dark:
        return 'Dark';
      case UThemeMode.system:
        return 'System';
    }
  }

  String _getModeIcon(UThemeMode mode) {
    switch (mode) {
      case UThemeMode.light:
        return UIconNames.sun;
      case UThemeMode.dark:
        return UIconNames.moon;
      case UThemeMode.system:
        return UIconNames.system;
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'relative inline-block ${component.classes ?? ""}',
      [
        // Trigger button
        button(
          type: ButtonType.button,
          onClick: _toggleDropdown,
          classes: [
            'inline-flex items-center justify-between gap-2 px-3 py-2',
            'bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600',
            'rounded-lg shadow-sm min-w-[140px]',
            'text-sm text-gray-700 dark:text-gray-200',
            'hover:bg-gray-50 dark:hover:bg-gray-700',
            'focus:outline-none focus:ring-2 focus:ring-indigo-500',
            'transition-colors',
          ].join(' '),
          attributes: {
            'aria-haspopup': 'listbox',
            'aria-expanded': _isOpen ? 'true' : 'false',
          },
          [
            // Current selection
            span(
              classes: 'flex items-center gap-2',
              [
                UIcon(
                  name: _getModeIcon(_currentMode),
                  size: UIconSize.sm,
                  color: 'text-gray-500 dark:text-gray-400',
                ),
                Component.text(_getModeLabel(_currentMode)),
              ],
            ),
            // Dropdown arrow
            UIcon(
              name: UIconNames.chevronDown,
              size: UIconSize.xs,
              classes: [
                'transition-transform',
                if (_isOpen) 'rotate-180',
              ].join(' '),
            ),
          ],
        ),

        // Dropdown menu
        if (_isOpen)
          div(
            classes: [
              'absolute z-10 mt-1 w-full',
              'bg-white dark:bg-gray-800',
              'border border-gray-200 dark:border-gray-700',
              'rounded-lg shadow-lg',
              'py-1',
            ].join(' '),
            attributes: {'role': 'listbox'},
            [
              for (final mode in UThemeMode.values) _buildOption(mode),
            ],
          ),
      ],
    );
  }

  Component _buildOption(UThemeMode mode) {
    final isSelected = mode == _currentMode;

    return button(
      type: ButtonType.button,
      onClick: () => _selectMode(mode),
      classes: [
        'w-full flex items-center gap-2 px-3 py-2 text-sm',
        'transition-colors',
        if (isSelected)
          'bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400'
        else
          'text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700',
      ].join(' '),
      attributes: {
        'role': 'option',
        'aria-selected': isSelected ? 'true' : 'false',
      },
      [
        UIcon(
          name: _getModeIcon(mode),
          size: UIconSize.sm,
          color: isSelected
              ? 'text-indigo-500'
              : 'text-gray-400 dark:text-gray-500',
        ),
        Component.text(_getModeLabel(mode)),
        if (isSelected)
          span(
            classes: 'ml-auto',
            [
              UIcon(
                name: UIconNames.check,
                size: UIconSize.sm,
                color: 'text-indigo-500',
              ),
            ],
          ),
      ],
    );
  }
}
