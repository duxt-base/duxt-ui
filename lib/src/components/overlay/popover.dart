import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Popover placement options
enum DPopoverPlacement {
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

/// DuxtUI Popover component using native HTML details/summary
///
/// Uses native `<details>` and `<summary>` elements for accessibility
/// and interactivity without JavaScript.
class DPopover extends StatelessComponent {
  final Component trigger;
  final DPopoverPlacement placement;
  final bool closeOnClickOutside;
  final List<Component> children;

  const DPopover({
    super.key,
    required this.trigger,
    this.placement = DPopoverPlacement.bottom,
    this.closeOnClickOutside = true,
    this.children = const [],
  });

  String get _positionClasses {
    switch (placement) {
      case DPopoverPlacement.top:
        return 'bottom-full left-1/2 -translate-x-1/2 mb-2';
      case DPopoverPlacement.topStart:
        return 'bottom-full left-0 mb-2';
      case DPopoverPlacement.topEnd:
        return 'bottom-full right-0 mb-2';
      case DPopoverPlacement.bottom:
        return 'top-full left-1/2 -translate-x-1/2 mt-2';
      case DPopoverPlacement.bottomStart:
        return 'top-full left-0 mt-2';
      case DPopoverPlacement.bottomEnd:
        return 'top-full right-0 mt-2';
      case DPopoverPlacement.left:
        return 'right-full top-1/2 -translate-y-1/2 mr-2';
      case DPopoverPlacement.leftStart:
        return 'right-full top-0 mr-2';
      case DPopoverPlacement.leftEnd:
        return 'right-full bottom-0 mr-2';
      case DPopoverPlacement.right:
        return 'left-full top-1/2 -translate-y-1/2 ml-2';
      case DPopoverPlacement.rightStart:
        return 'left-full top-0 ml-2';
      case DPopoverPlacement.rightEnd:
        return 'left-full bottom-0 ml-2';
    }
  }

  @override
  Component build(BuildContext context) {
    return details(
      classes: 'relative inline-block group',
      attributes: {
        'data-popover': 'true',
      },
      [
        // Trigger wrapped in summary - use pointer-events to let summary handle clicks
        summary(
          classes: 'list-none [&::-webkit-details-marker]:hidden cursor-pointer [&>*]:pointer-events-none',
          [trigger],
        ),
        // Popover panel
        div(
          classes:
              'absolute z-50 $_positionClasses bg-white dark:bg-zinc-900 rounded-lg shadow-lg ring-1 ring-gray-200 dark:ring-gray-800',
          children,
        ),
        // Global click-outside handler (only added once per page)
        if (closeOnClickOutside)
          RawText('''<script>
if (!window._popoverInit) {
  window._popoverInit = true;
  document.addEventListener('click', function(e) {
    document.querySelectorAll('details[data-popover][open]').forEach(function(d) {
      if (!d.contains(e.target)) d.removeAttribute('open');
    });
  });
}
</script>'''),
      ],
    );
  }
}

/// Controlled popover that accepts external open state
///
/// For use in @client components where parent manages the open state.
class DPopoverControlled extends StatelessComponent {
  final bool open;
  final Component trigger;
  final DPopoverPlacement placement;
  final VoidCallback? onToggle;
  final VoidCallback? onClose;
  final List<Component> children;

  const DPopoverControlled({
    super.key,
    required this.open,
    required this.trigger,
    this.placement = DPopoverPlacement.bottom,
    this.onToggle,
    this.onClose,
    this.children = const [],
  });

  String get _positionClasses {
    switch (placement) {
      case DPopoverPlacement.top:
        return 'bottom-full left-1/2 -translate-x-1/2 mb-2';
      case DPopoverPlacement.topStart:
        return 'bottom-full left-0 mb-2';
      case DPopoverPlacement.topEnd:
        return 'bottom-full right-0 mb-2';
      case DPopoverPlacement.bottom:
        return 'top-full left-1/2 -translate-x-1/2 mt-2';
      case DPopoverPlacement.bottomStart:
        return 'top-full left-0 mt-2';
      case DPopoverPlacement.bottomEnd:
        return 'top-full right-0 mt-2';
      case DPopoverPlacement.left:
        return 'right-full top-1/2 -translate-y-1/2 mr-2';
      case DPopoverPlacement.leftStart:
        return 'right-full top-0 mr-2';
      case DPopoverPlacement.leftEnd:
        return 'right-full bottom-0 mr-2';
      case DPopoverPlacement.right:
        return 'left-full top-1/2 -translate-y-1/2 ml-2';
      case DPopoverPlacement.rightStart:
        return 'left-full top-0 ml-2';
      case DPopoverPlacement.rightEnd:
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
                'absolute z-50 $_positionClasses bg-white dark:bg-zinc-900 rounded-lg shadow-lg ring-1 ring-gray-200 dark:ring-gray-800 p-4',
            children,
          ),
        ],
      ],
    );
  }
}
