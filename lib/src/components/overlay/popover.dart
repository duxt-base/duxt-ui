import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Popover placement options
enum UPopoverPlacement {
  top,
  topStart,
  topEnd,
  bottom,
  bottomStart,
  bottomEnd,
  left,
  leftStart,
  leftEnd,
  right,
  rightStart,
  rightEnd,
}

/// DuxtUI Popover component - floating content near trigger
class UPopover extends StatefulComponent {
  final Component trigger;
  final UPopoverPlacement placement;
  final bool closeOnClickOutside;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final List<Component> children;

  const UPopover({
    super.key,
    required this.trigger,
    this.placement = UPopoverPlacement.bottom,
    this.closeOnClickOutside = true,
    this.onOpen,
    this.onClose,
    this.children = const [],
  });

  @override
  State<UPopover> createState() => _UPopoverState();
}

class _UPopoverState extends State<UPopover> {
  bool _open = false;

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        component.onOpen?.call();
      } else {
        component.onClose?.call();
      }
    });
  }

  void _close() {
    if (_open) {
      setState(() {
        _open = false;
        component.onClose?.call();
      });
    }
  }

  String get _positionClasses {
    switch (component.placement) {
      case UPopoverPlacement.top:
        return 'bottom-full left-1/2 -translate-x-1/2 mb-2';
      case UPopoverPlacement.topStart:
        return 'bottom-full left-0 mb-2';
      case UPopoverPlacement.topEnd:
        return 'bottom-full right-0 mb-2';
      case UPopoverPlacement.bottom:
        return 'top-full left-1/2 -translate-x-1/2 mt-2';
      case UPopoverPlacement.bottomStart:
        return 'top-full left-0 mt-2';
      case UPopoverPlacement.bottomEnd:
        return 'top-full right-0 mt-2';
      case UPopoverPlacement.left:
        return 'right-full top-1/2 -translate-y-1/2 mr-2';
      case UPopoverPlacement.leftStart:
        return 'right-full top-0 mr-2';
      case UPopoverPlacement.leftEnd:
        return 'right-full bottom-0 mr-2';
      case UPopoverPlacement.right:
        return 'left-full top-1/2 -translate-y-1/2 ml-2';
      case UPopoverPlacement.rightStart:
        return 'left-full top-0 ml-2';
      case UPopoverPlacement.rightEnd:
        return 'left-full bottom-0 ml-2';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'relative inline-block',
      [
        // Trigger
        div(
          events: {'click': (_) => _toggle()},
          [component.trigger],
        ),
        // Popover content
        if (_open) ...[
          // Invisible overlay to catch outside clicks
          if (component.closeOnClickOutside)
            div(
              classes: 'fixed inset-0 z-40',
              events: {'click': (_) => _close()},
              [],
            ),
          // Popover panel
          div(
            classes:
                'absolute z-50 $_positionClasses bg-white dark:bg-gray-900 rounded-lg shadow-lg ring-1 ring-gray-200 dark:ring-gray-800 p-4',
            component.children,
          ),
        ],
      ],
    );
  }
}

/// Controlled popover that accepts external open state
class UPopoverControlled extends StatelessComponent {
  final bool open;
  final Component trigger;
  final UPopoverPlacement placement;
  final VoidCallback? onToggle;
  final VoidCallback? onClose;
  final List<Component> children;

  const UPopoverControlled({
    super.key,
    required this.open,
    required this.trigger,
    this.placement = UPopoverPlacement.bottom,
    this.onToggle,
    this.onClose,
    this.children = const [],
  });

  String get _positionClasses {
    switch (placement) {
      case UPopoverPlacement.top:
        return 'bottom-full left-1/2 -translate-x-1/2 mb-2';
      case UPopoverPlacement.topStart:
        return 'bottom-full left-0 mb-2';
      case UPopoverPlacement.topEnd:
        return 'bottom-full right-0 mb-2';
      case UPopoverPlacement.bottom:
        return 'top-full left-1/2 -translate-x-1/2 mt-2';
      case UPopoverPlacement.bottomStart:
        return 'top-full left-0 mt-2';
      case UPopoverPlacement.bottomEnd:
        return 'top-full right-0 mt-2';
      case UPopoverPlacement.left:
        return 'right-full top-1/2 -translate-y-1/2 mr-2';
      case UPopoverPlacement.leftStart:
        return 'right-full top-0 mr-2';
      case UPopoverPlacement.leftEnd:
        return 'right-full bottom-0 mr-2';
      case UPopoverPlacement.right:
        return 'left-full top-1/2 -translate-y-1/2 ml-2';
      case UPopoverPlacement.rightStart:
        return 'left-full top-0 ml-2';
      case UPopoverPlacement.rightEnd:
        return 'left-full bottom-0 ml-2';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'relative inline-block',
      [
        // Trigger
        div(
          events: onToggle != null ? {'click': (_) => onToggle!()} : {},
          [trigger],
        ),
        // Popover content
        if (open) ...[
          // Invisible overlay to catch outside clicks
          if (onClose != null)
            div(
              classes: 'fixed inset-0 z-40',
              events: {'click': (_) => onClose!()},
              [],
            ),
          // Popover panel
          div(
            classes:
                'absolute z-50 $_positionClasses bg-white dark:bg-gray-900 rounded-lg shadow-lg ring-1 ring-gray-200 dark:ring-gray-800 p-4',
            children,
          ),
        ],
      ],
    );
  }
}
