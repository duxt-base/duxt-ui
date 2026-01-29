import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Drawer slide direction
enum DDrawerSide { left, right, top, bottom }

/// Drawer sizes
enum DDrawerSize { sm, md, lg, xl, full }

/// DuxtUI Drawer component - slides from edge of screen
class DDrawer extends StatefulComponent {
  final bool open;
  final DDrawerSide side;
  final DDrawerSize size;
  final String? title;
  final bool closeOnOverlay;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final List<Component> children;

  const DDrawer({
    super.key,
    required this.open,
    this.side = DDrawerSide.left,
    this.size = DDrawerSize.md,
    this.title,
    this.closeOnOverlay = true,
    this.onOpen,
    this.onClose,
    this.children = const [],
  });

  @override
  State<DDrawer> createState() => _UDrawerState();
}

class _UDrawerState extends State<DDrawer> {
  bool _wasOpen = false;

  String get _sizeClasses {
    final isHorizontal = component.side == DDrawerSide.left ||
        component.side == DDrawerSide.right;

    if (isHorizontal) {
      switch (component.size) {
        case DDrawerSize.sm:
          return 'w-64';
        case DDrawerSize.md:
          return 'w-80';
        case DDrawerSize.lg:
          return 'w-96';
        case DDrawerSize.xl:
          return 'w-[28rem]';
        case DDrawerSize.full:
          return 'w-screen';
      }
    } else {
      switch (component.size) {
        case DDrawerSize.sm:
          return 'h-48';
        case DDrawerSize.md:
          return 'h-64';
        case DDrawerSize.lg:
          return 'h-80';
        case DDrawerSize.xl:
          return 'h-96';
        case DDrawerSize.full:
          return 'h-screen';
      }
    }
  }

  String get _positionClasses {
    switch (component.side) {
      case DDrawerSide.left:
        return 'inset-y-0 left-0';
      case DDrawerSide.right:
        return 'inset-y-0 right-0';
      case DDrawerSide.top:
        return 'inset-x-0 top-0';
      case DDrawerSide.bottom:
        return 'inset-x-0 bottom-0';
    }
  }

  String get _transformClasses {
    if (!component.open) {
      switch (component.side) {
        case DDrawerSide.left:
          return '-translate-x-full';
        case DDrawerSide.right:
          return 'translate-x-full';
        case DDrawerSide.top:
          return '-translate-y-full';
        case DDrawerSide.bottom:
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
