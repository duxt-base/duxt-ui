import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Author information for blog posts
class DBlogAuthor {
  final String name;
  final String? avatar;
  final String? role;

  const DBlogAuthor({
    required this.name,
    this.avatar,
    this.role,
  });
}

/// Blog post orientation
enum DBlogPostOrientation { vertical, horizontal }

/// DuxtUI BlogPost component - Article card
///
/// Displays a blog post preview with image, title, excerpt, author, and date.
class DBlogPost extends StatelessComponent {
  /// The post title
  final String title;

  /// Post excerpt/description
  final String? excerpt;

  /// Featured image DRL
  final String? image;

  /// Image alt text
  final String? imageAlt;

  /// Author information
  final DBlogAuthor? author;

  /// Publication date string
  final String? date;

  /// Post category or tag
  final String? category;

  /// Category badge color
  final String? categoryColor;

  /// Reading time (e.g., "5 min read")
  final String? readingTime;

  /// Link DRL for the post
  final String? href;

  /// Layout orientation
  final DBlogPostOrientation orientation;

  /// Additional CSS classes
  final String? classes;

  /// Click handler
  final VoidCallback? onClick;

  const DBlogPost({
    super.key,
    required this.title,
    this.excerpt,
    this.image,
    this.imageAlt,
    this.author,
    this.date,
    this.category,
    this.categoryColor,
    this.readingTime,
    this.href,
    this.orientation = DBlogPostOrientation.vertical,
    this.classes,
    this.onClick,
  });

  @override
  Component build(BuildContext context) {
    final isHorizontal = orientation == DBlogPostOrientation.horizontal;

    final imageComponent = image != null
        ? div(
            classes: isHorizontal ? 'flex-shrink-0 w-48 md:w-64' : 'w-full',
            [
              img(
                src: image!,
                alt: imageAlt ?? title,
                classes:
                    'aspect-video w-full rounded-lg object-cover transition-transform duration-300 group-hover:scale-105',
              ),
            ],
          )
        : null;

    final categoryBadge = category != null
        ? span(
            classes:
                'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${categoryColor ?? "bg-primary-100 text-primary-700 dark:bg-primary-900 dark:text-primary-300"}',
            [Component.text(category!)],
          )
        : null;

    final titleComponent = h3(
      classes:
          'text-lg font-semibold text-gray-900 dark:text-white group-hover:text-primary-500 dark:group-hover:text-primary-400 transition-colors line-clamp-2',
      [Component.text(title)],
    );

    final excerptComponent = excerpt != null
        ? p(
            classes:
                'mt-2 text-sm text-gray-600 dark:text-gray-400 line-clamp-2',
            [Component.text(excerpt!)],
          )
        : null;

    final metaComponent = div(
      classes: 'mt-4 flex items-center gap-3',
      [
        if (author != null) ...[
          if (author!.avatar != null)
            img(
              src: author!.avatar!,
              alt: author!.name,
              classes: 'h-8 w-8 rounded-full object-cover',
            )
          else
            div(
              classes:
                  'h-8 w-8 rounded-full bg-gray-200 dark:bg-zinc-700 flex items-center justify-center text-sm font-medium text-gray-600 dark:text-gray-300',
              [
                Component.text(author!.name.isNotEmpty
                    ? author!.name[0].toUpperCase()
                    : '?')
              ],
            ),
          div([
            p(
              classes: 'text-sm font-medium text-gray-900 dark:text-white',
              [Component.text(author!.name)],
            ),
            if (author!.role != null)
              p(
                classes: 'text-xs text-gray-500 dark:text-gray-400',
                [Component.text(author!.role!)],
              ),
          ]),
        ],
        if (date != null || readingTime != null)
          div(
            classes:
                'flex items-center gap-2 text-sm text-gray-500 dark:text-gray-400 ${author != null ? "ml-auto" : ""}',
            [
              if (date != null) span([Component.text(date!)]),
              if (date != null && readingTime != null)
                span(
                    classes: 'text-gray-300 dark:text-gray-600',
                    [Component.text('|')]),
              if (readingTime != null) span([Component.text(readingTime!)]),
            ],
          ),
      ],
    );

    final content = div(
      classes: isHorizontal ? 'flex-1 min-w-0' : '',
      [
        if (categoryBadge != null) div(classes: 'mb-2', [categoryBadge]),
        titleComponent,
        if (excerptComponent != null) excerptComponent,
        metaComponent,
      ],
    );

    final cardClasses = [
      'group',
      'flex',
      isHorizontal ? 'flex-row gap-6' : 'flex-col',
      'cursor-pointer',
      classes ?? '',
    ].where((c) => c.isNotEmpty).join(' ');

    final cardContent = [
      if (imageComponent != null) imageComponent,
      content,
    ];

    if (href != null) {
      return a(
        href: href!,
        classes: cardClasses,
        cardContent,
      );
    }

    return div(
      classes: cardClasses,
      events: onClick != null ? events(onClick: onClick!) : null,
      cardContent,
    );
  }
}
