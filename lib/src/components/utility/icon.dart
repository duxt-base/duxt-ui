import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Icon sizes matching Nuxt UI
enum UIconSize { xs, sm, md, lg, xl }

/// DuxtUI Icon component - Iconify icon wrapper
///
/// Renders inline icons using Iconify icon names.
/// Supports size variants matching Nuxt UI specifications.
class UIcon extends StatelessComponent {
  /// The icon name in Iconify format (e.g., 'heroicons:sun', 'mdi:home')
  final String name;

  /// Size of the icon
  final UIconSize size;

  /// Custom CSS classes to apply
  final String? classes;

  /// Custom color class (e.g., 'text-red-500')
  final String? color;

  const UIcon({
    super.key,
    required this.name,
    this.size = UIconSize.md,
    this.classes,
    this.color,
  });

  String get _sizeClasses {
    switch (size) {
      case UIconSize.xs:
        return 'size-4'; // 16px
      case UIconSize.sm:
        return 'size-5'; // 20px
      case UIconSize.md:
        return 'size-6'; // 24px
      case UIconSize.lg:
        return 'size-8'; // 32px
      case UIconSize.xl:
        return 'size-10'; // 40px
    }
  }

  @override
  Component build(BuildContext context) {
    final iconClasses = [
      'inline-block',
      'flex-shrink-0',
      _sizeClasses,
      if (color != null) color!,
      if (classes != null) classes!,
    ].join(' ');

    // Use Iconify's icon element pattern
    // This relies on Iconify's web component or CSS approach
    return span(
      classes: iconClasses,
      attributes: {
        'data-icon': name,
        'aria-hidden': 'true',
      },
      [
        // Render iconify-icon custom element
        Component.element(
          tag: 'iconify-icon',
          attributes: {
            'icon': name,
            'width': '100%',
            'height': '100%',
          },
        ),
      ],
    );
  }
}

/// Common icon names for convenience
class UIconNames {
  // Navigation
  static const String chevronLeft = 'heroicons:chevron-left';
  static const String chevronRight = 'heroicons:chevron-right';
  static const String chevronUp = 'heroicons:chevron-up';
  static const String chevronDown = 'heroicons:chevron-down';
  static const String arrowLeft = 'heroicons:arrow-left';
  static const String arrowRight = 'heroicons:arrow-right';

  // Actions
  static const String plus = 'heroicons:plus';
  static const String minus = 'heroicons:minus';
  static const String close = 'heroicons:x-mark';
  static const String check = 'heroicons:check';
  static const String edit = 'heroicons:pencil';
  static const String trash = 'heroicons:trash';
  static const String search = 'heroicons:magnifying-glass';

  // Theme
  static const String sun = 'heroicons:sun';
  static const String moon = 'heroicons:moon';
  static const String system = 'heroicons:computer-desktop';

  // Status
  static const String info = 'heroicons:information-circle';
  static const String warning = 'heroicons:exclamation-triangle';
  static const String error = 'heroicons:x-circle';
  static const String success = 'heroicons:check-circle';

  // Misc
  static const String menu = 'heroicons:bars-3';
  static const String home = 'heroicons:home';
  static const String user = 'heroicons:user';
  static const String settings = 'heroicons:cog-6-tooth';
  static const String calendar = 'heroicons:calendar';
}
