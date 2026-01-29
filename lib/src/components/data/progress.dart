import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// Progress animation types
enum UProgressAnimation { none, pulse, indeterminate }

/// DuxtUI Progress Bar component
class UProgress extends StatelessComponent {
  /// Current progress value (0-100)
  final double value;

  /// Maximum value (default 100)
  final double max;

  /// Progress color
  final UColor color;

  /// Progress size
  final USize size;

  /// Whether to show percentage label
  final bool showLabel;

  /// Custom label (overrides percentage)
  final String? label;

  /// Animation type
  final UProgressAnimation animation;

  /// Whether the progress is indeterminate (unknown progress)
  final bool indeterminate;

  /// Custom track (background) color class
  final String? trackColor;

  /// Custom indicator (fill) color class
  final String? indicatorColor;

  const UProgress({
    super.key,
    this.value = 0,
    this.max = 100,
    this.color = UColor.primary,
    this.size = USize.md,
    this.showLabel = false,
    this.label,
    this.animation = UProgressAnimation.none,
    this.indeterminate = false,
    this.trackColor,
    this.indicatorColor,
  });

  double get _percentage => (value / max * 100).clamp(0, 100);

  String get _heightClass {
    switch (size) {
      case USize.xs:
        return 'h-1';
      case USize.sm:
        return 'h-1.5';
      case USize.md:
        return 'h-2';
      case USize.lg:
        return 'h-3';
      case USize.xl:
        return 'h-4';
    }
  }

  String get _trackColorClass {
    return trackColor ?? 'bg-gray-200 dark:bg-gray-700';
  }

  String get _indicatorColorClass {
    if (indicatorColor != null) return indicatorColor!;

    final baseColor = defaultColorMapping[color] ?? 'green';
    return 'bg-$baseColor-500';
  }

  String get _animationClass {
    if (indeterminate) {
      return 'animate-indeterminate';
    }
    switch (animation) {
      case UProgressAnimation.none:
        return '';
      case UProgressAnimation.pulse:
        return 'animate-pulse';
      case UProgressAnimation.indeterminate:
        return 'animate-indeterminate';
    }
  }

  @override
  Component build(BuildContext context) {
    final progressBar = div(
      classes: cx([
        'overflow-hidden rounded-full w-full',
        _heightClass,
        _trackColorClass,
      ]),
      attributes: {
        'role': 'progressbar',
        'aria-valuenow': indeterminate ? '' : '${value.toInt()}',
        'aria-valuemin': '0',
        'aria-valuemax': '${max.toInt()}',
      },
      [
        div(
          classes: cx([
            _heightClass,
            _indicatorColorClass,
            'rounded-full transition-all duration-300',
            _animationClass,
          ]),
          styles: indeterminate
              ? Styles(raw: {'width': '30%'})
              : Styles(raw: {'width': '${_percentage}%'}),
          [],
        ),
      ],
    );

    if (showLabel || label != null) {
      return div(
        classes: 'w-full',
        [
          if (showLabel || label != null)
            div(
              classes: 'flex justify-between mb-1',
              [
                if (label != null)
                  span(
                    classes: 'text-sm font-medium ${UTextColors.defaultText}',
                    [Component.text(label!)],
                  ),
                span(
                  classes: 'text-sm font-medium ${UTextColors.muted}',
                  [Component.text('${_percentage.toInt()}%')],
                ),
              ],
            ),
          progressBar,
        ],
      );
    }

    return progressBar;
  }
}

/// Circular Progress component
class UProgressCircular extends StatelessComponent {
  /// Current progress value (0-100)
  final double value;

  /// Maximum value
  final double max;

  /// Progress color
  final UColor color;

  /// Size of the circle
  final USize size;

  /// Stroke width
  final double strokeWidth;

  /// Whether to show percentage in center
  final bool showLabel;

  /// Custom label
  final String? label;

  /// Whether the progress is indeterminate
  final bool indeterminate;

  const UProgressCircular({
    super.key,
    this.value = 0,
    this.max = 100,
    this.color = UColor.primary,
    this.size = USize.md,
    this.strokeWidth = 4,
    this.showLabel = true,
    this.label,
    this.indeterminate = false,
  });

  double get _percentage => (value / max * 100).clamp(0, 100);

  int get _sizePixels {
    switch (size) {
      case USize.xs:
        return 24;
      case USize.sm:
        return 32;
      case USize.md:
        return 48;
      case USize.lg:
        return 64;
      case USize.xl:
        return 80;
    }
  }

  String get _sizeClass {
    switch (size) {
      case USize.xs:
        return 'size-6';
      case USize.sm:
        return 'size-8';
      case USize.md:
        return 'size-12';
      case USize.lg:
        return 'size-16';
      case USize.xl:
        return 'size-20';
    }
  }

  String get _textSizeClass {
    switch (size) {
      case USize.xs:
        return 'text-[8px]';
      case USize.sm:
        return 'text-[10px]';
      case USize.md:
        return 'text-xs';
      case USize.lg:
        return 'text-sm';
      case USize.xl:
        return 'text-base';
    }
  }

  String get _strokeColor {
    final baseColor = defaultColorMapping[color] ?? 'green';
    return 'stroke-$baseColor-500';
  }

  @override
  Component build(BuildContext context) {
    final sizeVal = _sizePixels;
    final radius = (sizeVal - strokeWidth) / 2;
    final circumference = 2 * 3.14159 * radius;
    final dashOffset = circumference - (_percentage / 100 * circumference);

    return div(
      classes: 'relative inline-flex items-center justify-center $_sizeClass',
      [
        // SVG using Jaspr's native SVG components
        svg(
          [
            // Background circle
            circle(
              [],
              cx: '${sizeVal / 2}',
              cy: '${sizeVal / 2}',
              r: '$radius',
              classes: 'stroke-gray-200 dark:stroke-gray-700',
              attributes: {
                'fill': 'none',
                'stroke-width': '$strokeWidth',
              },
            ),
            // Progress circle
            circle(
              [],
              cx: '${sizeVal / 2}',
              cy: '${sizeVal / 2}',
              r: '$radius',
              classes: '$_strokeColor transition-all duration-300',
              attributes: {
                'fill': 'none',
                'stroke-width': '$strokeWidth',
                'stroke-linecap': 'round',
                'stroke-dasharray': '$circumference',
                'stroke-dashoffset':
                    indeterminate ? '${circumference * 0.75}' : '$dashOffset',
                'transform': 'rotate(-90 ${sizeVal / 2} ${sizeVal / 2})',
              },
            ),
          ],
          viewBox: '0 0 $sizeVal $sizeVal',
          classes: cx([
            '$_sizeClass',
            if (indeterminate) 'animate-spin',
          ]),
        ),
        // Center label
        if ((showLabel || label != null) && !indeterminate)
          span(
            classes:
                'absolute $_textSizeClass font-medium ${UTextColors.defaultText}',
            [Component.text(label ?? '${_percentage.toInt()}%')],
          ),
      ],
    );
  }
}

/// Progress with steps/segments
class UProgressSteps extends StatelessComponent {
  /// Current step (0-indexed)
  final int currentStep;

  /// Total number of steps
  final int totalSteps;

  /// Step labels (optional)
  final List<String>? labels;

  /// Progress color
  final UColor color;

  /// Size
  final USize size;

  const UProgressSteps({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.labels,
    this.color = UColor.primary,
    this.size = USize.md,
  });

  String get _heightClass {
    switch (size) {
      case USize.xs:
        return 'h-1';
      case USize.sm:
        return 'h-1.5';
      case USize.md:
        return 'h-2';
      case USize.lg:
        return 'h-3';
      case USize.xl:
        return 'h-4';
    }
  }

  String get _activeColor {
    final baseColor = defaultColorMapping[color] ?? 'green';
    return 'bg-$baseColor-500';
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'w-full',
      [
        // Progress segments
        div(
          classes: 'flex gap-1',
          [
            for (var i = 0; i < totalSteps; i++)
              div(
                classes: cx([
                  'flex-1 rounded-full $_heightClass transition-colors',
                  i <= currentStep
                      ? _activeColor
                      : 'bg-gray-200 dark:bg-gray-700',
                ]),
                [],
              ),
          ],
        ),
        // Labels
        if (labels != null && labels!.isNotEmpty)
          div(
            classes: 'flex justify-between mt-2',
            [
              for (var i = 0; i < totalSteps && i < labels!.length; i++)
                span(
                  classes: cx([
                    'text-xs',
                    i <= currentStep
                        ? UTextColors.defaultText
                        : UTextColors.muted,
                  ]),
                  [Component.text(labels![i])],
                ),
            ],
          ),
      ],
    );
  }
}
