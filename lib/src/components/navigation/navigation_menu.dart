import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Navigation menu orientation
enum DNavigationOrientation { horizontal, vertical }

/// Navigation item variant
enum DNavigationItemVariant { default_, active, disabled }

/// DuxtUI NavigationMenu component
class DNavigationMenu extends StatelessComponent {
  final List<DNavigationItem> items;
  final DNavigationOrientation orientation;
  final String? classes;

  const DNavigationMenu({
    super.key,
    required this.items,
    this.orientation = DNavigationOrientation.horizontal,
    this.classes,
  });

  String get _orientationClasses {
    switch (orientation) {
      case DNavigationOrientation.horizontal:
        return 'flex items-center gap-1';
      case DNavigationOrientation.vertical:
        return 'flex flex-col gap-1';
    }
  }

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'nav',
      classes: '${classes ?? ""}'.trim(),
      children: [
        ul(
          classes: _orientationClasses,
          items.map((item) => li([item])).toList(),
        ),
      ],
    );
  }
}

/// Navigation menu item
class DNavigationItem extends StatelessComponent {
  final String label;
  final String? href;
  final Component? icon;
  final Component? badge;
  final bool active;
  final bool disabled;
  final VoidCallback? onClick;
  final List<DNavigationItem>? children;
  final String? classes;

  const DNavigationItem({
    super.key,
    required this.label,
    this.href,
    this.icon,
    this.badge,
    this.active = false,
    this.disabled = false,
    this.onClick,
    this.children,
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    final baseClasses =
        'flex items-center gap-2 px-3 py-2 text-sm font-medium rounded-md transition-colors';

    final stateClasses = disabled
        ? 'text-gray-400 dark:text-gray-600 cursor-not-allowed'
        : active
            ? 'text-gray-900 dark:text-white bg-gray-100 dark:bg-zinc-800'
            : 'text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-50 dark:hover:bg-gray-800/50';

    // If has children, render as dropdown trigger
    if (children != null && children!.isNotEmpty) {
      return div(
        classes: 'relative group',
        [
          button(
            type: ButtonType.button,
            disabled: disabled,
            classes: '$baseClasses $stateClasses ${classes ?? ""}'.trim(),
            [
              if (icon != null) icon!,
              Component.text(label),
              if (badge != null) badge!,
              // Dropdown indicator
              span(
                classes: 'ml-1 transition-transform group-hover:rotate-180',
                [Component.text('\u25BC')], // Down arrow
              ),
            ],
          ),
          // Dropdown menu
          div(
            classes:
                'absolute left-0 top-full mt-1 min-w-48 py-1 bg-white dark:bg-zinc-900 rounded-lg shadow-lg ring-1 ring-gray-200 dark:ring-gray-800 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all z-50',
            children!,
          ),
        ],
      );
    }

    // Regular navigation item
    if (href != null && !disabled) {
      return a(
        href: href!,
        classes: '$baseClasses $stateClasses ${classes ?? ""}'.trim(),
        [
          if (icon != null) icon!,
          Component.text(label),
          if (badge != null) badge!,
        ],
      );
    }

    return button(
      type: ButtonType.button,
      disabled: disabled,
      onClick: disabled ? null : onClick,
      classes: '$baseClasses $stateClasses ${classes ?? ""}'.trim(),
      [
        if (icon != null) icon!,
        Component.text(label),
        if (badge != null) badge!,
      ],
    );
  }
}

/// DuxtUI Vertical Navigation component
class DVerticalNavigation extends StatelessComponent {
  final List<DNavigationGroup> groups;
  final String? classes;

  const DVerticalNavigation({
    super.key,
    required this.groups,
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'nav',
      classes: 'space-y-4 ${classes ?? ""}'.trim(),
      children: groups,
    );
  }
}

/// Navigation group (for vertical navigation)
class DNavigationGroup extends StatelessComponent {
  final String? title;
  final List<DNavigationItem> items;
  final String? classes;

  const DNavigationGroup({
    super.key,
    this.title,
    required this.items,
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: classes ?? '',
      [
        if (title != null)
          h3(
            classes:
                'px-3 mb-2 text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider',
            [Component.text(title!)],
          ),
        ul(
          classes: 'space-y-1',
          items.map((item) => li([item])).toList(),
        ),
      ],
    );
  }
}
