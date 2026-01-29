import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// DuxtUI Empty component - Empty state display
class DEmpty extends StatelessComponent {
  final String? icon;
  final Component? iconComponent;
  final String? title;
  final String? description;
  final Component? action;
  final List<Component> children;
  final DSize size;
  final bool padded;

  const DEmpty({
    super.key,
    this.icon,
    this.iconComponent,
    this.title,
    this.description,
    this.action,
    this.children = const [],
    this.size = DSize.md,
    this.padded = true,
  });

  String get _iconSizeClasses {
    switch (size) {
      case DSize.xs:
        return 'text-3xl';
      case DSize.sm:
        return 'text-4xl';
      case DSize.md:
        return 'text-5xl';
      case DSize.lg:
        return 'text-6xl';
      case DSize.xl:
        return 'text-7xl';
    }
  }

  String get _titleSizeClasses {
    switch (size) {
      case DSize.xs:
        return 'text-sm';
      case DSize.sm:
        return 'text-base';
      case DSize.md:
        return 'text-lg';
      case DSize.lg:
        return 'text-xl';
      case DSize.xl:
        return 'text-2xl';
    }
  }

  String get _descriptionSizeClasses {
    switch (size) {
      case DSize.xs:
        return 'text-xs';
      case DSize.sm:
        return 'text-sm';
      case DSize.md:
        return 'text-sm';
      case DSize.lg:
        return 'text-base';
      case DSize.xl:
        return 'text-lg';
    }
  }

  String get _paddingClasses {
    if (!padded) return '';
    switch (size) {
      case DSize.xs:
        return 'py-6';
      case DSize.sm:
        return 'py-8';
      case DSize.md:
        return 'py-12';
      case DSize.lg:
        return 'py-16';
      case DSize.xl:
        return 'py-20';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: cx([
        'flex flex-col items-center justify-center text-center',
        _paddingClasses,
      ]),
      [
        // Icon
        if (iconComponent != null)
          div(
            classes: cx([
              'mb-4',
              DTextColors.muted,
            ]),
            [iconComponent!],
          )
        else if (icon != null)
          div(
            classes: cx([
              'mb-4',
              _iconSizeClasses,
              DTextColors.muted,
            ]),
            [Component.text(icon!)],
          )
        else
          // Default empty icon
          div(
            classes: cx([
              'mb-4',
              _iconSizeClasses,
              DTextColors.muted,
            ]),
            [Component.text('\u{1F4ED}')], // Empty mailbox emoji as default
          ),
        // Title
        if (title != null)
          h3(
            classes: cx([
              'font-semibold',
              _titleSizeClasses,
              DTextColors.highlighted,
              'mb-2',
            ]),
            [Component.text(title!)],
          ),
        // Description
        if (description != null)
          p(
            classes: cx([
              _descriptionSizeClasses,
              DTextColors.muted,
              'max-w-sm',
              'mb-4',
            ]),
            [Component.text(description!)],
          ),
        // Custom children
        if (children.isNotEmpty) div(classes: 'mt-2', children),
        // Action button
        if (action != null) div(classes: 'mt-4', [action!]),
      ],
    );
  }
}

/// Preset empty state for no data
class DEmptyNoData extends StatelessComponent {
  final Component? action;

  const DEmptyNoData({super.key, this.action});

  @override
  Component build(BuildContext context) {
    return DEmpty(
      icon: '\u{1F4C2}', // Open folder
      title: 'No data',
      description: 'There is no data to display at the moment.',
      action: action,
    );
  }
}

/// Preset empty state for no results
class DEmptyNoResults extends StatelessComponent {
  final String? searchTerm;
  final Component? action;

  const DEmptyNoResults({super.key, this.searchTerm, this.action});

  @override
  Component build(BuildContext context) {
    return DEmpty(
      icon: '\u{1F50D}', // Magnifying glass
      title: 'No results found',
      description: searchTerm != null
          ? 'No results found for "$searchTerm". Try a different search term.'
          : 'No results match your search criteria.',
      action: action,
    );
  }
}
