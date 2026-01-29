import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Grid column configurations
enum UPageGridColumns { one, two, three, four, five, six }

/// DuxtUI PageGrid component - Responsive grid layout
///
/// A responsive grid for displaying cards or other content.
class UPageGrid extends StatelessComponent {
  /// Grid items
  final List<Component> children;

  /// Number of columns on large screens
  final UPageGridColumns columns;

  /// Gap between items
  final String gap;

  /// Additional CSS classes
  final String? classes;

  const UPageGrid({
    super.key,
    this.children = const [],
    this.columns = UPageGridColumns.three,
    this.gap = '6',
    this.classes,
  });

  String get _columnsClasses {
    switch (columns) {
      case UPageGridColumns.one:
        return 'grid-cols-1';
      case UPageGridColumns.two:
        return 'grid-cols-1 sm:grid-cols-2';
      case UPageGridColumns.three:
        return 'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3';
      case UPageGridColumns.four:
        return 'grid-cols-1 sm:grid-cols-2 lg:grid-cols-4';
      case UPageGridColumns.five:
        return 'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5';
      case UPageGridColumns.six:
        return 'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'grid $_columnsClasses gap-$gap ${classes ?? ""}',
      children,
    );
  }
}
