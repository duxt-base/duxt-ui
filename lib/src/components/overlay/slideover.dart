import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Slideover slide direction
enum DSlideoverSide { left, right }

/// Slideover sizes
enum DSlideoverSize { sm, md, lg, xl, full }

/// DuxtUI Slideover component - uses native HTML dialog element with slide animation
///
/// Uses inline JavaScript for interactivity.
class DSlideover extends StatelessComponent {
  final Component trigger;
  final DSlideoverSide side;
  final DSlideoverSize size;
  final String? title;
  final String? description;
  final Component? footer;
  final bool closeOnOverlay;
  final List<Component> children;

  const DSlideover({
    super.key,
    required this.trigger,
    this.side = DSlideoverSide.right,
    this.size = DSlideoverSize.md,
    this.title,
    this.description,
    this.footer,
    this.closeOnOverlay = true,
    this.children = const [],
  });

  String get _sizeClasses {
    switch (size) {
      case DSlideoverSize.sm:
        return 'max-w-sm';
      case DSlideoverSize.md:
        return 'max-w-md';
      case DSlideoverSize.lg:
        return 'max-w-lg';
      case DSlideoverSize.xl:
        return 'max-w-xl';
      case DSlideoverSize.full:
        return 'max-w-full';
    }
  }

  String get _positionClasses {
    switch (side) {
      case DSlideoverSide.left:
        return 'mr-auto ml-0';
      case DSlideoverSide.right:
        return 'ml-auto mr-0';
    }
  }

  String get _sideAttr {
    switch (side) {
      case DSlideoverSide.left:
        return 'left';
      case DSlideoverSide.right:
        return 'right';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'inline-block',
      attributes: {'data-slideover': 'true'},
      [
        // Trigger
        div(
          attributes: {'data-slideover-trigger': 'true'},
          classes: 'cursor-pointer inline-block',
          [trigger],
        ),
        // Dialog element for slideover
        Component.element(
          tag: 'dialog',
          classes:
              'w-full $_sizeClasses h-full max-h-full $_positionClasses bg-white dark:bg-zinc-900 shadow-xl p-0 border-none backdrop:bg-gray-900/50 dark:backdrop:bg-zinc-950/75 backdrop:transition-opacity backdrop:duration-300',
          attributes: {
            'data-slideover-dialog': 'true',
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
                      'flex items-start justify-between p-4 border-b border-gray-200 dark:border-gray-800',
                  [
                    div(
                      classes: 'flex-1',
                      [
                        if (title != null)
                          h3(
                            classes:
                                'text-lg font-semibold text-gray-900 dark:text-white',
                            [Component.text(title!)],
                          ),
                        if (description != null)
                          p(
                            classes:
                                'mt-1 text-sm text-gray-500 dark:text-gray-400',
                            [Component.text(description!)],
                          ),
                      ],
                    ),
                    // Close button
                    button(
                      type: ButtonType.button,
                      classes:
                          'ml-4 p-1 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded',
                      attributes: {'data-slideover-close': 'true'},
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
                // Footer
                if (footer != null)
                  div(
                    classes:
                        'p-4 border-t border-gray-200 dark:border-gray-800 bg-gray-50 dark:bg-zinc-800/50',
                    [footer!],
                  ),
              ],
            ),
          ],
        ),
        // Slideover CSS and JavaScript
        RawText('''<style>
dialog[data-slideover-dialog] {
  transition: transform 0.3s ease-out, display 0.3s allow-discrete, overlay 0.3s allow-discrete;
}
dialog[data-slideover-dialog][data-side="right"] {
  transform: translateX(100%);
}
dialog[data-slideover-dialog][data-side="left"] {
  transform: translateX(-100%);
}
dialog[data-slideover-dialog][open] {
  transform: translateX(0);
}
@starting-style {
  dialog[data-slideover-dialog][open] {
    transform: translateX(100%);
  }
  dialog[data-slideover-dialog][open][data-side="left"] {
    transform: translateX(-100%);
  }
  dialog[data-slideover-dialog][open]::backdrop {
    opacity: 0;
  }
}
</style>
<script>
if (!window._slideoverDialogInit) {
  window._slideoverDialogInit = true;

  document.addEventListener('click', function(e) {
    // Open trigger
    var trigger = e.target.closest('[data-slideover-trigger]');
    if (trigger) {
      var slideover = trigger.closest('[data-slideover]');
      var dialog = slideover.querySelector('[data-slideover-dialog]');
      if (dialog) dialog.showModal();
      return;
    }

    // Close button
    var closeBtn = e.target.closest('[data-slideover-close]');
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

/// Controlled slideover for use with @client components
class DSlideoverControlled extends StatelessComponent {
  final bool open;
  final DSlideoverSide side;
  final DSlideoverSize size;
  final String? title;
  final String? description;
  final Component? footer;
  final bool closeOnOverlay;
  final VoidCallback? onClose;
  final List<Component> children;

  const DSlideoverControlled({
    super.key,
    required this.open,
    this.side = DSlideoverSide.right,
    this.size = DSlideoverSize.md,
    this.title,
    this.description,
    this.footer,
    this.closeOnOverlay = true,
    this.onClose,
    this.children = const [],
  });

  String get _sizeClasses {
    switch (size) {
      case DSlideoverSize.sm:
        return 'max-w-sm';
      case DSlideoverSize.md:
        return 'max-w-md';
      case DSlideoverSize.lg:
        return 'max-w-lg';
      case DSlideoverSize.xl:
        return 'max-w-xl';
      case DSlideoverSize.full:
        return 'max-w-full';
    }
  }

  String get _positionClasses {
    switch (side) {
      case DSlideoverSide.left:
        return 'inset-y-0 left-0';
      case DSlideoverSide.right:
        return 'inset-y-0 right-0';
    }
  }

  String get _transformClasses {
    if (!open) {
      switch (side) {
        case DSlideoverSide.left:
          return '-translate-x-full';
        case DSlideoverSide.right:
          return 'translate-x-full';
      }
    }
    return 'translate-x-0';
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
        // Slideover panel
        div(
          classes:
              'fixed $_positionClasses w-full $_sizeClasses h-full bg-white dark:bg-zinc-900 shadow-xl transition-transform duration-300 ease-in-out $_transformClasses flex flex-col',
          [
            // Header
            if (title != null || onClose != null)
              div(
                classes:
                    'flex items-start justify-between p-4 border-b border-gray-200 dark:border-gray-800',
                [
                  div(
                    classes: 'flex-1',
                    [
                      if (title != null)
                        h3(
                          classes:
                              'text-lg font-semibold text-gray-900 dark:text-white',
                          [Component.text(title!)],
                        ),
                      if (description != null)
                        p(
                          classes:
                              'mt-1 text-sm text-gray-500 dark:text-gray-400',
                          [Component.text(description!)],
                        ),
                    ],
                  ),
                  if (onClose != null)
                    button(
                      type: ButtonType.button,
                      onClick: onClose,
                      classes:
                          'ml-4 p-1 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded',
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
            // Footer
            if (footer != null)
              div(
                classes:
                    'p-4 border-t border-gray-200 dark:border-gray-800 bg-gray-50 dark:bg-zinc-800/50',
                [footer!],
              ),
          ],
        ),
      ],
    );
  }
}
