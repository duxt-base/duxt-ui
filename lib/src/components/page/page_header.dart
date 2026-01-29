import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Alignment options for page header content
enum UPageHeaderAlign { left, center, right }

/// DuxtUI PageHeader component - Responsive page header
///
/// Displays a page header with title, description, and optional links/actions.
class UPageHeader extends StatelessComponent {
  /// The main title
  final String? title;

  /// Optional description text
  final String? description;

  /// Optional headline/eyebrow text above the title
  final String? headline;

  /// Content alignment
  final UPageHeaderAlign align;

  /// Optional icon component
  final Component? icon;

  /// Optional links/buttons section
  final List<Component> links;

  /// Additional CSS classes
  final String? classes;

  /// Custom title component (overrides title string)
  final Component? titleSlot;

  /// Custom description component (overrides description string)
  final Component? descriptionSlot;

  const UPageHeader({
    super.key,
    this.title,
    this.description,
    this.headline,
    this.align = UPageHeaderAlign.left,
    this.icon,
    this.links = const [],
    this.classes,
    this.titleSlot,
    this.descriptionSlot,
  });

  String get _alignClasses {
    switch (align) {
      case UPageHeaderAlign.left:
        return 'text-left';
      case UPageHeaderAlign.center:
        return 'text-center';
      case UPageHeaderAlign.right:
        return 'text-right';
    }
  }

  String get _linksAlignClasses {
    switch (align) {
      case UPageHeaderAlign.left:
        return 'justify-start';
      case UPageHeaderAlign.center:
        return 'justify-center';
      case UPageHeaderAlign.right:
        return 'justify-end';
    }
  }

  @override
  Component build(BuildContext context) {
    return header(
      classes: 'py-8 sm:py-16 lg:py-24 $_alignClasses ${classes ?? ""}',
      [
        div(
          classes:
              'max-w-4xl ${align == UPageHeaderAlign.center ? "mx-auto" : ""}',
          [
            // Icon (if provided)
            if (icon != null)
              div(
                classes:
                    'mb-6 ${align == UPageHeaderAlign.center ? "flex justify-center" : ""}',
                [icon!],
              ),
            // Headline/eyebrow
            if (headline != null)
              p(
                classes:
                    'text-sm font-semibold text-primary-500 dark:text-primary-400 mb-2',
                [Component.text(headline!)],
              ),
            // Title
            if (titleSlot != null)
              titleSlot!
            else if (title != null)
              h1(
                classes:
                    'text-3xl sm:text-4xl lg:text-5xl font-bold text-gray-900 dark:text-white tracking-tight',
                [Component.text(title!)],
              ),
            // Description
            if (descriptionSlot != null)
              div(classes: 'mt-4 sm:mt-6', [descriptionSlot!])
            else if (description != null)
              p(
                classes:
                    'mt-4 sm:mt-6 text-lg sm:text-xl text-gray-600 dark:text-gray-300',
                [Component.text(description!)],
              ),
            // Links/actions
            if (links.isNotEmpty)
              div(
                classes:
                    'mt-8 sm:mt-10 flex flex-wrap gap-3 $_linksAlignClasses',
                links,
              ),
          ],
        ),
      ],
    );
  }
}
