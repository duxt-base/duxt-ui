import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Modal sizes
enum UModalSize { sm, md, lg, xl, full }

/// DuxtUI Modal component
class UModal extends StatelessComponent {
  final bool open;
  final String? title;
  final Component? footer;
  final UModalSize size;
  final bool closeOnOverlay;
  final VoidCallback? onClose;
  final List<Component> children;

  const UModal({
    super.key,
    required this.open,
    this.title,
    this.footer,
    this.size = UModalSize.md,
    this.closeOnOverlay = true,
    this.onClose,
    this.children = const [],
  });

  String get _sizeClasses {
    switch (size) {
      case UModalSize.sm:
        return 'max-w-sm';
      case UModalSize.md:
        return 'max-w-md';
      case UModalSize.lg:
        return 'max-w-lg';
      case UModalSize.xl:
        return 'max-w-xl';
      case UModalSize.full:
        return 'max-w-4xl';
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
          classes: 'fixed inset-0 bg-black/50 transition-opacity',
          events: closeOnOverlay && onClose != null ? {'click': (_) => onClose!()} : {},
          [],
        ),
        // Modal
        div(
          classes: 'flex min-h-full items-center justify-center p-4',
          [
            div(
              classes: 'relative w-full $_sizeClasses bg-white rounded-lg shadow-xl',
              [
                // Header
                if (title != null || onClose != null)
                  div(
                    classes: 'flex items-center justify-between p-4 border-b',
                    [
                      if (title != null)
                        h3(classes: 'text-lg font-semibold text-gray-900', [text(title!)]),
                      if (onClose != null)
                        button(
                          type: ButtonType.button,
                          onClick: onClose,
                          classes: 'p-1 text-gray-400 hover:text-gray-600 rounded',
                          [span(classes: 'text-xl', [text('×')])],
                        ),
                    ],
                  ),
                // Body
                div(classes: 'p-4', children),
                // Footer
                if (footer != null)
                  div(classes: 'p-4 border-t bg-gray-50 rounded-b-lg', [footer!]),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
