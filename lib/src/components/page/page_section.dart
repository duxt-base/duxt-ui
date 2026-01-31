import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI PageSection component - Section with optional background
///
/// A page section with responsive padding and optional background styling.
class DPageSection extends StatelessComponent {
  /// Section ID for anchor links
  final String? id;

  /// The main title
  final String? title;

  /// Optional description text
  final String? description;

  /// Optional headline/eyebrow text above the title
  final String? headline;

  /// Content alignment for header
  final DPageSectionAlign align;

  /// Section content
  final List<Component> children;

  /// Enable alternate background (gray)
  final bool background;

  /// Custom background classes
  final String? backgroundClasses;

  /// Additional CSS classes
  final String? classes;

  /// Optional icon component
  final Component? icon;

  /// Optional links/buttons in header
  final List<Component> links;

  /// Custom slot for section header
  final Component? headerSlot;

  const DPageSection({
    super.key,
    this.id,
    this.title,
    this.description,
    this.headline,
    this.align = DPageSectionAlign.center,
    this.children = const [],
    this.background = false,
    this.backgroundClasses,
    this.classes,
    this.icon,
    this.links = const [],
    this.headerSlot,
  });

  String get _alignClasses {
    switch (align) {
      case DPageSectionAlign.left:
        return 'text-left';
      case DPageSectionAlign.center:
        return 'text-center mx-auto';
      case DPageSectionAlign.right:
        return 'text-right ml-auto';
    }
  }

  @override
  Component build(BuildContext context) {
    final bgClasses = background
        ? (backgroundClasses ?? 'bg-gray-50 dark:bg-zinc-900/50')
        : '';
    final hasHeader =
        title != null || description != null || headerSlot != null;

    return section(
      id: id,
      classes: 'py-12 sm:py-16 lg:py-20 $bgClasses ${classes ?? ""}',
      [
        div(
          classes: 'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8',
          [
            // Section header
            if (hasHeader)
              div(
                classes: 'max-w-2xl $_alignClasses mb-12 sm:mb-16',
                [
                  if (headerSlot != null)
                    headerSlot!
                  else ...[
                    // Icon
                    if (icon != null)
                      div(
                        classes:
                            'mb-4 ${align == DPageSectionAlign.center ? "flex justify-center" : ""}',
                        [icon!],
                      ),
                    // Headline/eyebrow
                    if (headline != null)
                      p(
                        classes:
                            'text-sm font-semibold text-primary-500 dark:text-primary-400 uppercase tracking-wide mb-2',
                        [Component.text(headline!)],
                      ),
                    // Title
                    if (title != null)
                      h2(
                        classes:
                            'text-2xl sm:text-3xl lg:text-4xl font-bold text-gray-900 dark:text-white tracking-tight',
                        [Component.text(title!)],
                      ),
                    // Description
                    if (description != null)
                      p(
                        classes:
                            'mt-4 text-lg text-gray-600 dark:text-gray-300',
                        [Component.text(description!)],
                      ),
                    // Links
                    if (links.isNotEmpty)
                      div(
                        classes:
                            'mt-6 flex flex-wrap gap-3 ${align == DPageSectionAlign.center ? "justify-center" : ""}',
                        links,
                      ),
                  ],
                ],
              ),
            // Section content
            ...children,
          ],
        ),
      ],
    );
  }
}

/// Alignment options for page section content
enum DPageSectionAlign { left, center, right }
