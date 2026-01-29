import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Breadcrumb separator style
enum UBreadcrumbSeparator { slash, chevron, arrow, dot }

/// DuxtUI Breadcrumb component
class UBreadcrumb extends StatelessComponent {
  final List<UBreadcrumbItem> items;
  final UBreadcrumbSeparator separator;
  final String? classes;

  const UBreadcrumb({
    super.key,
    required this.items,
    this.separator = UBreadcrumbSeparator.chevron,
    this.classes,
  });

  String get _separatorChar {
    switch (separator) {
      case UBreadcrumbSeparator.slash:
        return '/';
      case UBreadcrumbSeparator.chevron:
        return '\u203A'; // Unicode single right-pointing angle quotation mark
      case UBreadcrumbSeparator.arrow:
        return '\u2192'; // Unicode rightwards arrow
      case UBreadcrumbSeparator.dot:
        return '\u2022'; // Unicode bullet
    }
  }

  @override
  Component build(BuildContext context) {
    final List<Component> breadcrumbItems = [];

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = i == items.length - 1;

      breadcrumbItems.add(
        li(
          classes: 'flex items-center',
          [
            if (isLast)
              span(
                classes: 'text-sm font-medium text-gray-500 dark:text-gray-400',
                [
                  if (item.icon != null) item.icon!,
                  Component.text(item.label),
                ],
              )
            else
              a(
                href: item.href ?? '#',
                classes:
                    'text-sm font-medium text-gray-700 dark:text-gray-300 hover:text-gray-900 dark:hover:text-white transition-colors',
                [
                  if (item.icon != null) item.icon!,
                  Component.text(item.label),
                ],
              ),
            if (!isLast)
              span(
                classes: 'mx-2 text-gray-400 dark:text-gray-600 select-none',
                [Component.text(_separatorChar)],
              ),
          ],
        ),
      );
    }

    return Component.element(
      tag: 'nav',
      attributes: {'aria-label': 'Breadcrumb'},
      classes: classes ?? '',
      children: [
        ol(
          classes: 'flex items-center gap-2 text-sm',
          breadcrumbItems,
        ),
      ],
    );
  }
}

/// Breadcrumb item data
class UBreadcrumbItem extends StatelessComponent {
  final String label;
  final String? href;
  final Component? icon;

  const UBreadcrumbItem({
    super.key,
    required this.label,
    this.href,
    this.icon,
  });

  @override
  Component build(BuildContext context) {
    // This is mainly used as a data holder, but can render standalone
    if (href != null) {
      return a(
        href: href!,
        classes:
            'text-sm font-medium text-gray-700 dark:text-gray-300 hover:text-gray-900 dark:hover:text-white transition-colors',
        [
          if (icon != null) icon!,
          Component.text(label),
        ],
      );
    }
    return span(
      classes: 'text-sm font-medium text-gray-500 dark:text-gray-400',
      [
        if (icon != null) icon!,
        Component.text(label),
      ],
    );
  }
}
