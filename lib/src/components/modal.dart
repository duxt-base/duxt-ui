import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Modal sizes
enum DModalSize { xs, sm, md, lg, xl, xxl, xxxl, xxxxl, xxxxxl, full }

/// DuxtUI Modal component - uses native HTML dialog element
///
/// Uses inline JavaScript for interactivity.
class DModal extends StatelessComponent {
  final Component trigger;
  final String? title;
  final String? description;
  final Component? header;
  final Component? footer;
  final DModalSize size;
  final bool closeOnOverlay;
  final bool fullscreen;
  final List<Component> children;

  const DModal({
    super.key,
    required this.trigger,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.size = DModalSize.md,
    this.closeOnOverlay = true,
    this.fullscreen = false,
    this.children = const [],
  });

  String get _sizeClasses {
    if (fullscreen)
      return 'w-screen h-screen max-w-none max-h-none m-0 rounded-none';

    switch (size) {
      case DModalSize.xs:
        return 'max-w-xs';
      case DModalSize.sm:
        return 'max-w-sm';
      case DModalSize.md:
        return 'max-w-md';
      case DModalSize.lg:
        return 'max-w-lg';
      case DModalSize.xl:
        return 'max-w-xl';
      case DModalSize.xxl:
        return 'max-w-2xl';
      case DModalSize.xxxl:
        return 'max-w-3xl';
      case DModalSize.xxxxl:
        return 'max-w-4xl';
      case DModalSize.xxxxxl:
        return 'max-w-5xl';
      case DModalSize.full:
        return 'max-w-full';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'inline-block',
      attributes: {'data-modal': 'true'},
      [
        // Trigger
        div(
          attributes: {'data-modal-trigger': 'true'},
          classes: 'cursor-pointer inline-block',
          [trigger],
        ),
        // Dialog element
        Component.element(
          tag: 'dialog',
          classes:
              'm-auto w-full $_sizeClasses bg-white dark:bg-zinc-900 rounded-lg shadow-xl ring-1 ring-gray-200 dark:ring-gray-800 p-0 backdrop:bg-gray-900/50 dark:backdrop:bg-zinc-950/75',
          attributes: {
            'data-modal-dialog': 'true',
            if (closeOnOverlay) 'data-close-on-backdrop': 'true',
          },
          children: [
            div(
              classes: 'flex flex-col',
              [
                // Header
                if (title != null ||
                    description != null ||
                    header != null)
                  div(
                    classes: 'flex items-start justify-between p-4 sm:p-6',
                    [
                      if (header != null)
                        header!
                      else
                        div(classes: 'flex-1 min-w-0', [
                          if (title != null)
                            h3(
                                classes:
                                    'text-base font-semibold text-gray-900 dark:text-white',
                                [Component.text(title!)]),
                          if (description != null)
                            p(
                                classes:
                                    'mt-1 text-sm text-gray-500 dark:text-gray-400',
                                [Component.text(description!)]),
                        ]),
                      // Close button
                      button(
                        type: ButtonType.button,
                        classes:
                            'shrink-0 -my-1 -mx-1 p-2 text-gray-400 hover:text-gray-500 dark:text-gray-500 dark:hover:text-gray-400 rounded-md hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors',
                        attributes: {'data-modal-close': 'true'},
                        [
                          span(
                              classes:
                                  'size-5 flex items-center justify-center text-xl',
                              [Component.text('×')]),
                        ],
                      ),
                    ],
                  ),
                // Body
                div(
                    classes:
                        'flex-1 p-4 sm:p-6 text-gray-700 dark:text-gray-300 ${title != null || description != null || header != null ? "pt-0 sm:pt-0" : ""}',
                    children),
                // Footer
                if (footer != null)
                  div(
                      classes:
                          'flex items-center justify-end gap-3 p-4 sm:px-6 border-t border-gray-200 dark:border-gray-800',
                      [footer!]),
              ],
            ),
          ],
        ),
        // Modal CSS and JavaScript
        RawText('''<style>
dialog[data-modal-dialog] {
  position: fixed;
  inset: 0;
  margin: auto;
}
</style>
<script>
if (!window._modalInit) {
  window._modalInit = true;

  document.addEventListener('click', function(e) {
    // Open trigger
    var trigger = e.target.closest('[data-modal-trigger]');
    if (trigger) {
      var modal = trigger.closest('[data-modal]');
      var dialog = modal.querySelector('[data-modal-dialog]');
      if (dialog) dialog.showModal();
      return;
    }

    // Close button
    var closeBtn = e.target.closest('[data-modal-close]');
    if (closeBtn) {
      var dialog = closeBtn.closest('dialog');
      if (dialog) dialog.close();
      return;
    }

    // Backdrop click (clicking on dialog element itself, not content)
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

/// Controlled modal for use with @client components
class DModalControlled extends StatelessComponent {
  final bool open;
  final String? title;
  final String? description;
  final Component? header;
  final Component? footer;
  final DModalSize size;
  final bool closeOnOverlay;
  final bool closeOnEscape;
  final bool preventClose;
  final bool fullscreen;
  final VoidCallback? onClose;
  final List<Component> children;

  const DModalControlled({
    super.key,
    required this.open,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.size = DModalSize.md,
    this.closeOnOverlay = true,
    this.closeOnEscape = true,
    this.preventClose = false,
    this.fullscreen = false,
    this.onClose,
    this.children = const [],
  });

  String get _sizeClasses {
    if (fullscreen)
      return 'w-screen h-screen max-w-none max-h-none m-0 rounded-none';

    switch (size) {
      case DModalSize.xs:
        return 'max-w-xs';
      case DModalSize.sm:
        return 'max-w-sm';
      case DModalSize.md:
        return 'max-w-md';
      case DModalSize.lg:
        return 'max-w-lg';
      case DModalSize.xl:
        return 'max-w-xl';
      case DModalSize.xxl:
        return 'max-w-2xl';
      case DModalSize.xxxl:
        return 'max-w-3xl';
      case DModalSize.xxxxl:
        return 'max-w-4xl';
      case DModalSize.xxxxxl:
        return 'max-w-5xl';
      case DModalSize.full:
        return 'max-w-full';
    }
  }

  void _handleOverlayClick() {
    if (!preventClose && closeOnOverlay && onClose != null) {
      onClose!();
    }
  }

  @override
  Component build(BuildContext context) {
    if (!open) return div([]);

    return div(
      classes: 'fixed inset-0 z-50 overflow-y-auto',
      [
        // Backdrop
        div(
          classes:
              'fixed inset-0 bg-gray-900/50 dark:bg-zinc-950/75 transition-opacity',
          events: {'click': (_) => _handleOverlayClick()},
          [],
        ),
        // Modal container
        div(
          classes: 'flex min-h-full items-center justify-center p-4',
          [
            div(
              classes:
                  'relative w-full $_sizeClasses bg-white dark:bg-zinc-900 rounded-lg shadow-xl ring-1 ring-gray-200 dark:ring-gray-800 flex flex-col',
              events: {'click': (e) => e.stopPropagation()},
              [
                // Header
                if (title != null ||
                    description != null ||
                    header != null ||
                    onClose != null)
                  div(
                    classes: 'flex items-start justify-between p-4 sm:p-6',
                    [
                      if (header != null)
                        header!
                      else
                        div(classes: 'flex-1 min-w-0', [
                          if (title != null)
                            h3(
                                classes:
                                    'text-base font-semibold text-gray-900 dark:text-white',
                                [Component.text(title!)]),
                          if (description != null)
                            p(
                                classes:
                                    'mt-1 text-sm text-gray-500 dark:text-gray-400',
                                [Component.text(description!)]),
                        ]),
                      if (onClose != null && !preventClose)
                        button(
                          type: ButtonType.button,
                          onClick: onClose,
                          classes:
                              'shrink-0 -my-1 -mx-1 p-2 text-gray-400 hover:text-gray-500 dark:text-gray-500 dark:hover:text-gray-400 rounded-md hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors',
                          [
                            span(
                                classes:
                                    'size-5 flex items-center justify-center text-xl',
                                [Component.text('×')]),
                          ],
                        ),
                    ],
                  ),
                // Body
                div(
                    classes:
                        'flex-1 p-4 sm:p-6 text-gray-700 dark:text-gray-300 ${title != null || description != null || header != null ? "pt-0 sm:pt-0" : ""}',
                    children),
                // Footer
                if (footer != null)
                  div(
                      classes:
                          'flex items-center justify-end gap-3 p-4 sm:px-6 border-t border-gray-200 dark:border-gray-800',
                      [footer!]),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
