import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// DuxtUI Empty component - Empty state display
class UEmpty extends StatelessComponent {
  final String? icon;
  final Component? iconComponent;
  final String? title;
  final String? description;
  final Component? action;
  final List<Component> children;
  final USize size;
  final bool padded;

  const UEmpty({
    super.key,
    this.icon,
    this.iconComponent,
    this.title,
    this.description,
    this.action,
    this.children = const [],
    this.size = USize.md,
    this.padded = true,
  });

  String get _iconSizeClasses {
    switch (size) {
      case USize.xs:
        return 'text-3xl';
      case USize.sm:
        return 'text-4xl';
      case USize.md:
        return 'text-5xl';
      case USize.lg:
        return 'text-6xl';
      case USize.xl:
        return 'text-7xl';
    }
  }

  String get _titleSizeClasses {
    switch (size) {
      case USize.xs:
        return 'text-sm';
      case USize.sm:
        return 'text-base';
      case USize.md:
        return 'text-lg';
      case USize.lg:
        return 'text-xl';
      case USize.xl:
        return 'text-2xl';
    }
  }

  String get _descriptionSizeClasses {
    switch (size) {
      case USize.xs:
        return 'text-xs';
      case USize.sm:
        return 'text-sm';
      case USize.md:
        return 'text-sm';
      case USize.lg:
        return 'text-base';
      case USize.xl:
        return 'text-lg';
    }
  }

  String get _paddingClasses {
    if (!padded) return '';
    switch (size) {
      case USize.xs:
        return 'py-6';
      case USize.sm:
        return 'py-8';
      case USize.md:
        return 'py-12';
      case USize.lg:
        return 'py-16';
      case USize.xl:
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
              UTextColors.muted,
            ]),
            [iconComponent!],
          )
        else if (icon != null)
          div(
            classes: cx([
              'mb-4',
              _iconSizeClasses,
              UTextColors.muted,
            ]),
            [Component.text(icon!)],
          )
        else
          // Default empty icon
          div(
            classes: cx([
              'mb-4',
              _iconSizeClasses,
              UTextColors.muted,
            ]),
            [Component.text('\u{1F4ED}')], // Empty mailbox emoji as default
          ),
        // Title
        if (title != null)
          h3(
            classes: cx([
              'font-semibold',
              _titleSizeClasses,
              UTextColors.highlighted,
              'mb-2',
            ]),
            [Component.text(title!)],
          ),
        // Description
        if (description != null)
          p(
            classes: cx([
              _descriptionSizeClasses,
              UTextColors.muted,
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
class UEmptyNoData extends StatelessComponent {
  final Component? action;

  const UEmptyNoData({super.key, this.action});

  @override
  Component build(BuildContext context) {
    return UEmpty(
      icon: '\u{1F4C2}', // Open folder
      title: 'No data',
      description: 'There is no data to display at the moment.',
      action: action,
    );
  }
}

/// Preset empty state for no results
class UEmptyNoResults extends StatelessComponent {
  final String? searchTerm;
  final Component? action;

  const UEmptyNoResults({super.key, this.searchTerm, this.action});

  @override
  Component build(BuildContext context) {
    return UEmpty(
      icon: '\u{1F50D}', // Magnifying glass
      title: 'No results found',
      description: searchTerm != null
          ? 'No results found for "$searchTerm". Try a different search term.'
          : 'No results match your search criteria.',
      action: action,
    );
  }
}
