import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI DashboardSearch component
///
/// A search input with icon and keyboard shortcut hint.
/// Commonly used in dashboard navbars or toolbars.
class DDashboardSearch extends StatefulComponent {
  /// Custom CSS classes
  final String? classes;

  /// Placeholder text
  final String placeholder;

  /// Initial value
  final String? value;

  /// Whether to show the keyboard shortcut hint
  final bool showShortcut;

  /// Keyboard shortcut to display (e.g., "K" for Cmd+K)
  final String shortcut;

  /// Size variant
  final DSearchSize size;

  /// Whether the search is disabled
  final bool disabled;

  /// Callback when the value changes
  final ValueChanged<String>? onInput;

  /// Callback when search is submitted (Enter pressed)
  final ValueChanged<String>? onSubmit;

  /// Callback when the search input receives focus
  final VoidCallback? onFocus;

  /// Custom leading icon
  final Component? icon;

  /// Whether to expand on focus
  final bool expandOnFocus;

  const DDashboardSearch({
    super.key,
    this.classes,
    this.placeholder = 'Search...',
    this.value,
    this.showShortcut = true,
    this.shortcut = 'K',
    this.size = DSearchSize.md,
    this.disabled = false,
    this.onInput,
    this.onSubmit,
    this.onFocus,
    this.icon,
    this.expandOnFocus = false,
  });

  @override
  State<DDashboardSearch> createState() => _UDashboardSearchState();
}

class _UDashboardSearchState extends State<DDashboardSearch> {
  String _value = '';
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _value = component.value ?? '';
  }

  String get _sizeClasses {
    switch (component.size) {
      case DSearchSize.sm:
        return 'h-8 text-xs';
      case DSearchSize.md:
        return 'h-9 text-sm';
      case DSearchSize.lg:
        return 'h-10 text-base';
    }
  }

  String get _inputPaddingClasses {
    switch (component.size) {
      case DSearchSize.sm:
        return 'pl-8 pr-12';
      case DSearchSize.md:
        return 'pl-10 pr-14';
      case DSearchSize.lg:
        return 'pl-11 pr-16';
    }
  }

  String get _iconSizeClasses {
    switch (component.size) {
      case DSearchSize.sm:
        return 'w-4 h-4';
      case DSearchSize.md:
        return 'w-5 h-5';
      case DSearchSize.lg:
        return 'w-5 h-5';
    }
  }

  Component get _searchIcon {
    return svg(
      classes: _iconSizeClasses,
      attributes: {
        'viewBox': '0 0 24 24',
        'fill': 'none',
        'stroke': 'currentColor',
        'stroke-width': '2',
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
      },
      [
        RawText('<circle cx="11" cy="11" r="8"/>'),
        RawText('<line x1="21" y1="21" x2="16.65" y2="16.65"/>'),
      ],
    );
  }

  String get _widthClasses {
    if (!component.expandOnFocus) return 'w-64';
    return _focused ? 'w-80' : 'w-64';
  }

  @override
  Component build(BuildContext context) {
    final borderClasses = _focused
        ? 'border-cyan-500 ring-2 ring-cyan-500/20'
        : 'border-gray-200 dark:border-gray-700';

    return div(
      classes:
          'relative $_widthClasses transition-all duration-200 ${component.classes ?? ""}',
      [
        // Search icon
        div(
          classes:
              'absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-gray-400',
          [component.icon ?? _searchIcon],
        ),
        // Input
        input<String>(
          type: InputType.text,
          value: _value,
          disabled: component.disabled,
          onInput: (val) {
            setState(() => _value = val);
            component.onInput?.call(val);
          },
          classes:
              'w-full $_sizeClasses $_inputPaddingClasses rounded-lg border $borderClasses bg-white dark:bg-zinc-900 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none transition-colors ${component.disabled ? "opacity-50 cursor-not-allowed" : ""}',
          attributes: {
            'placeholder': component.placeholder,
          },
          events: {
            'focus': (_) {
              setState(() => _focused = true);
              component.onFocus?.call();
            },
            'blur': (_) {
              setState(() => _focused = false);
            },
          },
        ),
        // Keyboard shortcut hint
        if (component.showShortcut && !_focused)
          div(
            classes:
                'absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none',
            [
              div(
                classes:
                    'hidden sm:flex items-center gap-1 text-xs text-gray-400',
                [
                  // Command/Ctrl key
                  span(
                    classes:
                        'px-1.5 py-0.5 bg-gray-100 dark:bg-zinc-800 rounded border border-gray-200 dark:border-gray-700 font-medium',
                    [Component.text(_isMac ? '\u2318' : 'Ctrl')],
                  ),
                  span(
                    classes:
                        'px-1.5 py-0.5 bg-gray-100 dark:bg-zinc-800 rounded border border-gray-200 dark:border-gray-700 font-medium',
                    [Component.text(component.shortcut)],
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }

  // Helper to detect Mac for keyboard shortcut display
  bool get _isMac => true; // In real implementation, detect from platform
}

/// Search size variants
enum DSearchSize { sm, md, lg }

/// Compact search button that expands to full search
class DDashboardSearchButton extends StatelessComponent {
  /// Custom CSS classes
  final String? classes;

  /// Click callback (typically opens a search modal)
  final VoidCallback? onClick;

  /// Keyboard shortcut to display
  final String shortcut;

  const DDashboardSearchButton({
    super.key,
    this.classes,
    this.onClick,
    this.shortcut = 'K',
  });

  Component get _searchIcon {
    return svg(
      classes: 'w-5 h-5',
      attributes: {
        'viewBox': '0 0 24 24',
        'fill': 'none',
        'stroke': 'currentColor',
        'stroke-width': '2',
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
      },
      [
        RawText('<circle cx="11" cy="11" r="8"/>'),
        RawText('<line x1="21" y1="21" x2="16.65" y2="16.65"/>'),
      ],
    );
  }

  @override
  Component build(BuildContext context) {
    return button(
      type: ButtonType.button,
      onClick: onClick,
      classes:
          'flex items-center gap-2 px-3 py-2 rounded-lg border border-gray-200 dark:border-gray-700 bg-white dark:bg-zinc-900 text-gray-400 hover:border-gray-300 dark:hover:border-gray-600 transition-colors ${classes ?? ""}',
      [
        _searchIcon,
        span(classes: 'text-sm', [Component.text('Search...')]),
        div(classes: 'flex items-center gap-1 ml-auto', [
          span(
            classes:
                'px-1.5 py-0.5 bg-gray-100 dark:bg-zinc-800 rounded border border-gray-200 dark:border-gray-700 text-xs font-medium',
            [Component.text('\u2318')],
          ),
          span(
            classes:
                'px-1.5 py-0.5 bg-gray-100 dark:bg-zinc-800 rounded border border-gray-200 dark:border-gray-700 text-xs font-medium',
            [Component.text(shortcut)],
          ),
        ]),
      ],
    );
  }
}
