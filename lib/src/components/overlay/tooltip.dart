import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Tooltip placement options
enum UTooltipPlacement {
  top,
  topStart,
  topEnd,
  bottom,
  bottomStart,
  bottomEnd,
  left,
  right,
}

/// DuxtUI Tooltip component - hover hint
class UTooltip extends StatefulComponent {
  final Component child;
  final String text;
  final UTooltipPlacement placement;
  final int delayMs;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

  const UTooltip({
    super.key,
    required this.child,
    required this.text,
    this.placement = UTooltipPlacement.top,
    this.delayMs = 0,
    this.onOpen,
    this.onClose,
  });

  @override
  State<UTooltip> createState() => _UTooltipState();
}

class _UTooltipState extends State<UTooltip> {
  bool _visible = false;

  void _show() {
    setState(() {
      _visible = true;
      component.onOpen?.call();
    });
  }

  void _hide() {
    setState(() {
      _visible = false;
      component.onClose?.call();
    });
  }

  String get _positionClasses {
    switch (component.placement) {
      case UTooltipPlacement.top:
        return 'bottom-full left-1/2 -translate-x-1/2 mb-2';
      case UTooltipPlacement.topStart:
        return 'bottom-full left-0 mb-2';
      case UTooltipPlacement.topEnd:
        return 'bottom-full right-0 mb-2';
      case UTooltipPlacement.bottom:
        return 'top-full left-1/2 -translate-x-1/2 mt-2';
      case UTooltipPlacement.bottomStart:
        return 'top-full left-0 mt-2';
      case UTooltipPlacement.bottomEnd:
        return 'top-full right-0 mt-2';
      case UTooltipPlacement.left:
        return 'right-full top-1/2 -translate-y-1/2 mr-2';
      case UTooltipPlacement.right:
        return 'left-full top-1/2 -translate-y-1/2 ml-2';
    }
  }

  String get _arrowClasses {
    switch (component.placement) {
      case UTooltipPlacement.top:
      case UTooltipPlacement.topStart:
      case UTooltipPlacement.topEnd:
        return 'top-full left-1/2 -translate-x-1/2 border-t-gray-900 dark:border-t-gray-100 border-t-4 border-x-4 border-x-transparent border-b-0';
      case UTooltipPlacement.bottom:
      case UTooltipPlacement.bottomStart:
      case UTooltipPlacement.bottomEnd:
        return 'bottom-full left-1/2 -translate-x-1/2 border-b-gray-900 dark:border-b-gray-100 border-b-4 border-x-4 border-x-transparent border-t-0';
      case UTooltipPlacement.left:
        return 'left-full top-1/2 -translate-y-1/2 border-l-gray-900 dark:border-l-gray-100 border-l-4 border-y-4 border-y-transparent border-r-0';
      case UTooltipPlacement.right:
        return 'right-full top-1/2 -translate-y-1/2 border-r-gray-900 dark:border-r-gray-100 border-r-4 border-y-4 border-y-transparent border-l-0';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'relative inline-block',
      [
        // Child with hover events
        div(
          events: {
            'mouseenter': (_) => _show(),
            'mouseleave': (_) => _hide(),
            'focus': (_) => _show(),
            'blur': (_) => _hide(),
          },
          [component.child],
        ),
        // Tooltip
        if (_visible)
          div(
            classes:
                'absolute z-50 $_positionClasses px-2 py-1 text-xs font-medium bg-gray-900 dark:bg-gray-100 text-white dark:text-gray-900 rounded whitespace-nowrap pointer-events-none',
            [
              Component.text(component.text),
              // Arrow
              div(
                classes: 'absolute w-0 h-0 $_arrowClasses',
                [],
              ),
            ],
          ),
      ],
    );
  }
}

/// Tooltip with custom content instead of just text
class UTooltipCustom extends StatefulComponent {
  final Component child;
  final Component content;
  final UTooltipPlacement placement;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

  const UTooltipCustom({
    super.key,
    required this.child,
    required this.content,
    this.placement = UTooltipPlacement.top,
    this.onOpen,
    this.onClose,
  });

  @override
  State<UTooltipCustom> createState() => _UTooltipCustomState();
}

class _UTooltipCustomState extends State<UTooltipCustom> {
  bool _visible = false;

  void _show() {
    setState(() {
      _visible = true;
      component.onOpen?.call();
    });
  }

  void _hide() {
    setState(() {
      _visible = false;
      component.onClose?.call();
    });
  }

  String get _positionClasses {
    switch (component.placement) {
      case UTooltipPlacement.top:
        return 'bottom-full left-1/2 -translate-x-1/2 mb-2';
      case UTooltipPlacement.topStart:
        return 'bottom-full left-0 mb-2';
      case UTooltipPlacement.topEnd:
        return 'bottom-full right-0 mb-2';
      case UTooltipPlacement.bottom:
        return 'top-full left-1/2 -translate-x-1/2 mt-2';
      case UTooltipPlacement.bottomStart:
        return 'top-full left-0 mt-2';
      case UTooltipPlacement.bottomEnd:
        return 'top-full right-0 mt-2';
      case UTooltipPlacement.left:
        return 'right-full top-1/2 -translate-y-1/2 mr-2';
      case UTooltipPlacement.right:
        return 'left-full top-1/2 -translate-y-1/2 ml-2';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'relative inline-block',
      [
        // Child with hover events
        div(
          events: {
            'mouseenter': (_) => _show(),
            'mouseleave': (_) => _hide(),
            'focus': (_) => _show(),
            'blur': (_) => _hide(),
          },
          [component.child],
        ),
        // Tooltip
        if (_visible)
          div(
            classes:
                'absolute z-50 $_positionClasses bg-gray-900 dark:bg-gray-100 text-white dark:text-gray-900 rounded p-2 pointer-events-none',
            [component.content],
          ),
      ],
    );
  }
}
