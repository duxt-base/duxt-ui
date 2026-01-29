import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/colors.dart';
import '../avatar.dart';

// Re-export UAvatar for convenience (hide UAvatarGroup to avoid conflict)
export '../avatar.dart' show UAvatar, UAvatarSize;

/// DuxtUI Avatar Group component (enhanced version)
/// Displays a stack of overlapping avatars with optional overflow indicator
/// This is an enhanced version with more customization options
class UAvatarGroupEnhanced extends StatelessComponent {
  /// List of avatars to display
  final List<UAvatar> avatars;

  /// Maximum number of avatars to show before truncating
  final int max;

  /// Size of avatars in the group
  final UAvatarSize size;

  /// Spacing between avatars (negative for overlap)
  final String spacing;

  /// Ring color around avatars
  final String ringColor;

  /// Ring width
  final String ringWidth;

  /// Whether to reverse the stacking order (last avatar on top)
  final bool reverse;

  const UAvatarGroupEnhanced({
    super.key,
    required this.avatars,
    this.max = 4,
    this.size = UAvatarSize.md,
    this.spacing = '-space-x-2',
    this.ringColor = 'ring-white dark:ring-gray-900',
    this.ringWidth = 'ring-2',
    this.reverse = false,
  });

  String get _sizeClasses {
    switch (size) {
      case UAvatarSize.xs:
        return 'h-6 w-6 text-[10px]';
      case UAvatarSize.sm:
        return 'h-8 w-8 text-xs';
      case UAvatarSize.md:
        return 'h-10 w-10 text-sm';
      case UAvatarSize.lg:
        return 'h-12 w-12 text-base';
      case UAvatarSize.xl:
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
              '$_sizeClasses rounded-full ${UBgColors.muted} flex items-center justify-center font-medium ${UTextColors.muted} $ringWidth $ringColor',
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
class UAvatarStack extends StatelessComponent {
  /// List of avatars to display
  final List<UAvatar> avatars;

  /// Maximum number of avatars to show
  final int max;

  /// Size of avatars
  final UAvatarSize size;

  const UAvatarStack({
    super.key,
    required this.avatars,
    this.max = 4,
    this.size = UAvatarSize.md,
  });

  String get _sizeClasses {
    switch (size) {
      case UAvatarSize.xs:
        return 'h-6 w-6 text-[10px]';
      case UAvatarSize.sm:
        return 'h-8 w-8 text-xs';
      case UAvatarSize.md:
        return 'h-10 w-10 text-sm';
      case UAvatarSize.lg:
        return 'h-12 w-12 text-base';
      case UAvatarSize.xl:
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
                '$_sizeClasses rounded-full ${UBgColors.muted} flex items-center justify-center font-medium ${UTextColors.muted} ring-2 ring-white dark:ring-gray-900',
            [Component.text('+$remaining')],
          ),
      ],
    );
  }
}
