import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../../theme/variants.dart';

/// Skeleton variants matching common UI patterns
enum USkeletonVariant { text, circular, rectangular }

/// DuxtUI Skeleton component - Loading placeholder
class USkeleton extends StatelessComponent {
  final USkeletonVariant variant;
  final String? width;
  final String? height;
  final bool animate;
  final String? classes;

  const USkeleton({
    super.key,
    this.variant = USkeletonVariant.text,
    this.width,
    this.height,
    this.animate = true,
    this.classes,
  });

  /// Creates a text line skeleton
  const USkeleton.text({
    super.key,
    this.width,
    this.animate = true,
    this.classes,
  })  : variant = USkeletonVariant.text,
        height = null;

  /// Creates a circular skeleton (for avatars)
  const USkeleton.circular({
    super.key,
    String? size,
    this.animate = true,
    this.classes,
  })  : variant = USkeletonVariant.circular,
        width = size ?? '2.5rem',
        height = size ?? '2.5rem';

  /// Creates a rectangular skeleton (for images/cards)
  const USkeleton.rectangular({
    super.key,
    this.width,
    this.height,
    this.animate = true,
    this.classes,
  }) : variant = USkeletonVariant.rectangular;

  String get _baseClasses {
    return cx([
      'bg-gray-200 dark:bg-gray-700',
      animate ? 'animate-pulse' : null,
    ]);
  }

  String get _shapeClasses {
    switch (variant) {
      case USkeletonVariant.text:
        return 'h-4 rounded';
      case USkeletonVariant.circular:
        return 'rounded-full';
      case USkeletonVariant.rectangular:
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
class USkeletonGroup extends StatelessComponent {
  final int lines;
  final String? spacing;
  final bool animate;

  const USkeletonGroup({
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
          USkeleton.text(
            animate: animate,
            // Make last line shorter for natural look
            width: i == lines - 1 ? '75%' : null,
          ),
      ],
    );
  }
}

/// Skeleton card for card placeholders
class USkeletonCard extends StatelessComponent {
  final bool showImage;
  final bool showAvatar;
  final int textLines;
  final bool animate;

  const USkeletonCard({
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
          USkeleton.rectangular(
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
                  USkeleton.circular(animate: animate),
                  div(
                    classes: 'flex-1 space-y-2',
                    [
                      USkeleton.text(width: '50%', animate: animate),
                      USkeleton.text(width: '30%', animate: animate),
                    ],
                  ),
                ],
              ),
            // Text lines
            USkeletonGroup(lines: textLines, animate: animate),
          ],
        ),
      ],
    );
  }
}
