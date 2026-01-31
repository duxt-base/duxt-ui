import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'blog_post.dart';

/// Grid column configuration
enum DBlogPostsColumns { one, two, three, four }

/// DuxtUI BlogPosts component - Grid of blog posts
///
/// Displays a responsive grid of DBlogPost components.
class DBlogPosts extends StatelessComponent {
  /// List of blog posts to display
  final List<DBlogPost> posts;

  /// Number of columns at large breakpoint
  final DBlogPostsColumns columns;

  /// Gap between posts
  final String gap;

  /// Additional CSS classes
  final String? classes;

  /// Optional title for the section
  final String? title;

  /// Optional description for the section
  final String? description;

  /// Empty state component when no posts
  final Component? emptyState;

  const DBlogPosts({
    super.key,
    required this.posts,
    this.columns = DBlogPostsColumns.three,
    this.gap = 'gap-8',
    this.classes,
    this.title,
    this.description,
    this.emptyState,
  });

  String get _columnClasses {
    switch (columns) {
      case DBlogPostsColumns.one:
        return 'grid-cols-1';
      case DBlogPostsColumns.two:
        return 'grid-cols-1 md:grid-cols-2';
      case DBlogPostsColumns.three:
        return 'grid-cols-1 md:grid-cols-2 lg:grid-cols-3';
      case DBlogPostsColumns.four:
        return 'grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4';
    }
  }

  @override
  Component build(BuildContext context) {
    final hasHeader = title != null || description != null;

    if (posts.isEmpty && emptyState != null) {
      return div(
        classes: classes,
        [
          if (hasHeader) _buildHeader(),
          emptyState!,
        ],
      );
    }

    return div(
      classes: classes,
      [
        if (hasHeader) _buildHeader(),
        div(
          classes: 'grid $_columnClasses $gap',
          posts,
        ),
      ],
    );
  }

  Component _buildHeader() {
    return div(
      classes: 'mb-8',
      [
        if (title != null)
          h2(
            classes:
                'text-2xl font-bold text-gray-900 dark:text-white sm:text-3xl',
            [Component.text(title!)],
          ),
        if (description != null)
          p(
            classes: 'mt-2 text-gray-600 dark:text-gray-400',
            [Component.text(description!)],
          ),
      ],
    );
  }
}

/// Empty state for blog posts
class DBlogPostsEmpty extends StatelessComponent {
  final String? title;
  final String? description;
  final Component? icon;
  final Component? action;

  const DBlogPostsEmpty({
    super.key,
    this.title,
    this.description,
    this.icon,
    this.action,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'flex flex-col items-center justify-center py-16 text-center',
      [
        if (icon != null)
          div(classes: 'mb-4 text-gray-400', [icon!])
        else
          div(
            classes: 'mb-4 text-gray-400',
            [
              // Default document icon
              RawText('''
                <svg class="h-12 w-12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
              '''),
            ],
          ),
        if (title != null)
          h3(
            classes: 'text-lg font-medium text-gray-900 dark:text-white',
            [Component.text(title!)],
          ),
        if (description != null)
          p(
            classes: 'mt-1 text-sm text-gray-500 dark:text-gray-400',
            [Component.text(description!)],
          ),
        if (action != null) div(classes: 'mt-4', [action!]),
      ],
    );
  }
}
