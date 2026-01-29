import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Button variants matching Nuxt UI
enum UButtonVariant { solid, outline, soft, subtle, ghost, link }

/// Button sizes matching Nuxt UI
enum UButtonSize { xs, sm, md, lg, xl }

/// Button colors matching Nuxt UI semantic colors
enum UButtonColor { primary, secondary, success, info, warning, error, neutral }

/// DuxtUI Button component - Nuxt UI compatible
class UButton extends StatelessComponent {
  final String? label;
  final Component? leadingIcon;
  final Component? trailingIcon;
  final UButtonVariant variant;
  final UButtonSize size;
  final UButtonColor color;
  final bool disabled;
  final bool loading;
  final bool block;
  final bool square;
  final VoidCallback? onClick;
  final List<Component> children;

  const UButton({
    super.key,
    this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.variant = UButtonVariant.solid,
    this.size = UButtonSize.md,
    this.color = UButtonColor.primary,
    this.disabled = false,
    this.loading = false,
    this.block = false,
    this.square = false,
    this.onClick,
    this.children = const [],
  });

  // Backward compatibility
  Component? get icon => leadingIcon;

  String get _baseClasses =>
      'rounded-md font-medium inline-flex items-center justify-center disabled:cursor-not-allowed aria-disabled:cursor-not-allowed disabled:opacity-75 aria-disabled:opacity-75 transition-colors focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2';

  String get _sizeClasses {
    if (square) {
      switch (size) {
        case UButtonSize.xs:
          return 'p-1 text-xs';
        case UButtonSize.sm:
          return 'p-1.5 text-xs';
        case UButtonSize.md:
          return 'p-1.5 text-sm';
        case UButtonSize.lg:
          return 'p-2 text-sm';
        case UButtonSize.xl:
          return 'p-2 text-base';
      }
    }
    switch (size) {
      case UButtonSize.xs:
        return 'px-2 py-1 text-xs gap-1';
      case UButtonSize.sm:
        return 'px-2.5 py-1.5 text-xs gap-1.5';
      case UButtonSize.md:
        return 'px-2.5 py-1.5 text-sm gap-1.5';
      case UButtonSize.lg:
        return 'px-3 py-2 text-sm gap-2';
      case UButtonSize.xl:
        return 'px-3 py-2 text-base gap-2';
    }
  }

  String get _iconSizeClasses {
    switch (size) {
      case UButtonSize.xs:
      case UButtonSize.sm:
        return 'size-4';
      case UButtonSize.md:
      case UButtonSize.lg:
        return 'size-5';
      case UButtonSize.xl:
        return 'size-6';
    }
  }

  String get _colorClasses {
    switch (variant) {
      case UButtonVariant.solid:
        return _solidClasses;
      case UButtonVariant.outline:
        return _outlineClasses;
      case UButtonVariant.soft:
        return _softClasses;
      case UButtonVariant.subtle:
        return _subtleClasses;
      case UButtonVariant.ghost:
        return _ghostClasses;
      case UButtonVariant.link:
        return _linkClasses;
    }
  }

  String get _solidClasses {
    switch (color) {
      case UButtonColor.primary:
        return 'bg-green-500 text-white hover:bg-green-600 focus-visible:outline-green-500 dark:bg-green-400 dark:text-gray-900 dark:hover:bg-green-500';
      case UButtonColor.secondary:
        return 'bg-blue-500 text-white hover:bg-blue-600 focus-visible:outline-blue-500 dark:bg-blue-400 dark:text-gray-900 dark:hover:bg-blue-500';
      case UButtonColor.success:
        return 'bg-green-500 text-white hover:bg-green-600 focus-visible:outline-green-500';
      case UButtonColor.info:
        return 'bg-blue-500 text-white hover:bg-blue-600 focus-visible:outline-blue-500';
      case UButtonColor.warning:
        return 'bg-yellow-500 text-white hover:bg-yellow-600 focus-visible:outline-yellow-500';
      case UButtonColor.error:
        return 'bg-red-500 text-white hover:bg-red-600 focus-visible:outline-red-500';
      case UButtonColor.neutral:
        return 'bg-gray-900 text-white hover:bg-gray-800 focus-visible:outline-gray-900 dark:bg-white dark:text-gray-900 dark:hover:bg-gray-100';
    }
  }

  String get _outlineClasses {
    switch (color) {
      case UButtonColor.primary:
        return 'ring ring-inset ring-green-500/50 text-green-500 hover:bg-green-500/10 focus-visible:outline-green-500 dark:ring-green-400/50 dark:text-green-400';
      case UButtonColor.secondary:
        return 'ring ring-inset ring-blue-500/50 text-blue-500 hover:bg-blue-500/10 focus-visible:outline-blue-500';
      case UButtonColor.success:
        return 'ring ring-inset ring-green-500/50 text-green-500 hover:bg-green-500/10 focus-visible:outline-green-500';
      case UButtonColor.info:
        return 'ring ring-inset ring-blue-500/50 text-blue-500 hover:bg-blue-500/10 focus-visible:outline-blue-500';
      case UButtonColor.warning:
        return 'ring ring-inset ring-yellow-500/50 text-yellow-500 hover:bg-yellow-500/10 focus-visible:outline-yellow-500';
      case UButtonColor.error:
        return 'ring ring-inset ring-red-500/50 text-red-500 hover:bg-red-500/10 focus-visible:outline-red-500';
      case UButtonColor.neutral:
        return 'ring ring-inset ring-gray-300 text-gray-700 hover:bg-gray-100 focus-visible:outline-gray-500 dark:ring-gray-700 dark:text-gray-200 dark:hover:bg-gray-800';
    }
  }

  String get _softClasses {
    switch (color) {
      case UButtonColor.primary:
        return 'bg-green-500/10 text-green-500 hover:bg-green-500/20 focus-visible:outline-green-500 dark:bg-green-400/10 dark:text-green-400';
      case UButtonColor.secondary:
        return 'bg-blue-500/10 text-blue-500 hover:bg-blue-500/20 focus-visible:outline-blue-500';
      case UButtonColor.success:
        return 'bg-green-500/10 text-green-500 hover:bg-green-500/20 focus-visible:outline-green-500';
      case UButtonColor.info:
        return 'bg-blue-500/10 text-blue-500 hover:bg-blue-500/20 focus-visible:outline-blue-500';
      case UButtonColor.warning:
        return 'bg-yellow-500/10 text-yellow-500 hover:bg-yellow-500/20 focus-visible:outline-yellow-500';
      case UButtonColor.error:
        return 'bg-red-500/10 text-red-500 hover:bg-red-500/20 focus-visible:outline-red-500';
      case UButtonColor.neutral:
        return 'bg-gray-100 text-gray-700 hover:bg-gray-200 focus-visible:outline-gray-500 dark:bg-gray-800 dark:text-gray-200 dark:hover:bg-gray-700';
    }
  }

  String get _subtleClasses {
    switch (color) {
      case UButtonColor.primary:
        return 'bg-green-500/10 text-green-500 ring ring-inset ring-green-500/25 hover:bg-green-500/20 focus-visible:outline-green-500';
      case UButtonColor.secondary:
        return 'bg-blue-500/10 text-blue-500 ring ring-inset ring-blue-500/25 hover:bg-blue-500/20 focus-visible:outline-blue-500';
      case UButtonColor.success:
        return 'bg-green-500/10 text-green-500 ring ring-inset ring-green-500/25 hover:bg-green-500/20 focus-visible:outline-green-500';
      case UButtonColor.info:
        return 'bg-blue-500/10 text-blue-500 ring ring-inset ring-blue-500/25 hover:bg-blue-500/20 focus-visible:outline-blue-500';
      case UButtonColor.warning:
        return 'bg-yellow-500/10 text-yellow-500 ring ring-inset ring-yellow-500/25 hover:bg-yellow-500/20 focus-visible:outline-yellow-500';
      case UButtonColor.error:
        return 'bg-red-500/10 text-red-500 ring ring-inset ring-red-500/25 hover:bg-red-500/20 focus-visible:outline-red-500';
      case UButtonColor.neutral:
        return 'bg-gray-100 text-gray-700 ring ring-inset ring-gray-300 hover:bg-gray-200 focus-visible:outline-gray-500 dark:bg-gray-800 dark:text-gray-200 dark:ring-gray-700';
    }
  }

  String get _ghostClasses {
    switch (color) {
      case UButtonColor.primary:
        return 'text-green-500 hover:bg-green-500/10 focus-visible:outline-green-500';
      case UButtonColor.secondary:
        return 'text-blue-500 hover:bg-blue-500/10 focus-visible:outline-blue-500';
      case UButtonColor.success:
        return 'text-green-500 hover:bg-green-500/10 focus-visible:outline-green-500';
      case UButtonColor.info:
        return 'text-blue-500 hover:bg-blue-500/10 focus-visible:outline-blue-500';
      case UButtonColor.warning:
        return 'text-yellow-500 hover:bg-yellow-500/10 focus-visible:outline-yellow-500';
      case UButtonColor.error:
        return 'text-red-500 hover:bg-red-500/10 focus-visible:outline-red-500';
      case UButtonColor.neutral:
        return 'text-gray-700 hover:bg-gray-100 focus-visible:outline-gray-500 dark:text-gray-200 dark:hover:bg-gray-800';
    }
  }

  String get _linkClasses {
    switch (color) {
      case UButtonColor.primary:
        return 'text-green-500 hover:underline focus-visible:outline-green-500';
      case UButtonColor.secondary:
        return 'text-blue-500 hover:underline focus-visible:outline-blue-500';
      case UButtonColor.success:
        return 'text-green-500 hover:underline focus-visible:outline-green-500';
      case UButtonColor.info:
        return 'text-blue-500 hover:underline focus-visible:outline-blue-500';
      case UButtonColor.warning:
        return 'text-yellow-500 hover:underline focus-visible:outline-yellow-500';
      case UButtonColor.error:
        return 'text-red-500 hover:underline focus-visible:outline-red-500';
      case UButtonColor.neutral:
        return 'text-gray-700 hover:underline focus-visible:outline-gray-500 dark:text-gray-200';
    }
  }

  @override
  Component build(BuildContext context) {
    final blockClasses = block ? 'w-full justify-center' : '';

    return button(
      type: ButtonType.button,
      disabled: disabled || loading,
      onClick: disabled || loading ? null : onClick,
      classes:
          '$_baseClasses $_sizeClasses $_colorClasses $blockClasses'.trim(),
      [
        if (loading)
          span(
              classes:
                  'animate-spin $_iconSizeClasses border-2 border-current border-t-transparent rounded-full',
              [])
        else if (leadingIcon != null)
          span(classes: 'shrink-0 $_iconSizeClasses', [leadingIcon!]),
        if (label != null) span(classes: 'truncate', [Component.text(label!)]),
        ...children,
        if (trailingIcon != null)
          span(classes: 'shrink-0 $_iconSizeClasses', [trailingIcon!]),
      ],
    );
  }
}

/// Button group for grouping buttons together
class UButtonGroup extends StatelessComponent {
  final List<Component> children;
  final UButtonSize size;
  final String orientation; // 'horizontal' | 'vertical'

  const UButtonGroup({
    super.key,
    required this.children,
    this.size = UButtonSize.md,
    this.orientation = 'horizontal',
  });

  @override
  Component build(BuildContext context) {
    final isVertical = orientation == 'vertical';
    return div(
      classes:
          'inline-flex ${isVertical ? "flex-col" : ""} -space-${isVertical ? "y" : "x"}-px',
      children,
    );
  }
}
