import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Slideover slide direction
enum USlideoverSide { left, right }

/// Slideover sizes
enum USlideoverSize { sm, md, lg, xl, full }

/// DuxtUI Slideover component - panel that slides over content from side
class USlideover extends StatefulComponent {
  final bool open;
  final USlideoverSide side;
  final USlideoverSize size;
  final String? title;
  final String? description;
  final Component? footer;
  final bool closeOnOverlay;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final List<Component> children;

  const USlideover({
    super.key,
    required this.open,
    this.side = USlideoverSide.right,
    this.size = USlideoverSize.md,
    this.title,
    this.description,
    this.footer,
    this.closeOnOverlay = true,
    this.onOpen,
    this.onClose,
    this.children = const [],
  });

  @override
  State<USlideover> createState() => _USlideoverState();
}

class _USlideoverState extends State<USlideover> {
  bool _wasOpen = false;

  String get _sizeClasses {
    switch (component.size) {
      case USlideoverSize.sm:
        return 'max-w-sm';
      case USlideoverSize.md:
        return 'max-w-md';
      case USlideoverSize.lg:
        return 'max-w-lg';
      case USlideoverSize.xl:
        return 'max-w-xl';
      case USlideoverSize.full:
        return 'max-w-full';
    }
  }

  String get _positionClasses {
    switch (component.side) {
      case USlideoverSide.left:
        return 'inset-y-0 left-0';
      case USlideoverSide.right:
        return 'inset-y-0 right-0';
    }
  }

  String get _transformClasses {
    if (!component.open) {
      switch (component.side) {
        case USlideoverSide.left:
          return '-translate-x-full';
        case USlideoverSide.right:
          return 'translate-x-full';
      }
    }
    return 'translate-x-0';
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
        // Slideover panel
        div(
          classes:
              'fixed $_positionClasses w-full $_sizeClasses h-full bg-white dark:bg-gray-900 shadow-xl transition-transform duration-300 ease-in-out $_transformClasses flex flex-col',
          [
            // Header
            if (component.title != null || component.onClose != null)
              div(
                classes:
                    'flex items-start justify-between p-4 border-b border-gray-200 dark:border-gray-800',
                [
                  div(
                    classes: 'flex-1',
                    [
                      if (component.title != null)
                        h3(
                          classes:
                              'text-lg font-semibold text-gray-900 dark:text-white',
                          [Component.text(component.title!)],
                        ),
                      if (component.description != null)
                        p(
                          classes:
                              'mt-1 text-sm text-gray-500 dark:text-gray-400',
                          [Component.text(component.description!)],
                        ),
                    ],
                  ),
                  if (component.onClose != null)
                    button(
                      type: ButtonType.button,
                      onClick: component.onClose,
                      classes:
                          'ml-4 p-1 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded',
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
            // Footer
            if (component.footer != null)
              div(
                classes:
                    'p-4 border-t border-gray-200 dark:border-gray-800 bg-gray-50 dark:bg-gray-800/50',
                [component.footer!],
              ),
          ],
        ),
      ],
    );
  }
}
