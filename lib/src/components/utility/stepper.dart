import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'icon.dart';

/// Stepper orientation
enum UStepperOrientation { horizontal, vertical }

/// Step status
enum UStepStatus { upcoming, current, completed }

/// Step item data
class UStepItem {
  final String title;
  final String? description;
  final Component? icon;

  const UStepItem({
    required this.title,
    this.description,
    this.icon,
  });
}

/// DuxtUI Stepper component - Multi-step progress indicator
///
/// Displays progress through a multi-step process with numbered
/// circles and connecting lines.
class UStepper extends StatelessComponent {
  /// List of steps
  final List<UStepItem> steps;

  /// Current active step index (0-based)
  final int currentStep;

  /// Orientation of the stepper
  final UStepperOrientation orientation;

  /// Whether clicking on steps is allowed
  final bool clickable;

  /// Callback when a step is clicked
  final ValueChanged<int>? onStepClick;

  /// Custom CSS classes
  final String? classes;

  const UStepper({
    super.key,
    required this.steps,
    this.currentStep = 0,
    this.orientation = UStepperOrientation.horizontal,
    this.clickable = false,
    this.onStepClick,
    this.classes,
  });

  UStepStatus _getStepStatus(int index) {
    if (index < currentStep) return UStepStatus.completed;
    if (index == currentStep) return UStepStatus.current;
    return UStepStatus.upcoming;
  }

  String _getStepCircleClasses(UStepStatus status) {
    switch (status) {
      case UStepStatus.completed:
        return 'bg-green-600 text-white border-green-600';
      case UStepStatus.current:
        return 'bg-indigo-600 text-white border-indigo-600';
      case UStepStatus.upcoming:
        return 'bg-white dark:bg-gray-900 text-gray-400 border-gray-300 dark:border-gray-600';
    }
  }

  String _getLineClasses(UStepStatus status) {
    switch (status) {
      case UStepStatus.completed:
        return 'bg-green-600';
      case UStepStatus.current:
      case UStepStatus.upcoming:
        return 'bg-gray-300 dark:bg-gray-600';
    }
  }

  @override
  Component build(BuildContext context) {
    if (steps.isEmpty) {
      return div([]);
    }

    final isHorizontal = orientation == UStepperOrientation.horizontal;

    return div(
      classes: [
        if (isHorizontal) 'flex items-center' else 'flex flex-col',
        classes ?? '',
      ].join(' '),
      [
        for (var i = 0; i < steps.length; i++) ...[
          _buildStep(i, steps[i], isHorizontal),
          if (i < steps.length - 1) _buildConnector(i, isHorizontal),
        ],
      ],
    );
  }

  Component _buildStep(int index, UStepItem step, bool isHorizontal) {
    final status = _getStepStatus(index);
    final circleClasses = _getStepCircleClasses(status);

    final stepWidget = div(
      classes: [
        'flex',
        if (isHorizontal) 'flex-col items-center' else 'items-start gap-4',
      ].join(' '),
      [
        // Step circle
        button(
          type: ButtonType.button,
          onClick: clickable ? () => onStepClick?.call(index) : null,
          classes: [
            'flex items-center justify-center w-10 h-10 rounded-full border-2 font-medium text-sm transition-colors',
            circleClasses,
            if (clickable)
              'cursor-pointer hover:opacity-80'
            else
              'cursor-default',
          ].join(' '),
          [
            if (status == UStepStatus.completed)
              UIcon(name: UIconNames.check, size: UIconSize.sm)
            else if (step.icon != null)
              step.icon!
            else
              Component.text('${index + 1}'),
          ],
        ),

        // Step content
        div(
          classes: [
            if (isHorizontal) 'mt-2 text-center' else 'flex-1',
          ].join(' '),
          [
            // Title
            span(
              classes: [
                'block font-medium text-sm',
                status == UStepStatus.upcoming
                    ? 'text-gray-400 dark:text-gray-500'
                    : 'text-gray-900 dark:text-white',
              ].join(' '),
              [Component.text(step.title)],
            ),

            // Description
            if (step.description != null)
              span(
                classes:
                    'block text-xs text-gray-500 dark:text-gray-400 mt-0.5',
                [Component.text(step.description!)],
              ),
          ],
        ),
      ],
    );

    return stepWidget;
  }

  Component _buildConnector(int index, bool isHorizontal) {
    final status = _getStepStatus(index);
    final lineClasses = _getLineClasses(status);

    if (isHorizontal) {
      return div(
        classes: 'flex-1 h-0.5 mx-4 $lineClasses transition-colors',
        [],
      );
    } else {
      return div(
        classes: 'w-0.5 h-8 ml-5 my-2 $lineClasses transition-colors',
        [],
      );
    }
  }
}
