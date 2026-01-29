import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI PageBody component - Main content section with optional TOC
///
/// Provides a flex layout with optional table of contents sidebar.
class UPageBody extends StatelessComponent {
  /// Prose content (main text content)
  final List<Component> prose;

  /// Optional table of contents or sidebar content
  final Component? toc;

  /// Additional CSS classes
  final String? classes;

  /// Additional CSS classes for the prose section
  final String? proseClasses;

  const UPageBody({
    super.key,
    this.prose = const [],
    this.toc,
    this.classes,
    this.proseClasses,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'flex flex-col lg:flex-row lg:gap-8 ${classes ?? ""}',
      [
        // Main prose content
        div(
          classes: 'flex-1 min-w-0 ${proseClasses ?? ""}',
          [
            div(
              classes: 'prose prose-gray dark:prose-invert max-w-none',
              prose,
            ),
          ],
        ),
        // Table of contents (if provided)
        if (toc != null)
          div(
            classes: 'hidden lg:block lg:w-48 xl:w-56 shrink-0',
            [
              div(
                classes: 'sticky top-16',
                [toc!],
              ),
            ],
          ),
      ],
    );
  }
}
