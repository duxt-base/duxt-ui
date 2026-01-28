import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Avatar sizes
enum UAvatarSize { xs, sm, md, lg, xl }

/// DuxtUI Avatar component
class UAvatar extends StatelessComponent {
  final String? src;
  final String? alt;
  final String? initials;
  final UAvatarSize size;
  final String? bgColor;

  const UAvatar({
    super.key,
    this.src,
    this.alt,
    this.initials,
    this.size = UAvatarSize.md,
    this.bgColor,
  });

  String get _sizeClasses {
    switch (size) {
      case UAvatarSize.xs:
        return 'h-6 w-6 text-xs';
      case UAvatarSize.sm:
        return 'h-8 w-8 text-sm';
      case UAvatarSize.md:
        return 'h-10 w-10 text-base';
      case UAvatarSize.lg:
        return 'h-12 w-12 text-lg';
      case UAvatarSize.xl:
        return 'h-16 w-16 text-xl';
    }
  }

  @override
  Component build(BuildContext context) {
    if (src != null) {
      return img(
        src: src!,
        alt: alt ?? '',
        classes: '$_sizeClasses rounded-full object-cover',
      );
    }

    return div(
      classes: '$_sizeClasses rounded-full flex items-center justify-center font-medium text-white ${bgColor ?? "bg-indigo-600"}',
      [
        text(initials ?? '?'),
      ],
    );
  }
}

/// DuxtUI Avatar Group
class UAvatarGroup extends StatelessComponent {
  final List<UAvatar> avatars;
  final int max;
  final UAvatarSize size;

  const UAvatarGroup({
    super.key,
    required this.avatars,
    this.max = 4,
    this.size = UAvatarSize.md,
  });

  @override
  Component build(BuildContext context) {
    final visible = avatars.take(max).toList();
    final remaining = avatars.length - max;

    return div(classes: 'flex -space-x-2', [
      for (final avatar in visible)
        div(classes: 'ring-2 ring-white rounded-full', [avatar]),
      if (remaining > 0)
        div(
          classes: '${_sizeForGroup} rounded-full bg-gray-200 flex items-center justify-center text-sm font-medium text-gray-600 ring-2 ring-white',
          [text('+$remaining')],
        ),
    ]);
  }

  String get _sizeForGroup {
    switch (size) {
      case UAvatarSize.xs:
        return 'h-6 w-6';
      case UAvatarSize.sm:
        return 'h-8 w-8';
      case UAvatarSize.md:
        return 'h-10 w-10';
      case UAvatarSize.lg:
        return 'h-12 w-12';
      case UAvatarSize.xl:
        return 'h-16 w-16';
    }
  }
}
