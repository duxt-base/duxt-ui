import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/variants.dart';
import '../../theme/colors.dart';
import '../avatar.dart';

/// User layout orientation
enum DUserOrientation { horizontal, vertical }

/// DuxtUI User component - Avatar with name and description
class DUser extends StatelessComponent {
  /// User's display name
  final String name;

  /// User's description (email, role, etc.)
  final String? description;

  /// Avatar image source
  final String? avatarSrc;

  /// Avatar initials (fallback when no image)
  final String? avatarInitials;

  /// Avatar background color
  final String? avatarColor;

  /// User component size
  final DSize size;

  /// Layout orientation
  final DUserOrientation orientation;

  /// Whether to reverse the layout (avatar on right)
  final bool reverse;

  /// Whether the user component is clickable
  final void Function()? onClick;

  /// Whether to show online/offline status
  final bool? online;

  /// Custom status text
  final String? status;

  /// Additional actions (e.g., buttons/icons)
  final List<Component>? actions;

  const DUser({
    super.key,
    required this.name,
    this.description,
    this.avatarSrc,
    this.avatarInitials,
    this.avatarColor,
    this.size = DSize.md,
    this.orientation = DUserOrientation.horizontal,
    this.reverse = false,
    this.onClick,
    this.online,
    this.status,
    this.actions,
  });

  DAvatarSize get _avatarSize {
    switch (size) {
      case DSize.xs:
        return DAvatarSize.xs;
      case DSize.sm:
        return DAvatarSize.sm;
      case DSize.md:
        return DAvatarSize.md;
      case DSize.lg:
        return DAvatarSize.lg;
      case DSize.xl:
        return DAvatarSize.xl;
    }
  }

  String get _nameTextSize {
    switch (size) {
      case DSize.xs:
        return 'text-xs';
      case DSize.sm:
        return 'text-sm';
      case DSize.md:
        return 'text-sm';
      case DSize.lg:
        return 'text-base';
      case DSize.xl:
        return 'text-lg';
    }
  }

  String get _descriptionTextSize {
    switch (size) {
      case DSize.xs:
        return 'text-[10px]';
      case DSize.sm:
        return 'text-xs';
      case DSize.md:
        return 'text-xs';
      case DSize.lg:
        return 'text-sm';
      case DSize.xl:
        return 'text-base';
    }
  }

  String get _gap {
    switch (size) {
      case DSize.xs:
        return 'gap-1.5';
      case DSize.sm:
        return 'gap-2';
      case DSize.md:
        return 'gap-3';
      case DSize.lg:
        return 'gap-3';
      case DSize.xl:
        return 'gap-4';
    }
  }

  String get _statusDotSize {
    switch (size) {
      case DSize.xs:
        return 'size-1.5';
      case DSize.sm:
        return 'size-2';
      case DSize.md:
        return 'size-2.5';
      case DSize.lg:
        return 'size-3';
      case DSize.xl:
        return 'size-3.5';
    }
  }

  String get _initials {
    if (avatarInitials != null) return avatarInitials!;

    // Generate initials from name
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Component build(BuildContext context) {
    final avatar = _buildAvatar();
    final info = _buildInfo();

    final isVertical = orientation == DUserOrientation.vertical;

    final content = div(
      classes: cx([
        'inline-flex items-center',
        _gap,
        if (isVertical) 'flex-col text-center',
        if (reverse && !isVertical) 'flex-row-reverse',
        if (onClick != null) 'cursor-pointer',
      ]),
      [
        avatar,
        info,
        if (actions != null && actions!.isNotEmpty)
          div(
            classes: 'flex items-center gap-1 ml-auto',
            actions!,
          ),
      ],
    );

    if (onClick != null) {
      return button(
        type: ButtonType.button,
        classes: 'hover:opacity-80 transition-opacity',
        events: events(onClick: () => onClick!()),
        [content],
      );
    }

    return content;
  }

  Component _buildAvatar() {
    return div(
      classes: 'relative shrink-0',
      [
        DAvatar(
          src: avatarSrc,
          text: _initials,
          size: _avatarSize,
        ),
        // Online status indicator
        if (online != null)
          div(
            classes: cx([
              'absolute bottom-0 right-0 rounded-full ring-2 ring-white dark:ring-gray-900',
              _statusDotSize,
              online! ? 'bg-cyan-500' : 'bg-gray-400',
            ]),
            [],
          ),
      ],
    );
  }

  Component _buildInfo() {
    final isVertical = orientation == DUserOrientation.vertical;

    return div(
      classes: cx([
        'min-w-0',
        if (!isVertical) 'flex flex-col',
      ]),
      [
        // Name
        span(
          classes: cx([
            _nameTextSize,
            'font-medium truncate',
            DTextColors.defaultText,
          ]),
          [Component.text(name)],
        ),
        // Description or status
        if (description != null || status != null)
          span(
            classes: cx([
              _descriptionTextSize,
              'truncate',
              DTextColors.muted,
            ]),
            [Component.text(status ?? description ?? '')],
          ),
      ],
    );
  }
}

/// User card with additional content
class DUserCard extends StatelessComponent {
  /// User's display name
  final String name;

  /// User's description
  final String? description;

  /// Avatar image source
  final String? avatarSrc;

  /// Avatar initials
  final String? avatarInitials;

  /// Additional content below user info
  final Component? content;

  /// Card actions (buttons, links)
  final List<Component>? actions;

  /// Whether the card is clickable
  final void Function()? onClick;

  const DUserCard({
    super.key,
    required this.name,
    this.description,
    this.avatarSrc,
    this.avatarInitials,
    this.content,
    this.actions,
    this.onClick,
  });

  @override
  Component build(BuildContext context) {
    final cardContent = div(
      classes:
          'p-4 rounded-lg border border-gray-200 dark:border-gray-700 ${DBgColors.defaultBg}',
      [
        DUser(
          name: name,
          description: description,
          avatarSrc: avatarSrc,
          avatarInitials: avatarInitials,
          size: DSize.lg,
        ),
        if (content != null) div(classes: 'mt-3', [content!]),
        if (actions != null && actions!.isNotEmpty)
          div(
            classes:
                'mt-4 pt-3 border-t border-gray-200 dark:border-gray-700 flex items-center gap-2',
            actions!,
          ),
      ],
    );

    if (onClick != null) {
      return button(
        type: ButtonType.button,
        classes: 'text-left w-full hover:shadow-md transition-shadow',
        events: events(onClick: () => onClick!()),
        [cardContent],
      );
    }

    return cardContent;
  }
}

/// User list item (optimized for lists)
class DUserListItem extends StatelessComponent {
  /// User's display name
  final String name;

  /// User's description
  final String? description;

  /// Avatar image source
  final String? avatarSrc;

  /// Avatar initials
  final String? avatarInitials;

  /// Trailing content (e.g., badge, action)
  final Component? trailing;

  /// Whether the item is selected
  final bool selected;

  /// Click handler
  final void Function()? onClick;

  const DUserListItem({
    super.key,
    required this.name,
    this.description,
    this.avatarSrc,
    this.avatarInitials,
    this.trailing,
    this.selected = false,
    this.onClick,
  });

  @override
  Component build(BuildContext context) {
    final content = div(
      classes: cx([
        'flex items-center justify-between gap-3 px-3 py-2 rounded-lg transition-colors',
        if (selected) 'bg-gray-100 dark:bg-zinc-800',
        if (onClick != null && !selected)
          'hover:bg-gray-50 dark:hover:bg-gray-800/50 cursor-pointer',
      ]),
      [
        DUser(
          name: name,
          description: description,
          avatarSrc: avatarSrc,
          avatarInitials: avatarInitials,
          size: DSize.sm,
        ),
        if (trailing != null) trailing!,
      ],
    );

    if (onClick != null) {
      return button(
        type: ButtonType.button,
        classes: 'w-full text-left',
        events: events(onClick: () => onClick!()),
        [content],
      );
    }

    return content;
  }
}
