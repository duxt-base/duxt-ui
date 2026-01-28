import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Button variants
enum UButtonVariant { solid, outline, ghost, soft, link }

/// Button sizes
enum UButtonSize { xs, sm, md, lg, xl }

/// Button colors
enum UButtonColor { primary, gray, success, warning, error }

/// DuxtUI Button component
class UButton extends StatelessComponent {
  final String? label;
  final Component? icon;
  final Component? trailingIcon;
  final UButtonVariant variant;
  final UButtonSize size;
  final UButtonColor color;
  final bool disabled;
  final bool loading;
  final bool block;
  final VoidCallback? onClick;
  final List<Component> children;

  const UButton({
    super.key,
    this.label,
    this.icon,
    this.trailingIcon,
    this.variant = UButtonVariant.solid,
    this.size = UButtonSize.md,
    this.color = UButtonColor.primary,
    this.disabled = false,
    this.loading = false,
    this.block = false,
    this.onClick,
    this.children = const [],
  });

  String get _sizeClasses {
    switch (size) {
      case UButtonSize.xs:
        return 'px-2 py-1 text-xs';
      case UButtonSize.sm:
        return 'px-2.5 py-1.5 text-sm';
      case UButtonSize.md:
        return 'px-3 py-2 text-sm';
      case UButtonSize.lg:
        return 'px-4 py-2.5 text-base';
      case UButtonSize.xl:
        return 'px-5 py-3 text-base';
    }
  }

  String get _colorClasses {
    final c = color;
    switch (variant) {
      case UButtonVariant.solid:
        switch (c) {
          case UButtonColor.primary:
            return 'bg-indigo-600 text-white hover:bg-indigo-700 focus:ring-indigo-500';
          case UButtonColor.gray:
            return 'bg-gray-600 text-white hover:bg-gray-700 focus:ring-gray-500';
          case UButtonColor.success:
            return 'bg-green-600 text-white hover:bg-green-700 focus:ring-green-500';
          case UButtonColor.warning:
            return 'bg-yellow-500 text-white hover:bg-yellow-600 focus:ring-yellow-500';
          case UButtonColor.error:
            return 'bg-red-600 text-white hover:bg-red-700 focus:ring-red-500';
        }
      case UButtonVariant.outline:
        switch (c) {
          case UButtonColor.primary:
            return 'border border-indigo-600 text-indigo-600 hover:bg-indigo-50 focus:ring-indigo-500';
          case UButtonColor.gray:
            return 'border border-gray-300 text-gray-700 hover:bg-gray-50 focus:ring-gray-500';
          case UButtonColor.success:
            return 'border border-green-600 text-green-600 hover:bg-green-50 focus:ring-green-500';
          case UButtonColor.warning:
            return 'border border-yellow-500 text-yellow-600 hover:bg-yellow-50 focus:ring-yellow-500';
          case UButtonColor.error:
            return 'border border-red-600 text-red-600 hover:bg-red-50 focus:ring-red-500';
        }
      case UButtonVariant.ghost:
        switch (c) {
          case UButtonColor.primary:
            return 'text-indigo-600 hover:bg-indigo-50 focus:ring-indigo-500';
          case UButtonColor.gray:
            return 'text-gray-700 hover:bg-gray-100 focus:ring-gray-500';
          case UButtonColor.success:
            return 'text-green-600 hover:bg-green-50 focus:ring-green-500';
          case UButtonColor.warning:
            return 'text-yellow-600 hover:bg-yellow-50 focus:ring-yellow-500';
          case UButtonColor.error:
            return 'text-red-600 hover:bg-red-50 focus:ring-red-500';
        }
      case UButtonVariant.soft:
        switch (c) {
          case UButtonColor.primary:
            return 'bg-indigo-50 text-indigo-600 hover:bg-indigo-100 focus:ring-indigo-500';
          case UButtonColor.gray:
            return 'bg-gray-100 text-gray-700 hover:bg-gray-200 focus:ring-gray-500';
          case UButtonColor.success:
            return 'bg-green-50 text-green-600 hover:bg-green-100 focus:ring-green-500';
          case UButtonColor.warning:
            return 'bg-yellow-50 text-yellow-600 hover:bg-yellow-100 focus:ring-yellow-500';
          case UButtonColor.error:
            return 'bg-red-50 text-red-600 hover:bg-red-100 focus:ring-red-500';
        }
      case UButtonVariant.link:
        switch (c) {
          case UButtonColor.primary:
            return 'text-indigo-600 hover:underline';
          case UButtonColor.gray:
            return 'text-gray-600 hover:underline';
          case UButtonColor.success:
            return 'text-green-600 hover:underline';
          case UButtonColor.warning:
            return 'text-yellow-600 hover:underline';
          case UButtonColor.error:
            return 'text-red-600 hover:underline';
        }
    }
  }

  @override
  Component build(BuildContext context) {
    final baseClasses = 'inline-flex items-center justify-center gap-2 font-medium rounded-lg focus:outline-none focus:ring-2 focus:ring-offset-2 transition-colors';
    final disabledClasses = disabled || loading ? 'opacity-50 cursor-not-allowed' : '';
    final blockClasses = block ? 'w-full' : '';

    return button(
      type: ButtonType.button,
      disabled: disabled || loading,
      onClick: disabled || loading ? null : onClick,
      classes: '$baseClasses $_sizeClasses $_colorClasses $disabledClasses $blockClasses',
      [
        if (loading)
          span(classes: 'animate-spin h-4 w-4 border-2 border-current border-t-transparent rounded-full', [])
        else if (icon != null)
          icon!,
        if (label != null) text(label!),
        ...children,
        if (trailingIcon != null) trailingIcon!,
      ],
    );
  }
}
