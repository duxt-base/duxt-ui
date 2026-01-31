import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI DashboardPanel component
///
/// A flexible panel component that can be resizable.
/// Used as the main content area in dashboard layouts.
class DDashboardPanel extends StatefulComponent {
  /// Custom CSS classes to apply to the panel
  final String? classes;

  /// Whether the panel is resizable
  final bool resizable;

  /// Resize direction (only applicable when resizable is true)
  final DPanelResizeDirection resizeDirection;

  /// Initial width (for horizontal resize)
  final double? initialWidth;

  /// Minimum width when resizing
  final double minWidth;

  /// Maximum width when resizing
  final double maxWidth;

  /// Whether this panel should grow to fill available space
  final bool grow;

  /// Child components
  final List<Component> children;

  const DDashboardPanel({
    super.key,
    this.classes,
    this.resizable = false,
    this.resizeDirection = DPanelResizeDirection.right,
    this.initialWidth,
    this.minWidth = 200,
    this.maxWidth = 600,
    this.grow = true,
    this.children = const [],
  });

  @override
  State<DDashboardPanel> createState() => _UDashboardPanelState();
}

class _UDashboardPanelState extends State<DDashboardPanel> {
  double? _width;
  bool _isResizing = false;

  @override
  void initState() {
    super.initState();
    _width = component.initialWidth;
  }

  String get _baseClasses {
    final grow = component.grow ? 'flex-1' : '';
    return 'flex flex-col min-w-0 $grow';
  }

  String get _resizeHandleClasses {
    switch (component.resizeDirection) {
      case DPanelResizeDirection.left:
        return 'absolute left-0 top-0 bottom-0 w-1 cursor-col-resize hover:bg-cyan-500 transition-colors';
      case DPanelResizeDirection.right:
        return 'absolute right-0 top-0 bottom-0 w-1 cursor-col-resize hover:bg-cyan-500 transition-colors';
    }
  }

  @override
  Component build(BuildContext context) {
    if (!component.resizable) {
      return div(
        classes: '$_baseClasses ${component.classes ?? ""}',
        component.children,
      );
    }

    return div(
      classes: 'relative $_baseClasses ${component.classes ?? ""}',
      styles: _width != null ? Styles(raw: {'width': '${_width}px'}) : null,
      [
        // Content
        ...component.children,
        // Resize handle
        div(
          classes: _resizeHandleClasses,
          events: {
            'mousedown': (event) {
              setState(() => _isResizing = true);
            },
          },
          [],
        ),
        // Resize overlay (when resizing)
        if (_isResizing)
          div(
            classes: 'fixed inset-0 z-50 cursor-col-resize',
            events: {
              'mousemove': (event) {
                // Note: In a real implementation, this would calculate
                // the new width based on mouse position
              },
              'mouseup': (event) {
                setState(() => _isResizing = false);
              },
            },
            [],
          ),
      ],
    );
  }
}

/// Panel resize direction
enum DPanelResizeDirection { left, right }
