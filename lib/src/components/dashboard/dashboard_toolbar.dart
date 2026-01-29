import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI DashboardToolbar component
///
/// A horizontal toolbar for dashboard panels.
/// Typically used for page-level actions, filters, or secondary navigation.
class UDashboardToolbar extends StatelessComponent {
  /// Custom CSS classes
  final String? classes;

  /// Content for the left side
  final Component? leading;

  /// Content for the right side
  final Component? trailing;

  /// Whether to show a border at the bottom
  final bool bordered;

  /// Background variant
  final UToolbarBackground background;

  /// Height variant
  final UToolbarHeight height;

  /// Child components (rendered in the center)
  final List<Component> children;

  const UDashboardToolbar({
    super.key,
    this.classes,
    this.leading,
    this.trailing,
    this.bordered = true,
    this.background = UToolbarBackground.white,
    this.height = UToolbarHeight.md,
    this.children = const [],
  });

  String get _heightClasses {
    switch (height) {
      case UToolbarHeight.sm:
        return 'h-10';
      case UToolbarHeight.md:
        return 'h-12';
      case UToolbarHeight.lg:
        return 'h-14';
    }
  }

  String get _backgroundClasses {
    switch (background) {
      case UToolbarBackground.white:
        return 'bg-white dark:bg-gray-900';
      case UToolbarBackground.gray:
        return 'bg-gray-50 dark:bg-gray-900';
      case UToolbarBackground.transparent:
        return 'bg-transparent';
    }
  }

  String get _borderClasses {
    return bordered ? 'border-b border-gray-200 dark:border-gray-800' : '';
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: '$_heightClasses flex items-center gap-2 px-4 $_backgroundClasses $_borderClasses ${classes ?? ""}',
      [
        // Left section
        if (leading != null)
          div(classes: 'flex items-center gap-2', [leading!]),
        // Center section
        if (children.isNotEmpty)
          div(classes: 'flex-1 flex items-center gap-2', children),
        // Right section
        if (trailing != null)
          div(classes: 'flex items-center gap-2 ml-auto', [trailing!]),
      ],
    );
  }
}

/// Toolbar background variants
enum UToolbarBackground { white, gray, transparent }

/// Toolbar height variants
enum UToolbarHeight { sm, md, lg }

/// Toolbar separator
class UToolbarSeparator extends StatelessComponent {
  const UToolbarSeparator({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'w-px h-6 bg-gray-200 dark:bg-gray-700',
      [],
    );
  }
}

/// Toolbar spacer (pushes items to opposite sides)
class UToolbarSpacer extends StatelessComponent {
  const UToolbarSpacer({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'flex-1', []);
  }
}
