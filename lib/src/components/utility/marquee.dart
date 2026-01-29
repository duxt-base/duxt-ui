import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Marquee direction
enum UMarqueeDirection { left, right }

/// DuxtUI Marquee component - Scrolling content animation
///
/// Creates a smooth scrolling animation for content.
/// Content is duplicated to create seamless infinite scroll effect.
class UMarquee extends StatelessComponent {
  /// Content to scroll
  final List<Component> children;

  /// Scroll direction
  final UMarqueeDirection direction;

  /// Animation duration in seconds
  final int duration;

  /// Whether to pause on hover
  final bool pauseOnHover;

  /// Gap between repeated content
  final String gap;

  /// Custom CSS classes
  final String? classes;

  const UMarquee({
    super.key,
    required this.children,
    this.direction = UMarqueeDirection.left,
    this.duration = 20,
    this.pauseOnHover = true,
    this.gap = 'gap-8',
    this.classes,
  });

  String get _animationName {
    return direction == UMarqueeDirection.left
        ? 'marquee-left'
        : 'marquee-right';
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'flex overflow-hidden ${classes ?? ""}',
      [
        // Style tag for keyframes animation
        Component.element(
          tag: 'style',
          children: [
            Component.text('''
              @keyframes marquee-left {
                from { transform: translateX(0); }
                to { transform: translateX(-50%); }
              }
              @keyframes marquee-right {
                from { transform: translateX(-50%); }
                to { transform: translateX(0); }
              }
              .animate-marquee {
                animation: $_animationName ${duration}s linear infinite;
              }
              .animate-marquee:hover {
                ${pauseOnHover ? 'animation-play-state: paused;' : ''}
              }
            '''),
          ],
        ),
        // Animated container with duplicated content
        div(
          classes:
              'flex shrink-0 $gap animate-marquee ${pauseOnHover ? "hover:pause" : ""}',
          styles: Styles(raw: {
            'animation': '$_animationName ${duration}s linear infinite',
          }),
          [
            // First copy
            div(classes: 'flex shrink-0 $gap', children),
            // Second copy for seamless loop
            div(classes: 'flex shrink-0 $gap', children),
          ],
        ),
      ],
    );
  }
}

/// Helper component for marquee items
class UMarqueeItem extends StatelessComponent {
  final Component child;
  final String? classes;

  const UMarqueeItem({
    super.key,
    required this.child,
    this.classes,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'flex-shrink-0 ${classes ?? ""}',
      [child],
    );
  }
}
