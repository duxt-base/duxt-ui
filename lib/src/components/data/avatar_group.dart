import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/colors.dart';
import '../avatar.dart';

// Re-export DAvatar for convenience (hide DAvatarGroup to avoid conflict)
export '../avatar.dart' show DAvatar, DAvatarSize;

/// DuxtUI Avatar Group component (enhanced version)
/// Displays a stack of overlapping avatars with optional overflow indicator
/// This is an enhanced version with more customization options
class DAvatarGroupEnhanced extends StatelessComponent {
  /// List of avatars to display
  final List<DAvatar> avatars;

  /// Maximum number of avatars to show before truncating
  final int max;

  /// Size of avatars in the group
  final DAvatarSize size;

  /// Spacing between avatars (negative for overlap)
  final String spacing;

  /// Ring color around avatars
  final String ringColor;

  /// Ring width
  final String ringWidth;

  /// Whether to reverse the stacking order (last avatar on top)
  final bool reverse;

  const DAvatarGroupEnhanced({
    super.key,
    required this.avatars,
    this.max = 4,
    this.size = DAvatarSize.md,
    this.spacing = '-space-x-2',
    this.ringColor = 'ring-white dark:ring-gray-900',
    this.ringWidth = 'ring-2',
    this.reverse = false,
  });

  String get _sizeClasses {
    switch (size) {
      case DAvatarSize.xs:
        return 'h-6 w-6 text-[10px]';
      case DAvatarSize.sm:
        return 'h-8 w-8 text-xs';
      case DAvatarSize.md:
        return 'h-10 w-10 text-sm';
      case DAvatarSize.lg:
        return 'h-12 w-12 text-base';
      case DAvatarSize.xl:
        return 'h-16 w-16 text-lg';
      default:
        return 'h-10 w-10 text-sm';
    }
  }

  @override
  Component build(BuildContext context) {
    final displayAvatars = avatars.take(max).toList();
    final remaining = avatars.length - max;

    final avatarWidgets = <Component>[];

    for (var i = 0; i < displayAvatars.length; i++) {
      final avatar = displayAvatars[reverse ? displayAvatars.length - 1 - i : i];
      avatarWidgets.add(
        div(
          classes: 'rounded-full $ringWidth $ringColor',
          [avatar],
        ),
      );
    }

    // Add overflow indicator if there are more avatars
    if (remaining > 0) {
      avatarWidgets.add(
        div(
          classes:
              '$_sizeClasses rounded-full ${DBgColors.muted} flex items-center justify-center font-medium ${DTextColors.muted} $ringWidth $ringColor',
          [Component.text('+$remaining')],
        ),
      );
    }

    return div(
      classes: 'inline-flex items-center $spacing',
      avatarWidgets,
    );
  }
}

/// Avatar Stack - Alternative layout with vertical stacking
class DAvatarStack extends StatelessComponent {
  /// List of avatars to display
  final List<DAvatar> avatars;

  /// Maximum number of avatars to show
  final int max;

  /// Size of avatars
  final DAvatarSize size;

  const DAvatarStack({
    super.key,
    required this.avatars,
    this.max = 4,
    this.size = DAvatarSize.md,
  });

  String get _sizeClasses {
    switch (size) {
      case DAvatarSize.xs:
        return 'h-6 w-6 text-[10px]';
      case DAvatarSize.sm:
        return 'h-8 w-8 text-xs';
      case DAvatarSize.md:
        return 'h-10 w-10 text-sm';
      case DAvatarSize.lg:
        return 'h-12 w-12 text-base';
      case DAvatarSize.xl:
        return 'h-16 w-16 text-lg';
      default:
        return 'h-10 w-10 text-sm';
    }
  }

  @override
  Component build(BuildContext context) {
    final displayAvatars = avatars.take(max).toList();
    final remaining = avatars.length - max;

    return div(
      classes: 'inline-flex flex-col -space-y-2',
      [
        for (final avatar in displayAvatars)
          div(
            classes: 'rounded-full ring-2 ring-white dark:ring-gray-900',
            [avatar],
          ),
        if (remaining > 0)
          div(
            classes:
                '$_sizeClasses rounded-full ${DBgColors.muted} flex items-center justify-center font-medium ${DTextColors.muted} ring-2 ring-white dark:ring-gray-900',
            [Component.text('+$remaining')],
          ),
      ],
    );
  }
}
