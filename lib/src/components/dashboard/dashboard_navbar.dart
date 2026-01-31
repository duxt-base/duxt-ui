import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI DashboardNavbar component
///
/// A horizontal navigation bar for dashboard layouts.
/// Typically placed at the top of a dashboard panel.
class DDashboardNavbar extends StatelessComponent {
  /// Custom CSS classes to apply to the navbar
  final String? classes;

  /// Content for the left side of the navbar
  final Component? leading;

  /// Title text
  final String? title;

  /// Content for the center of the navbar
  final Component? center;

  /// Content for the right side of the navbar
  final Component? trailing;

  /// Whether to show a border at the bottom
  final bool bordered;

  /// Background variant
  final DNavbarBackground background;

  /// Child components (rendered in the center if center is not provided)
  final List<Component> children;

  const DDashboardNavbar({
    super.key,
    this.classes,
    this.leading,
    this.title,
    this.center,
    this.trailing,
    this.bordered = true,
    this.background = DNavbarBackground.white,
    this.children = const [],
  });

  String get _backgroundClasses {
    switch (background) {
      case DNavbarBackground.white:
        return 'bg-white dark:bg-zinc-900';
      case DNavbarBackground.gray:
        return 'bg-gray-50 dark:bg-zinc-900';
      case DNavbarBackground.transparent:
        return 'bg-transparent';
    }
  }

  String get _borderClasses {
    return bordered ? 'border-b border-gray-200 dark:border-gray-800' : '';
  }

  @override
  Component build(BuildContext context) {
    return nav(
      classes:
          'h-16 flex items-center justify-between px-4 $_backgroundClasses $_borderClasses ${classes ?? ""}',
      [
        // Left section
        div(classes: 'flex items-center gap-4', [
          if (leading != null) leading!,
          if (title != null)
            h1(
                classes: 'text-lg font-semibold text-gray-900 dark:text-white',
                [Component.text(title!)]),
        ]),
        // Center section
        if (center != null)
          div(classes: 'flex-1 flex items-center justify-center', [center!])
        else if (children.isNotEmpty)
          div(
              classes: 'flex-1 flex items-center justify-center gap-4',
              children),
        // Right section
        if (trailing != null)
          div(classes: 'flex items-center gap-4', [trailing!]),
      ],
    );
  }
}

/// Navbar background variants
enum DNavbarBackground { white, gray, transparent }
