import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Tooltip placement options
enum DTooltipPlacement {
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
class DTooltip extends StatefulComponent {
  final Component child;
  final String text;
  final DTooltipPlacement placement;
  final int delayMs;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

  const DTooltip({
    super.key,
    required this.child,
    required this.text,
    this.placement = DTooltipPlacement.top,
    this.delayMs = 0,
    this.onOpen,
    this.onClose,
  });

  @override
  State<DTooltip> createState() => _UTooltipState();
}

class _UTooltipState extends State<DTooltip> {
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
      case DTooltipPlacement.top:
        return 'bottom-full left-1/2 -translate-x-1/2 mb-2';
      case DTooltipPlacement.topStart:
        return 'bottom-full left-0 mb-2';
      case DTooltipPlacement.topEnd:
        return 'bottom-full right-0 mb-2';
      case DTooltipPlacement.bottom:
        return 'top-full left-1/2 -translate-x-1/2 mt-2';
      case DTooltipPlacement.bottomStart:
        return 'top-full left-0 mt-2';
      case DTooltipPlacement.bottomEnd:
        return 'top-full right-0 mt-2';
      case DTooltipPlacement.left:
        return 'right-full top-1/2 -translate-y-1/2 mr-2';
      case DTooltipPlacement.right:
        return 'left-full top-1/2 -translate-y-1/2 ml-2';
    }
  }

  String get _arrowClasses {
    switch (component.placement) {
      case DTooltipPlacement.top:
      case DTooltipPlacement.topStart:
      case DTooltipPlacement.topEnd:
        return 'top-full left-1/2 -translate-x-1/2 border-t-gray-900 dark:border-t-gray-100 border-t-4 border-x-4 border-x-transparent border-b-0';
      case DTooltipPlacement.bottom:
      case DTooltipPlacement.bottomStart:
      case DTooltipPlacement.bottomEnd:
        return 'bottom-full left-1/2 -translate-x-1/2 border-b-gray-900 dark:border-b-gray-100 border-b-4 border-x-4 border-x-transparent border-t-0';
      case DTooltipPlacement.left:
        return 'left-full top-1/2 -translate-y-1/2 border-l-gray-900 dark:border-l-gray-100 border-l-4 border-y-4 border-y-transparent border-r-0';
      case DTooltipPlacement.right:
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
class DTooltipCustom extends StatefulComponent {
  final Component child;
  final Component content;
  final DTooltipPlacement placement;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

  const DTooltipCustom({
    super.key,
    required this.child,
    required this.content,
    this.placement = DTooltipPlacement.top,
    this.onOpen,
    this.onClose,
  });

  @override
  State<DTooltipCustom> createState() => _UTooltipCustomState();
}

class _UTooltipCustomState extends State<DTooltipCustom> {
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
      case DTooltipPlacement.top:
        return 'bottom-full left-1/2 -translate-x-1/2 mb-2';
      case DTooltipPlacement.topStart:
        return 'bottom-full left-0 mb-2';
      case DTooltipPlacement.topEnd:
        return 'bottom-full right-0 mb-2';
      case DTooltipPlacement.bottom:
        return 'top-full left-1/2 -translate-x-1/2 mt-2';
      case DTooltipPlacement.bottomStart:
        return 'top-full left-0 mt-2';
      case DTooltipPlacement.bottomEnd:
        return 'top-full right-0 mt-2';
      case DTooltipPlacement.left:
        return 'right-full top-1/2 -translate-y-1/2 mr-2';
      case DTooltipPlacement.right:
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
