import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Badge variants matching Nuxt UI
enum DBadgeVariant { solid, outline, soft, subtle }

/// Badge colors matching Nuxt UI semantic colors
enum DBadgeColor { primary, secondary, success, info, warning, error, neutral }

/// Badge sizes matching Nuxt UI
enum DBadgeSize { xs, sm, md, lg, xl }

/// DuxtUI Badge component - Nuxt UI compatible
class DBadge extends StatelessComponent {
  final String label;
  final Component? leadingIcon;
  final Component? trailingIcon;
  final DBadgeVariant variant;
  final DBadgeColor color;
  final DBadgeSize size;

  const DBadge({
    super.key,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.variant = DBadgeVariant.soft,
    this.color = DBadgeColor.primary,
    this.size = DBadgeSize.md,
  });

  String get _baseClasses => 'font-medium inline-flex items-center';

  String get _sizeClasses {
    switch (size) {
      case DBadgeSize.xs:
        return 'text-[8px]/3 px-1 py-0.5 gap-1 rounded-sm';
      case DBadgeSize.sm:
        return 'text-[10px]/3 px-1.5 py-1 gap-1 rounded-sm';
      case DBadgeSize.md:
        return 'text-xs px-2 py-1 gap-1 rounded-md';
      case DBadgeSize.lg:
        return 'text-sm px-2 py-1.5 gap-1.5 rounded-md';
      case DBadgeSize.xl:
        return 'text-base px-2.5 py-1.5 gap-1.5 rounded-md';
    }
  }

  String get _iconSizeClasses {
    switch (size) {
      case DBadgeSize.xs:
      case DBadgeSize.sm:
        return 'size-3';
      case DBadgeSize.md:
        return 'size-4';
      case DBadgeSize.lg:
      case DBadgeSize.xl:
        return 'size-5';
    }
  }

  String get _variantClasses {
    switch (variant) {
      case DBadgeVariant.solid:
        return _solidClasses;
      case DBadgeVariant.outline:
        return _outlineClasses;
      case DBadgeVariant.soft:
        return _softClasses;
      case DBadgeVariant.subtle:
        return _subtleClasses;
    }
  }

  String get _solidClasses {
    switch (color) {
      case DBadgeColor.primary:
        return 'bg-green-500 text-white dark:bg-green-400 dark:text-gray-900';
      case DBadgeColor.secondary:
        return 'bg-blue-500 text-white';
      case DBadgeColor.success:
        return 'bg-green-500 text-white';
      case DBadgeColor.info:
        return 'bg-blue-500 text-white';
      case DBadgeColor.warning:
        return 'bg-yellow-500 text-white';
      case DBadgeColor.error:
        return 'bg-red-500 text-white';
      case DBadgeColor.neutral:
        return 'bg-gray-900 text-white dark:bg-white dark:text-gray-900';
    }
  }

  String get _outlineClasses {
    switch (color) {
      case DBadgeColor.primary:
        return 'ring ring-inset ring-green-500/50 text-green-500 dark:ring-green-400/50 dark:text-green-400';
      case DBadgeColor.secondary:
        return 'ring ring-inset ring-blue-500/50 text-blue-500';
      case DBadgeColor.success:
        return 'ring ring-inset ring-green-500/50 text-green-500';
      case DBadgeColor.info:
        return 'ring ring-inset ring-blue-500/50 text-blue-500';
      case DBadgeColor.warning:
        return 'ring ring-inset ring-yellow-500/50 text-yellow-500';
      case DBadgeColor.error:
        return 'ring ring-inset ring-red-500/50 text-red-500';
      case DBadgeColor.neutral:
        return 'ring ring-inset ring-gray-300 text-gray-700 bg-white dark:ring-gray-700 dark:text-gray-200 dark:bg-gray-900';
    }
  }

  String get _softClasses {
    switch (color) {
      case DBadgeColor.primary:
        return 'bg-green-500/10 text-green-500 dark:bg-green-400/10 dark:text-green-400';
      case DBadgeColor.secondary:
        return 'bg-blue-500/10 text-blue-500';
      case DBadgeColor.success:
        return 'bg-green-500/10 text-green-500';
      case DBadgeColor.info:
        return 'bg-blue-500/10 text-blue-500';
      case DBadgeColor.warning:
        return 'bg-yellow-500/10 text-yellow-600 dark:text-yellow-400';
      case DBadgeColor.error:
        return 'bg-red-500/10 text-red-500';
      case DBadgeColor.neutral:
        return 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-200';
    }
  }

  String get _subtleClasses {
    switch (color) {
      case DBadgeColor.primary:
        return 'bg-green-500/10 text-green-500 ring ring-inset ring-green-500/25';
      case DBadgeColor.secondary:
        return 'bg-blue-500/10 text-blue-500 ring ring-inset ring-blue-500/25';
      case DBadgeColor.success:
        return 'bg-green-500/10 text-green-500 ring ring-inset ring-green-500/25';
      case DBadgeColor.info:
        return 'bg-blue-500/10 text-blue-500 ring ring-inset ring-blue-500/25';
      case DBadgeColor.warning:
        return 'bg-yellow-500/10 text-yellow-600 ring ring-inset ring-yellow-500/25 dark:text-yellow-400';
      case DBadgeColor.error:
        return 'bg-red-500/10 text-red-500 ring ring-inset ring-red-500/25';
      case DBadgeColor.neutral:
        return 'bg-gray-100 text-gray-700 ring ring-inset ring-gray-300 dark:bg-gray-800 dark:text-gray-200 dark:ring-gray-700';
    }
  }

  @override
  Component build(BuildContext context) {
    return span(
      classes: '$_baseClasses $_sizeClasses $_variantClasses'.trim(),
      [
        if (leadingIcon != null)
          span(classes: 'shrink-0 $_iconSizeClasses', [leadingIcon!]),
        span(classes: 'truncate', [Component.text(label)]),
        if (trailingIcon != null)
          span(classes: 'shrink-0 $_iconSizeClasses', [trailingIcon!]),
      ],
    );
  }
}
