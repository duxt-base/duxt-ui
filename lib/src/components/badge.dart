import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Badge variants
enum UBadgeVariant { solid, soft, outline }

/// Badge colors
enum UBadgeColor { primary, gray, success, warning, error }

/// Badge sizes
enum UBadgeSize { xs, sm, md }

/// DuxtUI Badge component
class UBadge extends StatelessComponent {
  final String label;
  final UBadgeVariant variant;
  final UBadgeColor color;
  final UBadgeSize size;

  const UBadge({
    super.key,
    required this.label,
    this.variant = UBadgeVariant.soft,
    this.color = UBadgeColor.primary,
    this.size = UBadgeSize.sm,
  });

  String get _sizeClasses {
    switch (size) {
      case UBadgeSize.xs:
        return 'px-1.5 py-0.5 text-xs';
      case UBadgeSize.sm:
        return 'px-2 py-0.5 text-xs';
      case UBadgeSize.md:
        return 'px-2.5 py-1 text-sm';
    }
  }

  String get _colorClasses {
    switch (variant) {
      case UBadgeVariant.solid:
        switch (color) {
          case UBadgeColor.primary:
            return 'bg-indigo-600 text-white';
          case UBadgeColor.gray:
            return 'bg-gray-600 text-white';
          case UBadgeColor.success:
            return 'bg-green-600 text-white';
          case UBadgeColor.warning:
            return 'bg-yellow-500 text-white';
          case UBadgeColor.error:
            return 'bg-red-600 text-white';
        }
      case UBadgeVariant.soft:
        switch (color) {
          case UBadgeColor.primary:
            return 'bg-indigo-100 text-indigo-700';
          case UBadgeColor.gray:
            return 'bg-gray-100 text-gray-700';
          case UBadgeColor.success:
            return 'bg-green-100 text-green-700';
          case UBadgeColor.warning:
            return 'bg-yellow-100 text-yellow-700';
          case UBadgeColor.error:
            return 'bg-red-100 text-red-700';
        }
      case UBadgeVariant.outline:
        switch (color) {
          case UBadgeColor.primary:
            return 'border border-indigo-600 text-indigo-600';
          case UBadgeColor.gray:
            return 'border border-gray-400 text-gray-600';
          case UBadgeColor.success:
            return 'border border-green-600 text-green-600';
          case UBadgeColor.warning:
            return 'border border-yellow-500 text-yellow-600';
          case UBadgeColor.error:
            return 'border border-red-600 text-red-600';
        }
    }
  }

  @override
  Component build(BuildContext context) {
    return span(
      classes: 'inline-flex items-center font-medium rounded-full $_sizeClasses $_colorClasses',
      [text(label)],
    );
  }
}
