import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Modal sizes matching Nuxt UI
enum DModalSize { xs, sm, md, lg, xl, xxl, xxxl, xxxxl, xxxxxl, full }

/// DuxtUI Modal component - Nuxt UI compatible
class DModal extends StatelessComponent {
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

  const DModal({
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
              'fixed inset-0 bg-gray-900/50 dark:bg-gray-950/75 transition-opacity',
          events: {'click': (_) => _handleOverlayClick()},
          [],
        ),
        // Modal container
        div(
          classes: 'flex min-h-full items-center justify-center p-4',
          [
            div(
              classes:
                  'relative w-full $_sizeClasses bg-white dark:bg-gray-900 rounded-lg shadow-xl ring-1 ring-gray-200 dark:ring-gray-800 flex flex-col',
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
                        'flex-1 p-4 sm:p-6 ${title != null || description != null || header != null ? "pt-0 sm:pt-0" : ""}',
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

/// Slideover (drawer) component
enum DSlideoverSide { left, right, top, bottom }

class DSlideover extends StatelessComponent {
  final bool open;
  final String? title;
  final String? description;
  final Component? header;
  final Component? footer;
  final DSlideoverSide side;
  final bool closeOnOverlay;
  final bool preventClose;
  final VoidCallback? onClose;
  final List<Component> children;

  const DSlideover({
    super.key,
    required this.open,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.side = DSlideoverSide.right,
    this.closeOnOverlay = true,
    this.preventClose = false,
    this.onClose,
    this.children = const [],
  });

  String get _positionClasses {
    switch (side) {
      case DSlideoverSide.left:
        return 'inset-y-0 left-0';
      case DSlideoverSide.right:
        return 'inset-y-0 right-0';
      case DSlideoverSide.top:
        return 'inset-x-0 top-0';
      case DSlideoverSide.bottom:
        return 'inset-x-0 bottom-0';
    }
  }

  String get _sizeClasses {
    switch (side) {
      case DSlideoverSide.left:
      case DSlideoverSide.right:
        return 'w-full max-w-md h-full';
      case DSlideoverSide.top:
      case DSlideoverSide.bottom:
        return 'w-full h-auto max-h-[80vh]';
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
      classes: 'fixed inset-0 z-50 overflow-hidden',
      [
        // Backdrop
        div(
          classes:
              'fixed inset-0 bg-gray-900/50 dark:bg-gray-950/75 transition-opacity',
          events: {'click': (_) => _handleOverlayClick()},
          [],
        ),
        // Panel
        div(
          classes:
              'fixed $_positionClasses $_sizeClasses bg-white dark:bg-gray-900 shadow-xl ring-1 ring-gray-200 dark:ring-gray-800 flex flex-col',
          [
            // Header
            if (title != null ||
                description != null ||
                header != null ||
                onClose != null)
              div(
                classes:
                    'flex items-start justify-between p-4 border-b border-gray-200 dark:border-gray-800',
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
                          'shrink-0 p-2 text-gray-400 hover:text-gray-500 rounded-md hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors',
                      [
                        span(classes: 'text-xl', [Component.text('×')])
                      ],
                    ),
                ],
              ),
            // Body
            div(classes: 'flex-1 overflow-y-auto p-4', children),
            // Footer
            if (footer != null)
              div(
                  classes:
                      'flex items-center justify-end gap-3 p-4 border-t border-gray-200 dark:border-gray-800',
                  [footer!]),
          ],
        ),
      ],
    );
  }
}
