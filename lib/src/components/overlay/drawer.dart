import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Drawer slide direction
enum UDrawerSide { left, right, top, bottom }

/// Drawer sizes
enum UDrawerSize { sm, md, lg, xl, full }

/// DuxtUI Drawer component - slides from edge of screen
class UDrawer extends StatefulComponent {
  final bool open;
  final UDrawerSide side;
  final UDrawerSize size;
  final String? title;
  final bool closeOnOverlay;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final List<Component> children;

  const UDrawer({
    super.key,
    required this.open,
    this.side = UDrawerSide.left,
    this.size = UDrawerSize.md,
    this.title,
    this.closeOnOverlay = true,
    this.onOpen,
    this.onClose,
    this.children = const [],
  });

  @override
  State<UDrawer> createState() => _UDrawerState();
}

class _UDrawerState extends State<UDrawer> {
  bool _wasOpen = false;

  String get _sizeClasses {
    final isHorizontal = component.side == UDrawerSide.left ||
        component.side == UDrawerSide.right;

    if (isHorizontal) {
      switch (component.size) {
        case UDrawerSize.sm:
          return 'w-64';
        case UDrawerSize.md:
          return 'w-80';
        case UDrawerSize.lg:
          return 'w-96';
        case UDrawerSize.xl:
          return 'w-[28rem]';
        case UDrawerSize.full:
          return 'w-screen';
      }
    } else {
      switch (component.size) {
        case UDrawerSize.sm:
          return 'h-48';
        case UDrawerSize.md:
          return 'h-64';
        case UDrawerSize.lg:
          return 'h-80';
        case UDrawerSize.xl:
          return 'h-96';
        case UDrawerSize.full:
          return 'h-screen';
      }
    }
  }

  String get _positionClasses {
    switch (component.side) {
      case UDrawerSide.left:
        return 'inset-y-0 left-0';
      case UDrawerSide.right:
        return 'inset-y-0 right-0';
      case UDrawerSide.top:
        return 'inset-x-0 top-0';
      case UDrawerSide.bottom:
        return 'inset-x-0 bottom-0';
    }
  }

  String get _transformClasses {
    if (!component.open) {
      switch (component.side) {
        case UDrawerSide.left:
          return '-translate-x-full';
        case UDrawerSide.right:
          return 'translate-x-full';
        case UDrawerSide.top:
          return '-translate-y-full';
        case UDrawerSide.bottom:
          return 'translate-y-full';
      }
    }
    return 'translate-x-0 translate-y-0';
  }

  @override
  Component build(BuildContext context) {
    // Trigger callbacks on state change
    if (component.open && !_wasOpen) {
      _wasOpen = true;
      component.onOpen?.call();
    } else if (!component.open && _wasOpen) {
      _wasOpen = false;
    }

    return div(
      classes:
          'fixed inset-0 z-50 ${component.open ? "" : "pointer-events-none"}',
      [
        // Backdrop
        div(
          classes:
              'fixed inset-0 bg-gray-900/50 dark:bg-gray-950/75 transition-opacity duration-300 ${component.open ? "opacity-100" : "opacity-0"}',
          events: component.closeOnOverlay && component.onClose != null
              ? {'click': (_) => component.onClose!()}
              : {},
          [],
        ),
        // Drawer panel
        div(
          classes:
              'fixed $_positionClasses $_sizeClasses bg-white dark:bg-gray-900 shadow-xl transition-transform duration-300 ease-in-out $_transformClasses',
          [
            // Header
            if (component.title != null || component.onClose != null)
              div(
                classes:
                    'flex items-center justify-between p-4 border-b border-gray-200 dark:border-gray-800',
                [
                  if (component.title != null)
                    h3(
                      classes:
                          'text-lg font-semibold text-gray-900 dark:text-white',
                      [Component.text(component.title!)],
                    ),
                  if (component.onClose != null)
                    button(
                      type: ButtonType.button,
                      onClick: component.onClose,
                      classes:
                          'p-1 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded',
                      [
                        span(classes: 'text-xl', [Component.text('\u00D7')]),
                      ],
                    ),
                ],
              ),
            // Body
            div(
              classes: 'flex-1 overflow-y-auto p-4',
              component.children,
            ),
          ],
        ),
      ],
    );
  }
}
