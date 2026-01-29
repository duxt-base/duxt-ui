import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../../theme/variants.dart';

/// Skeleton variants matching common UI patterns
enum DSkeletonVariant { text, circular, rectangular }

/// DuxtUI Skeleton component - Loading placeholder
class DSkeleton extends StatelessComponent {
  final DSkeletonVariant variant;
  final String? width;
  final String? height;
  final bool animate;
  final String? classes;

  const DSkeleton({
    super.key,
    this.variant = DSkeletonVariant.text,
    this.width,
    this.height,
    this.animate = true,
    this.classes,
  });

  /// Creates a text line skeleton
  const DSkeleton.text({
    super.key,
    this.width,
    this.animate = true,
    this.classes,
  })  : variant = DSkeletonVariant.text,
        height = null;

  /// Creates a circular skeleton (for avatars)
  const DSkeleton.circular({
    super.key,
    String? size,
    this.animate = true,
    this.classes,
  })  : variant = DSkeletonVariant.circular,
        width = size ?? '2.5rem',
        height = size ?? '2.5rem';

  /// Creates a rectangular skeleton (for images/cards)
  const DSkeleton.rectangular({
    super.key,
    this.width,
    this.height,
    this.animate = true,
    this.classes,
  }) : variant = DSkeletonVariant.rectangular;

  String get _baseClasses {
    return cx([
      'bg-gray-200 dark:bg-gray-700',
      animate ? 'animate-pulse' : null,
    ]);
  }

  String get _shapeClasses {
    switch (variant) {
      case DSkeletonVariant.text:
        return 'h-4 rounded';
      case DSkeletonVariant.circular:
        return 'rounded-full';
      case DSkeletonVariant.rectangular:
        return 'rounded-lg';
    }
  }

  @override
  Component build(BuildContext context) {
    // Build inline style map
    final styleMap = <String, String>{};
    if (width != null) styleMap['width'] = width!;
    if (height != null) styleMap['height'] = height!;

    return div(
      classes: cx([_baseClasses, _shapeClasses, classes]),
      styles: styleMap.isNotEmpty ? Styles(raw: styleMap) : null,
      [],
    );
  }
}

/// Skeleton group for multiple lines
class DSkeletonGroup extends StatelessComponent {
  final int lines;
  final String? spacing;
  final bool animate;

  const DSkeletonGroup({
    super.key,
    this.lines = 3,
    this.spacing,
    this.animate = true,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'space-y-${spacing ?? "3"}',
      [
        for (int i = 0; i < lines; i++)
          DSkeleton.text(
            animate: animate,
            // Make last line shorter for natural look
            width: i == lines - 1 ? '75%' : null,
          ),
      ],
    );
  }
}

/// Skeleton card for card placeholders
class DSkeletonCard extends StatelessComponent {
  final bool showImage;
  final bool showAvatar;
  final int textLines;
  final bool animate;

  const DSkeletonCard({
    super.key,
    this.showImage = true,
    this.showAvatar = false,
    this.textLines = 3,
    this.animate = true,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'bg-white dark:bg-gray-900 rounded-lg border border-gray-200 dark:border-gray-800 overflow-hidden',
      [
        // Image placeholder
        if (showImage)
          DSkeleton.rectangular(
            width: '100%',
            height: '12rem',
            animate: animate,
            classes: 'rounded-none',
          ),
        // Content
        div(
          classes: 'p-4 space-y-4',
          [
            // Avatar and title row
            if (showAvatar)
              div(
                classes: 'flex items-center gap-3',
                [
                  DSkeleton.circular(animate: animate),
                  div(
                    classes: 'flex-1 space-y-2',
                    [
                      DSkeleton.text(width: '50%', animate: animate),
                      DSkeleton.text(width: '30%', animate: animate),
                    ],
                  ),
                ],
              ),
            // Text lines
            DSkeletonGroup(lines: textLines, animate: animate),
          ],
        ),
      ],
    );
  }
}
