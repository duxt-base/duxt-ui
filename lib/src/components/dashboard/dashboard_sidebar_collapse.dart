import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI DashboardSidebarCollapse component
///
/// A collapsible section within the sidebar that shows/hides nested items.
/// Useful for grouping related navigation items.
class DDashboardSidebarCollapse extends StatefulComponent {
  /// Custom CSS classes
  final String? classes;

  /// Section label
  final String label;

  /// Leading icon
  final Component? icon;

  /// Whether initially open
  final bool initialOpen;

  /// Whether the parent sidebar is collapsed (icons only mode)
  final bool sidebarCollapsed;

  /// Child navigation items
  final List<Component> children;

  const DDashboardSidebarCollapse({
    super.key,
    this.classes,
    required this.label,
    this.icon,
    this.initialOpen = false,
    this.sidebarCollapsed = false,
    this.children = const [],
  });

  @override
  State<DDashboardSidebarCollapse> createState() =>
      _UDashboardSidebarCollapseState();
}

class _UDashboardSidebarCollapseState extends State<DDashboardSidebarCollapse> {
  late bool _open;

  @override
  void initState() {
    super.initState();
    _open = component.initialOpen;
  }

  void _toggle() {
    setState(() => _open = !_open);
  }

  Component get _chevronIcon {
    return svg(
      classes: 'w-4 h-4 transition-transform ${_open ? "rotate-90" : ""}',
      attributes: {
        'viewBox': '0 0 24 24',
        'fill': 'none',
        'stroke': 'currentColor',
        'stroke-width': '2',
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
      },
      [
        RawText('<polyline points="9 18 15 12 9 6"/>'),
      ],
    );
  }

  @override
  Component build(BuildContext context) {
    // When sidebar is collapsed, show as dropdown or tooltip
    if (component.sidebarCollapsed) {
      return div(classes: 'relative group', [
        // Icon button
        button(
          type: ButtonType.button,
          onClick: _toggle,
          classes:
              'w-full flex items-center justify-center p-3 rounded-lg text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 hover:text-gray-900 dark:hover:text-white transition-colors',
          attributes: {'title': component.label},
          [
            if (component.icon != null) component.icon!,
          ],
        ),
        // Flyout menu on hover
        div(
          classes:
              'absolute left-full top-0 ml-2 w-48 py-2 bg-white dark:bg-gray-900 rounded-lg shadow-lg border border-gray-200 dark:border-gray-700 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all z-50',
          [
            // Label
            div(
              classes:
                  'px-3 py-2 text-xs font-semibold text-gray-400 uppercase',
              [Component.text(component.label)],
            ),
            // Children
            ...component.children,
          ],
        ),
      ]);
    }

    // Normal expanded sidebar
    return div(classes: component.classes ?? '', [
      // Toggle button
      button(
        type: ButtonType.button,
        onClick: _toggle,
        classes:
            'w-full flex items-center gap-3 px-3 py-2 rounded-lg text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 hover:text-gray-900 dark:hover:text-white transition-colors',
        [
          if (component.icon != null) component.icon!,
          span(
              classes: 'flex-1 text-left text-sm font-medium',
              [Component.text(component.label)]),
          _chevronIcon,
        ],
      ),
      // Collapsible content
      if (_open)
        div(
          classes: 'pl-4 mt-1 space-y-1',
          component.children,
        ),
    ]);
  }
}
