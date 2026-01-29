import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Separator orientation
enum USeparatorOrientation { horizontal, vertical }

/// Separator type
enum USeparatorType { solid, dashed, dotted }

/// DuxtUI Separator component - hr/divider
class USeparator extends StatelessComponent {
  final USeparatorOrientation orientation;
  final USeparatorType type;
  final String? label;
  final String? classes;

  const USeparator({
    super.key,
    this.orientation = USeparatorOrientation.horizontal,
    this.type = USeparatorType.solid,
    this.label,
    this.classes,
  });

  String get _orientationClasses {
    switch (orientation) {
      case USeparatorOrientation.horizontal:
        return 'w-full border-t';
      case USeparatorOrientation.vertical:
        return 'h-full border-l self-stretch';
    }
  }

  String get _typeClasses {
    switch (type) {
      case USeparatorType.solid:
        return 'border-solid';
      case USeparatorType.dashed:
        return 'border-dashed';
      case USeparatorType.dotted:
        return 'border-dotted';
    }
  }

  @override
  Component build(BuildContext context) {
    final baseClasses = 'border-gray-200 dark:border-gray-800';

    if (label != null && orientation == USeparatorOrientation.horizontal) {
      // Separator with label
      return div(
        classes: 'relative flex items-center w-full ${classes ?? ""}'.trim(),
        [
          div(classes: 'flex-grow border-t $baseClasses $_typeClasses', []),
          span(
            classes:
                'mx-4 text-sm text-gray-500 dark:text-gray-400 bg-white dark:bg-gray-900 px-2',
            [Component.text(label!)],
          ),
          div(classes: 'flex-grow border-t $baseClasses $_typeClasses', []),
        ],
      );
    }

    // Simple separator (hr-like)
    return div(
      classes:
          '$_orientationClasses $baseClasses $_typeClasses ${classes ?? ""}'
              .trim(),
      [],
    );
  }
}

/// Convenience component for horizontal rule
class UHr extends StatelessComponent {
  final USeparatorType type;
  final String? label;
  final String? classes;

  const UHr({
    super.key,
    this.type = USeparatorType.solid,
    this.label,
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    return USeparator(
      orientation: USeparatorOrientation.horizontal,
      type: type,
      label: label,
      classes: classes,
    );
  }
}

/// Convenience component for vertical divider
class UDivider extends StatelessComponent {
  final String? classes;

  const UDivider({
    super.key,
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    return USeparator(
      orientation: USeparatorOrientation.vertical,
      classes: classes,
    );
  }
}
