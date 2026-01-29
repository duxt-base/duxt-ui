import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Header style variants
enum UHeaderVariant { solid, transparent, blur }

/// DuxtUI Header component - sticky header with backdrop blur
class UHeader extends StatelessComponent {
  final List<Component> children;
  final Component? left;
  final Component? center;
  final Component? right;
  final UHeaderVariant variant;
  final bool sticky;
  final bool bordered;
  final String? classes;

  const UHeader({
    super.key,
    this.children = const [],
    this.left,
    this.center,
    this.right,
    this.variant = UHeaderVariant.blur,
    this.sticky = true,
    this.bordered = true,
    this.classes,
  });

  String get _variantClasses {
    switch (variant) {
      case UHeaderVariant.solid:
        return 'bg-white dark:bg-gray-900';
      case UHeaderVariant.transparent:
        return 'bg-transparent';
      case UHeaderVariant.blur:
        return 'bg-white/80 dark:bg-gray-900/80 backdrop-blur-lg backdrop-saturate-150';
    }
  }

  @override
  Component build(BuildContext context) {
    final stickyClasses = sticky ? 'sticky top-0 z-50' : '';
    final borderClasses =
        bordered ? 'border-b border-gray-200 dark:border-gray-800' : '';

    // If left/center/right slots are provided, use structured layout
    if (left != null || center != null || right != null) {
      return Component.element(
        tag: 'header',
        classes:
            '$stickyClasses $_variantClasses $borderClasses ${classes ?? ""}'
                .trim(),
        children: [
          div(
            classes: 'mx-auto max-w-7xl px-4 sm:px-6 lg:px-8',
            [
              div(
                classes: 'flex h-16 items-center justify-between',
                [
                  // Left slot
                  div(
                    classes: 'flex items-center gap-4',
                    [if (left != null) left!],
                  ),
                  // Center slot
                  if (center != null)
                    div(
                      classes: 'hidden md:flex flex-1 justify-center',
                      [center!],
                    ),
                  // Right slot
                  div(
                    classes: 'flex items-center gap-4',
                    [if (right != null) right!],
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }

    // Simple header with children
    return Component.element(
      tag: 'header',
      classes: '$stickyClasses $_variantClasses $borderClasses ${classes ?? ""}'
          .trim(),
      children: [
        div(
          classes: 'mx-auto max-w-7xl px-4 sm:px-6 lg:px-8',
          [
            div(
              classes: 'flex h-16 items-center',
              children,
            ),
          ],
        ),
      ],
    );
  }
}

/// DuxtUI Page Header - header for page content (not sticky nav)
class UPageHeader extends StatelessComponent {
  final String? title;
  final String? description;
  final Component? actions;
  final List<Component> children;
  final String? classes;

  const UPageHeader({
    super.key,
    this.title,
    this.description,
    this.actions,
    this.children = const [],
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'pb-5 border-b border-gray-200 dark:border-gray-800 ${classes ?? ""}'
              .trim(),
      [
        div(
          classes: 'sm:flex sm:items-center sm:justify-between',
          [
            div([
              if (title != null)
                h1(
                  classes:
                      'text-2xl font-bold text-gray-900 dark:text-white sm:text-3xl',
                  [Component.text(title!)],
                ),
              if (description != null)
                p(
                  classes: 'mt-2 text-sm text-gray-500 dark:text-gray-400',
                  [Component.text(description!)],
                ),
              ...children,
            ]),
            if (actions != null)
              div(
                classes: 'mt-4 sm:mt-0 sm:ml-4',
                [actions!],
              ),
          ],
        ),
      ],
    );
  }
}
