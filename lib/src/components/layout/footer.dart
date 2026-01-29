import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Footer style variants
enum UFooterVariant { simple, columns, centered }

/// DuxtUI Footer component
class UFooter extends StatelessComponent {
  final List<Component> children;
  final Component? left;
  final Component? center;
  final Component? right;
  final UFooterVariant variant;
  final bool bordered;
  final String? classes;

  const UFooter({
    super.key,
    this.children = const [],
    this.left,
    this.center,
    this.right,
    this.variant = UFooterVariant.simple,
    this.bordered = true,
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    final borderClasses =
        bordered ? 'border-t border-gray-200 dark:border-gray-800' : '';
    final bgClasses = 'bg-white dark:bg-gray-900';

    // If left/center/right slots are provided, use structured layout
    if (left != null || center != null || right != null) {
      return Component.element(
        tag: 'footer',
        classes: '$bgClasses $borderClasses ${classes ?? ""}'.trim(),
        children: [
          div(
            classes: 'mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8',
            [
              div(
                classes:
                    'flex flex-col md:flex-row items-center justify-between gap-4',
                [
                  // Left slot
                  if (left != null)
                    div(classes: 'flex items-center gap-4', [left!]),
                  // Center slot
                  if (center != null)
                    div(classes: 'flex items-center gap-4', [center!]),
                  // Right slot
                  if (right != null)
                    div(classes: 'flex items-center gap-4', [right!]),
                ],
              ),
            ],
          ),
        ],
      );
    }

    // Simple footer with children
    return Component.element(
      tag: 'footer',
      classes: '$bgClasses $borderClasses ${classes ?? ""}'.trim(),
      children: [
        div(
          classes: 'mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8',
          children,
        ),
      ],
    );
  }
}

/// DuxtUI Footer Links section
class UFooterLinks extends StatelessComponent {
  final String? title;
  final List<UFooterLink> links;
  final String? classes;

  const UFooterLinks({
    super.key,
    this.title,
    this.links = const [],
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: classes ?? '',
      [
        if (title != null)
          h3(
            classes: 'text-sm font-semibold text-gray-900 dark:text-white',
            [Component.text(title!)],
          ),
        ul(
          classes: 'mt-4 space-y-2',
          links.map((link) => li([link])).toList(),
        ),
      ],
    );
  }
}

/// DuxtUI Footer Link item
class UFooterLink extends StatelessComponent {
  final String label;
  final String href;
  final bool external;
  final String? classes;

  const UFooterLink({
    super.key,
    required this.label,
    required this.href,
    this.external = false,
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    return a(
      href: href,
      target: external ? Target.blank : null,
      attributes: external ? {'rel': 'noopener noreferrer'} : null,
      classes:
          'text-sm text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors ${classes ?? ""}'
              .trim(),
      [
        Component.text(label),
        if (external)
          span(
            classes: 'ml-1 inline-block',
            [Component.text('\u2197')], // Unicode arrow for external link
          ),
      ],
    );
  }
}

/// DuxtUI Copyright text
class UCopyright extends StatelessComponent {
  final String text;
  final int? year;
  final String? classes;

  const UCopyright({
    super.key,
    required this.text,
    this.year,
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    final displayYear = year ?? DateTime.now().year;
    return p(
      classes:
          'text-sm text-gray-500 dark:text-gray-400 ${classes ?? ""}'.trim(),
      [Component.text('\u00A9 $displayYear $text')],
    );
  }
}
