import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Scroll orientation
enum UScrollOrientation { vertical, horizontal, both }

/// Scrollbar visibility
enum UScrollbarVisibility { auto, always, hover, never }

/// DuxtUI ScrollArea component - Custom scrollbar styling
///
/// Provides a scrollable container with customized scrollbar appearance.
/// Supports both vertical and horizontal scrolling with thin scrollbars.
class UScrollArea extends StatelessComponent {
  /// Content to be scrolled
  final List<Component> children;

  /// Scroll orientation
  final UScrollOrientation orientation;

  /// Maximum height (for vertical scroll)
  final String? maxHeight;

  /// Maximum width (for horizontal scroll)
  final String? maxWidth;

  /// Scrollbar visibility behavior
  final UScrollbarVisibility scrollbarVisibility;

  /// Custom CSS classes
  final String? classes;

  const UScrollArea({
    super.key,
    required this.children,
    this.orientation = UScrollOrientation.vertical,
    this.maxHeight,
    this.maxWidth,
    this.scrollbarVisibility = UScrollbarVisibility.auto,
    this.classes,
  });

  String get _overflowClasses {
    switch (orientation) {
      case UScrollOrientation.vertical:
        return 'overflow-y-auto overflow-x-hidden';
      case UScrollOrientation.horizontal:
        return 'overflow-x-auto overflow-y-hidden';
      case UScrollOrientation.both:
        return 'overflow-auto';
    }
  }

  String get _scrollbarClasses {
    switch (scrollbarVisibility) {
      case UScrollbarVisibility.auto:
        return 'scrollbar-thin scrollbar-thumb-gray-300 dark:scrollbar-thumb-gray-600 scrollbar-track-transparent';
      case UScrollbarVisibility.always:
        return 'scrollbar-thin scrollbar-thumb-gray-300 dark:scrollbar-thumb-gray-600 scrollbar-track-gray-100 dark:scrollbar-track-gray-800';
      case UScrollbarVisibility.hover:
        return 'scrollbar-thin scrollbar-thumb-transparent hover:scrollbar-thumb-gray-300 dark:hover:scrollbar-thumb-gray-600 scrollbar-track-transparent';
      case UScrollbarVisibility.never:
        return 'scrollbar-none';
    }
  }

  @override
  Component build(BuildContext context) {
    final styles = <String, String>{};
    if (maxHeight != null) {
      styles['max-height'] = maxHeight!;
    }
    if (maxWidth != null) {
      styles['max-width'] = maxWidth!;
    }

    return div(
      classes: [
        _overflowClasses,
        _scrollbarClasses,
        'scroll-smooth',
        if (classes != null) classes!,
      ].join(' '),
      styles: styles.isNotEmpty ? Styles(raw: styles) : null,
      [
        // Style tag for scrollbar CSS (works with Tailwind scrollbar plugin)
        Component.element(
          tag: 'style',
          children: [
            Component.text('''
              .scrollbar-thin::-webkit-scrollbar {
                width: 8px;
                height: 8px;
              }
              .scrollbar-thin::-webkit-scrollbar-track {
                background: transparent;
              }
              .scrollbar-thin::-webkit-scrollbar-thumb {
                background: #d1d5db;
                border-radius: 4px;
              }
              .scrollbar-thin::-webkit-scrollbar-thumb:hover {
                background: #9ca3af;
              }
              .dark .scrollbar-thin::-webkit-scrollbar-thumb {
                background: #4b5563;
              }
              .dark .scrollbar-thin::-webkit-scrollbar-thumb:hover {
                background: #6b7280;
              }
              .scrollbar-none::-webkit-scrollbar {
                display: none;
              }
              .scrollbar-none {
                -ms-overflow-style: none;
                scrollbar-width: none;
              }
            '''),
          ],
        ),
        ...children,
      ],
    );
  }
}
