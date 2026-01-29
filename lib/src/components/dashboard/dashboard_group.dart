import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI DashboardGroup component
///
/// A layout wrapper that provides the main container for dashboard layouts.
/// Uses flexbox with min-h-screen to fill the viewport.
class UDashboardGroup extends StatelessComponent {
  /// Custom CSS classes to apply to the group container
  final String? classes;

  /// Orientation of the dashboard layout
  final UDashboardOrientation orientation;

  /// Child components (typically sidebar + panel combinations)
  final List<Component> children;

  const UDashboardGroup({
    super.key,
    this.classes,
    this.orientation = UDashboardOrientation.horizontal,
    this.children = const [],
  });

  String get _orientationClasses {
    switch (orientation) {
      case UDashboardOrientation.horizontal:
        return 'flex-row';
      case UDashboardOrientation.vertical:
        return 'flex-col';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'flex min-h-screen $_orientationClasses ${classes ?? ""}',
      children,
    );
  }
}

/// Dashboard orientation options
enum UDashboardOrientation { horizontal, vertical }
