import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Avatar sizes matching Nuxt UI
enum DAvatarSize { xxxs, xxs, xs, sm, md, lg, xl, xxl, xxxl }

/// Avatar chip position
enum DAvatarChipPosition { topRight, bottomRight, topLeft, bottomLeft }

/// DuxtUI Avatar component - Nuxt UI compatible
class DAvatar extends StatelessComponent {
  final String? src;
  final String? alt;
  final String? text;
  final Component? icon;
  final DAvatarSize size;
  final bool? chipColor;
  final String? chipText;
  final DAvatarChipPosition chipPosition;

  const DAvatar({
    super.key,
    this.src,
    this.alt,
    this.text,
    this.icon,
    this.size = DAvatarSize.md,
    this.chipColor,
    this.chipText,
    this.chipPosition = DAvatarChipPosition.topRight,
  });

  String get _sizeClasses {
    switch (size) {
      case DAvatarSize.xxxs:
        return 'size-4 text-[8px]';
      case DAvatarSize.xxs:
        return 'size-5 text-[10px]';
      case DAvatarSize.xs:
        return 'size-6 text-xs';
      case DAvatarSize.sm:
        return 'size-8 text-sm';
      case DAvatarSize.md:
        return 'size-10 text-base';
      case DAvatarSize.lg:
        return 'size-12 text-lg';
      case DAvatarSize.xl:
        return 'size-14 text-xl';
      case DAvatarSize.xxl:
        return 'size-16 text-2xl';
      case DAvatarSize.xxxl:
        return 'size-20 text-3xl';
    }
  }

  String get _iconSizeClasses {
    switch (size) {
      case DAvatarSize.xxxs:
      case DAvatarSize.xxs:
        return 'size-2';
      case DAvatarSize.xs:
        return 'size-3';
      case DAvatarSize.sm:
        return 'size-4';
      case DAvatarSize.md:
        return 'size-5';
      case DAvatarSize.lg:
        return 'size-6';
      case DAvatarSize.xl:
      case DAvatarSize.xxl:
      case DAvatarSize.xxxl:
        return 'size-8';
    }
  }

  String get _chipPositionClasses {
    switch (chipPosition) {
      case DAvatarChipPosition.topRight:
        return 'top-0 right-0';
      case DAvatarChipPosition.bottomRight:
        return 'bottom-0 right-0';
      case DAvatarChipPosition.topLeft:
        return 'top-0 left-0';
      case DAvatarChipPosition.bottomLeft:
        return 'bottom-0 left-0';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'relative inline-flex',
      [
        // Avatar container
        div(
          classes:
              '$_sizeClasses rounded-full overflow-hidden bg-gray-100 dark:bg-gray-800 flex items-center justify-center font-medium text-gray-600 dark:text-gray-300',
          [
            if (src != null)
              img(
                src: src!,
                alt: alt ?? '',
                classes: 'size-full object-cover',
              )
            else if (icon != null)
              span(classes: _iconSizeClasses, [icon!])
            else if (text != null)
              Component.text(text!
                  .substring(0, text!.length > 2 ? 2 : text!.length)
                  .toUpperCase())
            else
              // Default user icon placeholder
              span(
                  classes: '$_iconSizeClasses text-gray-400 dark:text-gray-500',
                  [Component.text('?')]),
          ],
        ),
        // Chip indicator
        if (chipColor != null || chipText != null)
          div(
            classes:
                'absolute $_chipPositionClasses transform translate-x-1/4 -translate-y-1/4',
            [
              if (chipText != null)
                span(
                  classes:
                      'flex items-center justify-center min-w-4 h-4 px-1 text-[10px] font-medium bg-green-500 text-white rounded-full ring-2 ring-white dark:ring-gray-900',
                  [Component.text(chipText!)],
                )
              else
                span(
                  classes:
                      'block size-2.5 bg-green-500 rounded-full ring-2 ring-white dark:ring-gray-900',
                  [],
                ),
            ],
          ),
      ],
    );
  }
}

/// DuxtUI Avatar Group - Nuxt UI compatible
class DAvatarGroup extends StatelessComponent {
  final List<DAvatar> avatars;
  final int max;
  final DAvatarSize size;

  const DAvatarGroup({
    super.key,
    required this.avatars,
    this.max = 4,
    this.size = DAvatarSize.md,
  });

  String get _sizeClasses {
    switch (size) {
      case DAvatarSize.xxxs:
        return 'size-4 text-[8px]';
      case DAvatarSize.xxs:
        return 'size-5 text-[10px]';
      case DAvatarSize.xs:
        return 'size-6 text-xs';
      case DAvatarSize.sm:
        return 'size-8 text-sm';
      case DAvatarSize.md:
        return 'size-10 text-base';
      case DAvatarSize.lg:
        return 'size-12 text-lg';
      case DAvatarSize.xl:
        return 'size-14 text-xl';
      case DAvatarSize.xxl:
        return 'size-16 text-2xl';
      case DAvatarSize.xxxl:
        return 'size-20 text-3xl';
    }
  }

  @override
  Component build(BuildContext context) {
    final visible = avatars.take(max).toList();
    final remaining = avatars.length - max;

    return div(classes: 'flex -space-x-2', [
      for (final avatar in visible)
        div(
            classes: 'ring-2 ring-white dark:ring-gray-900 rounded-full',
            [avatar]),
      if (remaining > 0)
        div(
          classes:
              '$_sizeClasses rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center font-medium text-gray-600 dark:text-gray-300 ring-2 ring-white dark:ring-gray-900',
          [Component.text('+$remaining')],
        ),
    ]);
  }
}
