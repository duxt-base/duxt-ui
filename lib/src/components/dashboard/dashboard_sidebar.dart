import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI DashboardSidebar component
///
/// A collapsible sidebar for dashboard layouts.
/// Supports expanded (w-64), collapsed (w-16), and mobile overlay states.
class DDashboardSidebar extends StatefulComponent {
  /// Custom CSS classes to apply to the sidebar
  final String? classes;

  /// Whether the sidebar is initially collapsed
  final bool initialCollapsed;

  /// Whether to show the sidebar on mobile (overlay mode)
  final bool mobileOpen;

  /// Callback when mobile overlay is closed
  final VoidCallback? onMobileClose;

  /// Header content (shown at top of sidebar)
  final Component? header;

  /// Footer content (shown at bottom of sidebar)
  final Component? footer;

  /// Whether to show a border on the right
  final bool bordered;

  /// Background variant
  final DSidebarBackground background;

  /// The side of the screen the sidebar is on
  final DSidebarSide side;

  /// Callback when collapse state changes
  final ValueChanged<bool>? onCollapseChange;

  /// Child components (navigation items)
  final List<Component> children;

  const DDashboardSidebar({
    super.key,
    this.classes,
    this.initialCollapsed = false,
    this.mobileOpen = false,
    this.onMobileClose,
    this.header,
    this.footer,
    this.bordered = true,
    this.background = DSidebarBackground.gray,
    this.side = DSidebarSide.left,
    this.onCollapseChange,
    this.children = const [],
  });

  @override
  State<DDashboardSidebar> createState() => _UDashboardSidebarState();
}

class _UDashboardSidebarState extends State<DDashboardSidebar> {
  late bool _collapsed;

  @override
  void initState() {
    super.initState();
    _collapsed = component.initialCollapsed;
  }

  void toggle() {
    setState(() {
      _collapsed = !_collapsed;
      component.onCollapseChange?.call(_collapsed);
    });
  }

  void collapse() {
    if (!_collapsed) {
      setState(() {
        _collapsed = true;
        component.onCollapseChange?.call(_collapsed);
      });
    }
  }

  void expand() {
    if (_collapsed) {
      setState(() {
        _collapsed = false;
        component.onCollapseChange?.call(_collapsed);
      });
    }
  }

  String get _widthClasses {
    return _collapsed ? 'w-16' : 'w-64';
  }

  String get _backgroundClasses {
    switch (component.background) {
      case DSidebarBackground.white:
        return 'bg-white dark:bg-zinc-900';
      case DSidebarBackground.gray:
        return 'bg-gray-50 dark:bg-zinc-900';
    }
  }

  String get _borderClasses {
    if (!component.bordered) return '';
    switch (component.side) {
      case DSidebarSide.left:
        return 'border-r border-gray-200 dark:border-gray-800';
      case DSidebarSide.right:
        return 'border-l border-gray-200 dark:border-gray-800';
    }
  }

  @override
  Component build(BuildContext context) {
    // Mobile overlay
    if (component.mobileOpen) {
      return div(classes: 'fixed inset-0 z-50 lg:hidden', [
        // Backdrop
        div(
          classes: 'fixed inset-0 bg-black/50',
          events: component.onMobileClose != null
              ? {'click': (_) => component.onMobileClose!()}
              : {},
          [],
        ),
        // Sidebar
        aside(
          classes:
              'fixed inset-y-0 ${component.side == DSidebarSide.left ? "left-0" : "right-0"} w-64 flex flex-col $_backgroundClasses $_borderClasses shadow-xl transition-transform duration-300',
          [
            // Header
            if (component.header != null)
              div(classes: 'flex-shrink-0', [component.header!]),
            // Content
            div(classes: 'flex-1 overflow-y-auto', component.children),
            // Footer
            if (component.footer != null)
              div(classes: 'flex-shrink-0', [component.footer!]),
          ],
        ),
      ]);
    }

    // Desktop sidebar
    return aside(
      classes:
          'hidden lg:flex flex-col $_widthClasses $_backgroundClasses $_borderClasses transition-all duration-300 ${component.classes ?? ""}',
      [
        // Header
        if (component.header != null)
          div(classes: 'flex-shrink-0', [component.header!]),
        // Content
        div(classes: 'flex-1 overflow-y-auto py-4', [
          // Provide collapse context to children
          for (final child in component.children)
            _SidebarCollapseProvider(
              collapsed: _collapsed,
              child: child,
            ),
        ]),
        // Footer
        if (component.footer != null)
          div(classes: 'flex-shrink-0', [component.footer!]),
      ],
    );
  }
}

/// Internal component to provide collapse state to children
class _SidebarCollapseProvider extends StatelessComponent {
  final bool collapsed;
  final Component child;

  const _SidebarCollapseProvider({
    required this.collapsed,
    required this.child,
  });

  @override
  Component build(BuildContext context) {
    return child;
  }
}

/// Sidebar background variants
enum DSidebarBackground { white, gray }

/// Sidebar side options
enum DSidebarSide { left, right }

/// Sidebar navigation item
class DSidebarItem extends StatelessComponent {
  /// Item label
  final String label;

  /// Leading icon
  final Component? icon;

  /// Whether this item is currently active
  final bool active;

  /// Whether this item is disabled
  final bool disabled;

  /// Click callback
  final VoidCallback? onClick;

  /// Badge content (e.g., notification count)
  final String? badge;

  /// Whether the sidebar is collapsed (icons only)
  final bool collapsed;

  const DSidebarItem({
    super.key,
    required this.label,
    this.icon,
    this.active = false,
    this.disabled = false,
    this.onClick,
    this.badge,
    this.collapsed = false,
  });

  @override
  Component build(BuildContext context) {
    final activeClasses = active
        ? 'bg-gray-100 dark:bg-zinc-800 text-gray-900 dark:text-white'
        : 'text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 hover:text-gray-900 dark:hover:text-white';

    final disabledClasses = disabled ? 'opacity-50 cursor-not-allowed' : '';

    if (collapsed) {
      return button(
        type: ButtonType.button,
        disabled: disabled,
        onClick: disabled ? null : onClick,
        classes:
            'w-full flex items-center justify-center p-3 rounded-lg transition-colors $activeClasses $disabledClasses',
        attributes: {'title': label},
        [
          if (icon != null) icon!,
          if (badge != null)
            span(
              classes:
                  'absolute top-0 right-0 inline-flex items-center justify-center px-1.5 py-0.5 text-xs font-bold leading-none text-white transform translate-x-1/2 -translate-y-1/2 bg-red-500 rounded-full',
              [Component.text(badge!)],
            ),
        ],
      );
    }

    return button(
      type: ButtonType.button,
      disabled: disabled,
      onClick: disabled ? null : onClick,
      classes:
          'w-full flex items-center gap-3 px-3 py-2 rounded-lg transition-colors $activeClasses $disabledClasses',
      [
        if (icon != null) icon!,
        span(
            classes: 'flex-1 text-left text-sm font-medium',
            [Component.text(label)]),
        if (badge != null)
          span(
            classes:
                'inline-flex items-center justify-center px-2 py-0.5 text-xs font-bold leading-none text-white bg-red-500 rounded-full',
            [Component.text(badge!)],
          ),
      ],
    );
  }
}

/// Sidebar section with label
class DSidebarSection extends StatelessComponent {
  /// Section label
  final String? label;

  /// Whether to show the label when collapsed
  final bool showLabelCollapsed;

  /// Whether the sidebar is collapsed
  final bool collapsed;

  /// Child items
  final List<Component> children;

  const DSidebarSection({
    super.key,
    this.label,
    this.showLabelCollapsed = false,
    this.collapsed = false,
    this.children = const [],
  });

  @override
  Component build(BuildContext context) {
    return div(classes: 'px-3 py-2', [
      if (label != null && (!collapsed || showLabelCollapsed))
        div(
          classes:
              'px-3 py-2 text-xs font-semibold text-gray-400 uppercase tracking-wider',
          [Component.text(label!)],
        ),
      ...children,
    ]);
  }
}
