import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'icon.dart';

/// Carousel item data
class UCarouselItem {
  final String? image;
  final String? alt;
  final Component? content;

  const UCarouselItem({
    this.image,
    this.alt,
    this.content,
  });
}

/// DuxtUI Carousel component - CSS-only image carousel
///
/// A responsive carousel with prev/next navigation and dot indicators.
/// Uses CSS scroll-snap for smooth scrolling behavior.
class UCarousel extends StatefulComponent {
  /// List of items to display
  final List<UCarouselItem> items;

  /// Whether to show navigation arrows
  final bool showArrows;

  /// Whether to show dot indicators
  final bool showDots;

  /// Whether to auto-play
  final bool autoPlay;

  /// Auto-play interval in milliseconds
  final int autoPlayInterval;

  /// Custom CSS classes
  final String? classes;

  const UCarousel({
    super.key,
    required this.items,
    this.showArrows = true,
    this.showDots = true,
    this.autoPlay = false,
    this.autoPlayInterval = 5000,
    this.classes,
  });

  @override
  State createState() => _UCarouselState();
}

class _UCarouselState extends State<UCarousel> {
  int _currentIndex = 0;

  void _goTo(int index) {
    setState(() {
      _currentIndex = index.clamp(0, component.items.length - 1);
    });
  }

  void _goToPrevious() {
    _goTo(_currentIndex - 1);
  }

  void _goToNext() {
    _goTo(_currentIndex + 1);
  }

  @override
  Component build(BuildContext context) {
    final items = component.items;
    if (items.isEmpty) {
      return div(classes: 'relative', []);
    }

    return div(
      classes: 'relative overflow-hidden group ${component.classes ?? ""}',
      [
        // Slides container
        div(
          classes: 'flex transition-transform duration-300 ease-in-out',
          styles: Styles(raw: {'transform': 'translateX(-${_currentIndex * 100}%)'}),
          [
            for (var i = 0; i < items.length; i++)
              div(
                classes: 'w-full flex-shrink-0',
                [
                  if (items[i].image != null)
                    img(
                      src: items[i].image!,
                      alt: items[i].alt ?? 'Slide ${i + 1}',
                      classes: 'w-full h-full object-cover',
                    )
                  else if (items[i].content != null)
                    items[i].content!,
                ],
              ),
          ],
        ),

        // Previous button
        if (component.showArrows && items.length > 1)
          button(
            type: ButtonType.button,
            onClick: _currentIndex > 0 ? _goToPrevious : null,
            classes: 'absolute left-2 top-1/2 -translate-y-1/2 p-2 rounded-full bg-white/80 dark:bg-gray-800/80 shadow-lg opacity-0 group-hover:opacity-100 transition-opacity disabled:opacity-30 disabled:cursor-not-allowed hover:bg-white dark:hover:bg-gray-800',
            attributes: {'aria-label': 'Previous slide'},
            [
              UIcon(name: UIconNames.chevronLeft, size: UIconSize.sm),
            ],
          ),

        // Next button
        if (component.showArrows && items.length > 1)
          button(
            type: ButtonType.button,
            onClick: _currentIndex < items.length - 1 ? _goToNext : null,
            classes: 'absolute right-2 top-1/2 -translate-y-1/2 p-2 rounded-full bg-white/80 dark:bg-gray-800/80 shadow-lg opacity-0 group-hover:opacity-100 transition-opacity disabled:opacity-30 disabled:cursor-not-allowed hover:bg-white dark:hover:bg-gray-800',
            attributes: {'aria-label': 'Next slide'},
            [
              UIcon(name: UIconNames.chevronRight, size: UIconSize.sm),
            ],
          ),

        // Dot indicators
        if (component.showDots && items.length > 1)
          div(
            classes: 'absolute bottom-4 left-1/2 -translate-x-1/2 flex gap-2',
            [
              for (var i = 0; i < items.length; i++)
                button(
                  type: ButtonType.button,
                  onClick: () => _goTo(i),
                  classes: 'w-2 h-2 rounded-full transition-colors ${i == _currentIndex ? "bg-white" : "bg-white/50 hover:bg-white/75"}',
                  attributes: {'aria-label': 'Go to slide ${i + 1}'},
                  [],
                ),
            ],
          ),
      ],
    );
  }
}
