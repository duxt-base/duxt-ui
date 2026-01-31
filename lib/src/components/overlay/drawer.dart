import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Drawer slide direction
enum DDrawerSide { left, right, top, bottom }

/// Drawer sizes
enum DDrawerSize { sm, md, lg, xl, full }

/// DuxtUI Drawer component - uses native HTML dialog element with slide animation
///
/// Uses inline JavaScript for interactivity.
class DDrawer extends StatelessComponent {
  final Component trigger;
  final DDrawerSide side;
  final DDrawerSize size;
  final String? title;
  final bool closeOnOverlay;
  final List<Component> children;

  const DDrawer({
    super.key,
    required this.trigger,
    this.side = DDrawerSide.left,
    this.size = DDrawerSize.md,
    this.title,
    this.closeOnOverlay = true,
    this.children = const [],
  });

  String get _sizeClasses {
    final isHorizontal = side == DDrawerSide.left || side == DDrawerSide.right;

    if (isHorizontal) {
      switch (size) {
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
      switch (size) {
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
    switch (side) {
      case DDrawerSide.left:
        return 'mr-auto ml-0 h-full max-h-full';
      case DDrawerSide.right:
        return 'ml-auto mr-0 h-full max-h-full';
      case DDrawerSide.top:
        return 'mt-0 mb-auto w-full max-w-full';
      case DDrawerSide.bottom:
        return 'mb-0 mt-auto w-full max-w-full';
    }
  }

  String get _sideAttr {
    switch (side) {
      case DDrawerSide.left:
        return 'left';
      case DDrawerSide.right:
        return 'right';
      case DDrawerSide.top:
        return 'top';
      case DDrawerSide.bottom:
        return 'bottom';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'inline-block',
      attributes: {'data-drawer': 'true'},
      [
        // Trigger
        div(
          attributes: {'data-drawer-trigger': 'true'},
          classes: 'cursor-pointer inline-block',
          [trigger],
        ),
        // Dialog element for drawer
        Component.element(
          tag: 'dialog',
          classes:
              '$_sizeClasses $_positionClasses bg-white dark:bg-zinc-900 shadow-xl p-0 border-none backdrop:bg-gray-900/50 dark:backdrop:bg-zinc-950/75 backdrop:transition-opacity backdrop:duration-300',
          attributes: {
            'data-drawer-dialog': 'true',
            'data-side': _sideAttr,
            if (closeOnOverlay) 'data-close-on-backdrop': 'true',
          },
          children: [
            div(
              classes: 'flex flex-col h-full',
              [
                // Header
                div(
                  classes:
                      'flex items-center justify-between p-4 border-b border-gray-200 dark:border-gray-800',
                  [
                    if (title != null)
                      h3(
                        classes:
                            'text-lg font-semibold text-gray-900 dark:text-white',
                        [Component.text(title!)],
                      )
                    else
                      span([]),
                    // Close button
                    button(
                      type: ButtonType.button,
                      classes:
                          'p-1 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded',
                      attributes: {'data-drawer-close': 'true'},
                      [
                        span(classes: 'text-xl', [Component.text('×')]),
                      ],
                    ),
                  ],
                ),
                // Body
                div(
                  classes: 'flex-1 overflow-y-auto p-4',
                  children,
                ),
              ],
            ),
          ],
        ),
        // Drawer CSS and JavaScript
        RawText('''<style>
dialog[data-drawer-dialog] {
  transition: transform 0.3s ease-out, display 0.3s allow-discrete, overlay 0.3s allow-discrete;
}
dialog[data-drawer-dialog][data-side="left"] {
  transform: translateX(-100%);
}
dialog[data-drawer-dialog][data-side="right"] {
  transform: translateX(100%);
}
dialog[data-drawer-dialog][data-side="top"] {
  transform: translateY(-100%);
}
dialog[data-drawer-dialog][data-side="bottom"] {
  transform: translateY(100%);
}
dialog[data-drawer-dialog][open] {
  transform: translate(0, 0);
}
@starting-style {
  dialog[data-drawer-dialog][open][data-side="left"] {
    transform: translateX(-100%);
  }
  dialog[data-drawer-dialog][open][data-side="right"] {
    transform: translateX(100%);
  }
  dialog[data-drawer-dialog][open][data-side="top"] {
    transform: translateY(-100%);
  }
  dialog[data-drawer-dialog][open][data-side="bottom"] {
    transform: translateY(100%);
  }
  dialog[data-drawer-dialog][open]::backdrop {
    opacity: 0;
  }
}
</style>
<script>
if (!window._drawerDialogInit) {
  window._drawerDialogInit = true;

  document.addEventListener('click', function(e) {
    // Open trigger
    var trigger = e.target.closest('[data-drawer-trigger]');
    if (trigger) {
      var drawer = trigger.closest('[data-drawer]');
      var dialog = drawer.querySelector('[data-drawer-dialog]');
      if (dialog) dialog.showModal();
      return;
    }

    // Close button
    var closeBtn = e.target.closest('[data-drawer-close]');
    if (closeBtn) {
      var dialog = closeBtn.closest('dialog');
      if (dialog) dialog.close();
      return;
    }

    // Backdrop click
    var dialog = e.target;
    if (dialog.tagName === 'DIALOG' && dialog.hasAttribute('data-close-on-backdrop')) {
      var rect = dialog.getBoundingClientRect();
      var isInDialog = (e.clientX >= rect.left && e.clientX <= rect.right &&
                        e.clientY >= rect.top && e.clientY <= rect.bottom);
      if (!isInDialog) {
        dialog.close();
      }
    }
  });
}
</script>'''),
      ],
    );
  }
}

/// Controlled drawer for use with @client components
class DDrawerControlled extends StatelessComponent {
  final bool open;
  final DDrawerSide side;
  final DDrawerSize size;
  final String? title;
  final bool closeOnOverlay;
  final VoidCallback? onClose;
  final List<Component> children;

  const DDrawerControlled({
    super.key,
    required this.open,
    this.side = DDrawerSide.left,
    this.size = DDrawerSize.md,
    this.title,
    this.closeOnOverlay = true,
    this.onClose,
    this.children = const [],
  });

  String get _sizeClasses {
    final isHorizontal = side == DDrawerSide.left || side == DDrawerSide.right;

    if (isHorizontal) {
      switch (size) {
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
      switch (size) {
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
    switch (side) {
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
    if (!open) {
      switch (side) {
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
    return div(
      classes: 'fixed inset-0 z-50 ${open ? "" : "pointer-events-none"}',
      [
        // Backdrop
        div(
          classes:
              'fixed inset-0 bg-gray-900/50 dark:bg-zinc-950/75 transition-opacity duration-300 ${open ? "opacity-100" : "opacity-0"}',
          events: closeOnOverlay && onClose != null
              ? {'click': (_) => onClose!()}
              : {},
          [],
        ),
        // Drawer panel
        div(
          classes:
              'fixed $_positionClasses $_sizeClasses bg-white dark:bg-zinc-900 shadow-xl transition-transform duration-300 ease-in-out $_transformClasses flex flex-col',
          [
            // Header
            if (title != null || onClose != null)
              div(
                classes:
                    'flex items-center justify-between p-4 border-b border-gray-200 dark:border-gray-800',
                [
                  if (title != null)
                    h3(
                      classes:
                          'text-lg font-semibold text-gray-900 dark:text-white',
                      [Component.text(title!)],
                    ),
                  if (onClose != null)
                    button(
                      type: ButtonType.button,
                      onClick: onClose,
                      classes:
                          'p-1 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded',
                      [
                        span(classes: 'text-xl', [Component.text('×')]),
                      ],
                    ),
                ],
              ),
            // Body
            div(
              classes: 'flex-1 overflow-y-auto p-4',
              children,
            ),
          ],
        ),
      ],
    );
  }
}
