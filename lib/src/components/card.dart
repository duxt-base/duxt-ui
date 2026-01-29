import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Card variants matching Nuxt UI
enum DCardVariant { solid, outline, soft, subtle }

/// DuxtUI Card component - Nuxt UI compatible
class DCard extends StatelessComponent {
  final Component? header;
  final Component? footer;
  final List<Component> children;
  final DCardVariant variant;
  final String? classes;
  final bool noPadding;

  const DCard({
    super.key,
    this.header,
    this.footer,
    this.children = const [],
    this.variant = DCardVariant.outline,
    this.classes,
    this.noPadding = false,
  });

  String get _baseClasses => 'rounded-lg overflow-hidden';

  String get _variantClasses {
    switch (variant) {
      case DCardVariant.solid:
        return 'bg-gray-900 text-white dark:bg-white dark:text-gray-900';
      case DCardVariant.outline:
        return 'bg-white ring ring-gray-200 divide-y divide-gray-200 dark:bg-gray-900 dark:ring-gray-800 dark:divide-gray-800';
      case DCardVariant.soft:
        return 'bg-gray-50/50 divide-y divide-gray-200 dark:bg-gray-800/50 dark:divide-gray-800';
      case DCardVariant.subtle:
        return 'bg-gray-50/50 ring ring-gray-200 divide-y divide-gray-200 dark:bg-gray-800/50 dark:ring-gray-800 dark:divide-gray-800';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: '$_baseClasses $_variantClasses ${classes ?? ""}'.trim(),
      [
        if (header != null) div(classes: 'p-4 sm:px-6', [header!]),
        div(classes: noPadding ? '' : 'p-4 sm:p-6', children),
        if (footer != null) div(classes: 'p-4 sm:px-6', [footer!]),
      ],
    );
  }
}

/// DuxtUI Card Header
class DCardHeader extends StatelessComponent {
  final String? title;
  final String? description;
  final Component? trailing;
  final List<Component> children;

  const DCardHeader({
    super.key,
    this.title,
    this.description,
    this.trailing,
    this.children = const [],
  });

  @override
  Component build(BuildContext context) {
    return div(classes: 'flex items-start justify-between gap-4', [
      div(classes: 'flex-1 min-w-0', [
        if (title != null)
          h3(
              classes:
                  'text-base font-semibold text-gray-900 dark:text-white truncate',
              [Component.text(title!)]),
        if (description != null)
          p(
              classes: 'text-sm text-gray-500 dark:text-gray-400 mt-1',
              [Component.text(description!)]),
        ...children,
      ]),
      if (trailing != null) trailing!,
    ]);
  }
}

/// DuxtUI Card Body
class DCardBody extends StatelessComponent {
  final List<Component> children;
  final String? classes;

  const DCardBody({
    super.key,
    this.children = const [],
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    return div(classes: classes, children);
  }
}

/// DuxtUI Card Footer
class DCardFooter extends StatelessComponent {
  final List<Component> children;
  final String? classes;

  const DCardFooter({
    super.key,
    this.children = const [],
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    return div(
        classes: 'flex items-center justify-end gap-3 ${classes ?? ""}'.trim(),
        children);
  }
}
