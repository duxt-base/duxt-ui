import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// Timeline item status
enum DTimelineStatus { pending, current, completed }

/// Timeline orientation
enum DTimelineOrientation { vertical, horizontal }

/// Timeline item data
class DTimelineItem {
  /// Unique identifier
  final String? id;

  /// Title text
  final String title;

  /// Description text (optional)
  final String? description;

  /// Icon class (optional)
  final String? icon;

  /// Timestamp or date (optional)
  final String? time;

  /// Item status
  final DTimelineStatus status;

  /// Custom color (overrides status color)
  final DColor? color;

  /// Custom content widget (optional)
  final Component? content;

  const DTimelineItem({
    this.id,
    required this.title,
    this.description,
    this.icon,
    this.time,
    this.status = DTimelineStatus.pending,
    this.color,
    this.content,
  });
}

/// DuxtUI Timeline component
class DTimeline extends StatelessComponent {
  /// List of timeline items
  final List<DTimelineItem> items;

  /// Timeline orientation
  final DTimelineOrientation orientation;

  /// Default color for items
  final DColor color;

  /// Size of the timeline dots/icons
  final DSize size;

  /// Whether to show connecting lines
  final bool showConnectors;

  /// Whether items are clickable
  final void Function(DTimelineItem item, int index)? onItemClick;

  const DTimeline({
    super.key,
    required this.items,
    this.orientation = DTimelineOrientation.vertical,
    this.color = DColor.primary,
    this.size = DSize.md,
    this.showConnectors = true,
    this.onItemClick,
  });

  String get _dotSize {
    switch (size) {
      case DSize.xs:
        return 'size-2';
      case DSize.sm:
        return 'size-2.5';
      case DSize.md:
        return 'size-3';
      case DSize.lg:
        return 'size-4';
      case DSize.xl:
        return 'size-5';
    }
  }

  String get _iconContainerSize {
    switch (size) {
      case DSize.xs:
        return 'size-5';
      case DSize.sm:
        return 'size-6';
      case DSize.md:
        return 'size-8';
      case DSize.lg:
        return 'size-10';
      case DSize.xl:
        return 'size-12';
    }
  }

  String get _iconSize {
    switch (size) {
      case DSize.xs:
        return 'size-2.5';
      case DSize.sm:
        return 'size-3';
      case DSize.md:
        return 'size-4';
      case DSize.lg:
        return 'size-5';
      case DSize.xl:
        return 'size-6';
    }
  }

  String _getDotColor(DTimelineItem item) {
    final itemColor = item.color ?? color;
    final baseColor = defaultColorMapping[itemColor] ?? 'green';

    switch (item.status) {
      case DTimelineStatus.completed:
        return 'bg-$baseColor-500';
      case DTimelineStatus.current:
        return 'bg-$baseColor-500 ring-4 ring-$baseColor-100 dark:ring-$baseColor-900';
      case DTimelineStatus.pending:
        return 'bg-gray-300 dark:bg-gray-600';
    }
  }

  String _getIconContainerColor(DTimelineItem item) {
    final itemColor = item.color ?? color;
    final baseColor = defaultColorMapping[itemColor] ?? 'green';

    switch (item.status) {
      case DTimelineStatus.completed:
        return 'bg-$baseColor-500 text-white';
      case DTimelineStatus.current:
        return 'bg-$baseColor-100 text-$baseColor-600 dark:bg-$baseColor-900 dark:text-$baseColor-400 ring-4 ring-$baseColor-50 dark:ring-$baseColor-950';
      case DTimelineStatus.pending:
        return 'bg-gray-100 text-gray-500 dark:bg-gray-800 dark:text-gray-400';
    }
  }

  String get _connectorColor => 'bg-gray-200 dark:bg-gray-700';

  @override
  Component build(BuildContext context) {
    if (orientation == DTimelineOrientation.horizontal) {
      return _buildHorizontal(context);
    }
    return _buildVertical(context);
  }

  Component _buildVertical(BuildContext context) {
    return div(
      classes: 'relative',
      [
        for (var i = 0; i < items.length; i++) _buildVerticalItem(items[i], i),
      ],
    );
  }

  Component _buildVerticalItem(DTimelineItem item, int index) {
    final isLast = index == items.length - 1;
    final hasIcon = item.icon != null;

    final itemContent = div(
      classes: cx([
        'relative flex gap-4 pb-8',
        if (isLast) 'pb-0',
      ]),
      [
        // Left side: dot/icon and connector
        div(
          classes: 'flex flex-col items-center',
          [
            // Dot or icon
            if (hasIcon)
              div(
                classes: cx([
                  'rounded-full flex items-center justify-center shrink-0',
                  _iconContainerSize,
                  _getIconContainerColor(item),
                ]),
                [i(classes: '${item.icon} $_iconSize', [])],
              )
            else
              div(
                classes: cx([
                  'rounded-full shrink-0 mt-1',
                  _dotSize,
                  _getDotColor(item),
                ]),
                [],
              ),
            // Connector line
            if (showConnectors && !isLast)
              div(
                classes: cx([
                  'w-0.5 flex-1 min-h-4 mt-2',
                  _connectorColor,
                ]),
                [],
              ),
          ],
        ),
        // Right side: content
        div(
          classes: 'flex-1 min-w-0 pt-0.5',
          [
            // Header with title and time
            div(
              classes: 'flex items-start justify-between gap-2',
              [
                span(
                  classes: cx([
                    'font-medium',
                    item.status == DTimelineStatus.pending
                        ? DTextColors.muted
                        : DTextColors.defaultText,
                  ]),
                  [Component.text(item.title)],
                ),
                if (item.time != null)
                  span(
                    classes: 'text-sm ${DTextColors.muted} shrink-0',
                    [Component.text(item.time!)],
                  ),
              ],
            ),
            // Description
            if (item.description != null)
              p(
                classes: 'mt-1 text-sm ${DTextColors.muted}',
                [Component.text(item.description!)],
              ),
            // Custom content
            if (item.content != null) div(classes: 'mt-2', [item.content!]),
          ],
        ),
      ],
    );

    if (onItemClick != null) {
      return button(
        type: ButtonType.button,
        classes:
            'w-full text-left hover:bg-gray-50 dark:hover:bg-gray-800/50 -mx-2 px-2 rounded-lg transition-colors',
        events: events(onClick: () => onItemClick!(item, index)),
        [itemContent],
      );
    }

    return itemContent;
  }

  Component _buildHorizontal(BuildContext context) {
    return div(
      classes: 'relative',
      [
        // Items
        div(
          classes: 'flex',
          [
            for (var i = 0; i < items.length; i++)
              _buildHorizontalItem(items[i], i),
          ],
        ),
      ],
    );
  }

  Component _buildHorizontalItem(DTimelineItem item, int index) {
    final isLast = index == items.length - 1;
    final hasIcon = item.icon != null;

    return div(
      classes: cx([
        'flex flex-col items-center flex-1',
        if (!isLast) 'relative',
      ]),
      [
        // Dot or icon
        if (hasIcon)
          div(
            classes: cx([
              'rounded-full flex items-center justify-center shrink-0 relative z-10',
              _iconContainerSize,
              _getIconContainerColor(item),
            ]),
            [i(classes: '${item.icon} $_iconSize', [])],
          )
        else
          div(
            classes: cx([
              'rounded-full shrink-0 relative z-10',
              _dotSize,
              _getDotColor(item),
            ]),
            [],
          ),
        // Connector line (positioned between dots)
        if (showConnectors && !isLast)
          div(
            classes: cx([
              'absolute top-3 left-1/2 w-full h-0.5',
              _connectorColor,
            ]),
            [],
          ),
        // Content below
        div(
          classes: 'mt-3 text-center',
          [
            span(
              classes: cx([
                'font-medium text-sm',
                item.status == DTimelineStatus.pending
                    ? DTextColors.muted
                    : DTextColors.defaultText,
              ]),
              [Component.text(item.title)],
            ),
            if (item.time != null)
              p(
                classes: 'mt-0.5 text-xs ${DTextColors.muted}',
                [Component.text(item.time!)],
              ),
          ],
        ),
      ],
    );
  }
}

/// Simple timeline with just text items
class DTimelineSimple extends StatelessComponent {
  /// List of text items
  final List<String> items;

  /// Index of the current/active item
  final int? activeIndex;

  /// Timeline color
  final DColor color;

  const DTimelineSimple({
    super.key,
    required this.items,
    this.activeIndex,
    this.color = DColor.primary,
  });

  @override
  Component build(BuildContext context) {
    final baseColor = defaultColorMapping[color] ?? 'green';

    return ul(
      classes: 'relative',
      [
        for (var i = 0; i < items.length; i++)
          li(
            classes: cx([
              'relative flex gap-3 pb-6',
              if (i == items.length - 1) 'pb-0',
            ]),
            [
              // Dot
              div(
                classes: cx([
                  'size-2.5 rounded-full mt-1.5 shrink-0',
                  if (activeIndex != null && i <= activeIndex!)
                    'bg-$baseColor-500'
                  else
                    'bg-gray-300 dark:bg-gray-600',
                ]),
                [],
              ),
              // Line
              if (i < items.length - 1)
                div(
                  classes: cx([
                    'absolute left-1 top-4 w-0.5 h-full -translate-x-1/2',
                    if (activeIndex != null && i < activeIndex!)
                      'bg-$baseColor-500'
                    else
                      'bg-gray-200 dark:bg-gray-700',
                  ]),
                  [],
                ),
              // Text
              span(
                classes: cx([
                  'text-sm',
                  if (activeIndex != null && i == activeIndex!)
                    'font-medium ${DTextColors.defaultText}'
                  else if (activeIndex != null && i < activeIndex!)
                    DTextColors.defaultText
                  else
                    DTextColors.muted,
                ]),
                [Component.text(items[i])],
              ),
            ],
          ),
      ],
    );
  }
}
