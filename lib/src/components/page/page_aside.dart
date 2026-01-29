import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI PageAside component - Sticky sidebar navigation
///
/// A sticky sidebar for navigation, typically used for docs navigation or TOC.
class DPageAside extends StatelessComponent {
  /// The sidebar content
  final List<Component> children;

  /// Additional CSS classes
  final String? classes;

  /// Top offset for sticky positioning (default: 16 = 4rem)
  final String topOffset;

  /// Whether to hide on mobile/tablet
  final bool hiddenOnMobile;

  /// Optional title for the aside
  final String? title;

  const DPageAside({
    super.key,
    this.children = const [],
    this.classes,
    this.topOffset = '16',
    this.hiddenOnMobile = true,
    this.title,
  });

  @override
  Component build(BuildContext context) {
    return aside(
      classes: '${hiddenOnMobile ? "hidden lg:block" : ""} ${classes ?? ""}',
      [
        div(
          classes: 'sticky top-$topOffset',
          [
            // Navigation container
            nav(
              classes: 'space-y-1',
              [
                // Optional title
                if (title != null)
                  h4(
                    classes:
                        'text-sm font-semibold text-gray-900 dark:text-white mb-4',
                    [Component.text(title!)],
                  ),
                // Content
                ...children,
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// DuxtUI PageAsideLink component - Link item for page aside
class DPageAsideLink extends StatelessComponent {
  /// Link text
  final String label;

  /// Link href
  final String href;

  /// Whether this link is active
  final bool active;

  /// Nesting level (0 = root, 1 = nested, etc.)
  final int level;

  /// Additional CSS classes
  final String? classes;

  const DPageAsideLink({
    super.key,
    required this.label,
    required this.href,
    this.active = false,
    this.level = 0,
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    final paddingLeft = level > 0 ? 'pl-${level * 3}' : '';
    final activeClasses = active
        ? 'text-primary-500 dark:text-primary-400 font-medium border-l-2 border-primary-500'
        : 'text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white border-l-2 border-transparent hover:border-gray-300';

    return a(
      href: href,
      classes:
          'block py-1.5 pl-3 pr-2 text-sm $paddingLeft $activeClasses transition-colors ${classes ?? ""}',
      [Component.text(label)],
    );
  }
}

/// DuxtUI PageAsideGroup component - Group of links with optional title
class DPageAsideGroup extends StatelessComponent {
  /// Group title
  final String? title;

  /// Group links
  final List<Component> children;

  /// Whether the group is collapsible
  final bool collapsible;

  /// Whether the group is initially expanded (when collapsible)
  final bool defaultExpanded;

  /// Additional CSS classes
  final String? classes;

  const DPageAsideGroup({
    super.key,
    this.title,
    this.children = const [],
    this.collapsible = false,
    this.defaultExpanded = true,
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'mb-6 ${classes ?? ""}',
      [
        if (title != null)
          h5(
            classes:
                'text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3',
            [Component.text(title!)],
          ),
        div(
          classes: 'space-y-1',
          children,
        ),
      ],
    );
  }
}
