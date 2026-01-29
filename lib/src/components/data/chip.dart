import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// Chip variants
enum UChipVariant { solid, soft, outline, subtle }

/// DuxtUI Chip component - Small indicator badge
/// Similar to Badge but designed for inline indicators with optional actions
class UChip extends StatelessComponent {
  /// The label text to display
  final String label;

  /// Chip variant
  final UChipVariant variant;

  /// Chip color
  final UColor color;

  /// Chip size
  final USize size;

  /// Leading icon (optional)
  final String? leadingIcon;

  /// Trailing icon (optional, typically for close/remove action)
  final String? trailingIcon;

  /// Callback when chip is clicked
  final void Function()? onClick;

  /// Callback when trailing icon is clicked (e.g., for remove action)
  final void Function()? onTrailingClick;

  /// Whether the chip is disabled
  final bool disabled;

  /// Whether to show a dot indicator
  final bool showDot;

  const UChip({
    super.key,
    required this.label,
    this.variant = UChipVariant.soft,
    this.color = UColor.primary,
    this.size = USize.sm,
    this.leadingIcon,
    this.trailingIcon,
    this.onClick,
    this.onTrailingClick,
    this.disabled = false,
    this.showDot = false,
  });

  String get _sizeClasses {
    // Using badge size classes as reference
    return badgeSizeClasses[size] ?? badgeSizeClasses[USize.sm]!;
  }

  String get _colorClasses {
    final baseColor = defaultColorMapping[color] ?? 'green';

    switch (variant) {
      case UChipVariant.solid:
        return 'bg-$baseColor-500 text-white';
      case UChipVariant.soft:
        return 'bg-$baseColor-50 text-$baseColor-700 dark:bg-$baseColor-950 dark:text-$baseColor-300';
      case UChipVariant.outline:
        return 'bg-transparent text-$baseColor-500 ring-1 ring-inset ring-$baseColor-500 dark:text-$baseColor-400 dark:ring-$baseColor-400';
      case UChipVariant.subtle:
        return 'bg-$baseColor-50 text-$baseColor-500 dark:bg-$baseColor-950 dark:text-$baseColor-400';
    }
  }

  String get _dotColor {
    final baseColor = defaultColorMapping[color] ?? 'green';
    switch (variant) {
      case UChipVariant.solid:
        return 'bg-white';
      case UChipVariant.soft:
      case UChipVariant.outline:
      case UChipVariant.subtle:
        return 'bg-$baseColor-500 dark:bg-$baseColor-400';
    }
  }

  String get _iconSize {
    switch (size) {
      case USize.xs:
        return 'size-2.5';
      case USize.sm:
        return 'size-3';
      case USize.md:
        return 'size-3.5';
      case USize.lg:
        return 'size-4';
      case USize.xl:
        return 'size-5';
    }
  }

  String get _dotSize {
    switch (size) {
      case USize.xs:
        return 'size-1';
      case USize.sm:
        return 'size-1.5';
      case USize.md:
        return 'size-1.5';
      case USize.lg:
        return 'size-2';
      case USize.xl:
        return 'size-2';
    }
  }

  @override
  Component build(BuildContext context) {
    final baseClasses = cx([
      'inline-flex items-center font-medium',
      _sizeClasses,
      _colorClasses,
      if (onClick != null && !disabled)
        'cursor-pointer hover:opacity-80 transition-opacity',
      if (disabled) 'opacity-50 cursor-not-allowed',
    ]);

    final children = <Component>[
      // Dot indicator
      if (showDot) span(classes: '$_dotSize rounded-full $_dotColor', []),

      // Leading icon
      if (leadingIcon != null)
        i(classes: '$leadingIcon $_iconSize shrink-0', []),

      // Label text
      span([Component.text(label)]),

      // Trailing icon (with optional click handler)
      if (trailingIcon != null)
        button(
          type: ButtonType.button,
          classes: cx([
            '$trailingIcon $_iconSize shrink-0',
            if (onTrailingClick != null && !disabled)
              'cursor-pointer hover:opacity-70 transition-opacity',
          ]),
          events: onTrailingClick != null && !disabled
              ? {'click': (event) {
                  event.stopPropagation();
                  onTrailingClick!();
                }}
              : null,
          [],
        ),
    ];

    if (onClick != null && !disabled) {
      return button(
        type: ButtonType.button,
        classes: baseClasses,
        events: events(onClick: () => onClick!()),
        children,
      );
    }

    return span(classes: baseClasses, children);
  }
}

/// Chip Group - Display multiple chips in a row
class UChipGroup extends StatelessComponent {
  /// List of chips to display
  final List<UChip> chips;

  /// Gap between chips
  final String gap;

  /// Whether chips should wrap
  final bool wrap;

  const UChipGroup({
    super.key,
    required this.chips,
    this.gap = 'gap-1.5',
    this.wrap = true,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: cx([
        'inline-flex items-center',
        gap,
        if (wrap) 'flex-wrap',
      ]),
      chips,
    );
  }
}
