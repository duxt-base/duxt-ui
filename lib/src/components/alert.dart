import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Alert variants matching Nuxt UI
enum UAlertVariant { solid, outline, soft, subtle }

/// Alert colors matching Nuxt UI semantic colors
enum UAlertColor { primary, secondary, success, info, warning, error, neutral }

/// DuxtUI Alert component - Nuxt UI compatible
class UAlert extends StatelessComponent {
  final String? title;
  final String? description;
  final UAlertVariant variant;
  final UAlertColor color;
  final Component? icon;
  final Component? avatar;
  final VoidCallback? onClose;
  final List<Component> actions;
  final List<Component> children;

  const UAlert({
    super.key,
    this.title,
    this.description,
    this.variant = UAlertVariant.soft,
    this.color = UAlertColor.primary,
    this.icon,
    this.avatar,
    this.onClose,
    this.actions = const [],
    this.children = const [],
  });

  String get _baseClasses => 'relative overflow-hidden rounded-lg p-4';

  String get _variantClasses {
    switch (variant) {
      case UAlertVariant.solid:
        return _solidClasses;
      case UAlertVariant.outline:
        return _outlineClasses;
      case UAlertVariant.soft:
        return _softClasses;
      case UAlertVariant.subtle:
        return _subtleClasses;
    }
  }

  String get _solidClasses {
    switch (color) {
      case UAlertColor.primary:
        return 'bg-green-500 text-white';
      case UAlertColor.secondary:
        return 'bg-blue-500 text-white';
      case UAlertColor.success:
        return 'bg-green-500 text-white';
      case UAlertColor.info:
        return 'bg-blue-500 text-white';
      case UAlertColor.warning:
        return 'bg-yellow-500 text-white';
      case UAlertColor.error:
        return 'bg-red-500 text-white';
      case UAlertColor.neutral:
        return 'bg-gray-900 text-white dark:bg-white dark:text-gray-900';
    }
  }

  String get _outlineClasses {
    switch (color) {
      case UAlertColor.primary:
        return 'bg-white dark:bg-gray-900 ring ring-inset ring-green-500 text-green-500';
      case UAlertColor.secondary:
        return 'bg-white dark:bg-gray-900 ring ring-inset ring-blue-500 text-blue-500';
      case UAlertColor.success:
        return 'bg-white dark:bg-gray-900 ring ring-inset ring-green-500 text-green-500';
      case UAlertColor.info:
        return 'bg-white dark:bg-gray-900 ring ring-inset ring-blue-500 text-blue-500';
      case UAlertColor.warning:
        return 'bg-white dark:bg-gray-900 ring ring-inset ring-yellow-500 text-yellow-600';
      case UAlertColor.error:
        return 'bg-white dark:bg-gray-900 ring ring-inset ring-red-500 text-red-500';
      case UAlertColor.neutral:
        return 'bg-white dark:bg-gray-900 ring ring-inset ring-gray-300 dark:ring-gray-700 text-gray-700 dark:text-gray-200';
    }
  }

  String get _softClasses {
    switch (color) {
      case UAlertColor.primary:
        return 'bg-green-50 text-green-700 dark:bg-green-950 dark:text-green-300';
      case UAlertColor.secondary:
        return 'bg-blue-50 text-blue-700 dark:bg-blue-950 dark:text-blue-300';
      case UAlertColor.success:
        return 'bg-green-50 text-green-700 dark:bg-green-950 dark:text-green-300';
      case UAlertColor.info:
        return 'bg-blue-50 text-blue-700 dark:bg-blue-950 dark:text-blue-300';
      case UAlertColor.warning:
        return 'bg-yellow-50 text-yellow-700 dark:bg-yellow-950 dark:text-yellow-300';
      case UAlertColor.error:
        return 'bg-red-50 text-red-700 dark:bg-red-950 dark:text-red-300';
      case UAlertColor.neutral:
        return 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-200';
    }
  }

  String get _subtleClasses {
    switch (color) {
      case UAlertColor.primary:
        return 'bg-green-50 ring ring-inset ring-green-200 text-green-700 dark:bg-green-950 dark:ring-green-800 dark:text-green-300';
      case UAlertColor.secondary:
        return 'bg-blue-50 ring ring-inset ring-blue-200 text-blue-700 dark:bg-blue-950 dark:ring-blue-800 dark:text-blue-300';
      case UAlertColor.success:
        return 'bg-green-50 ring ring-inset ring-green-200 text-green-700 dark:bg-green-950 dark:ring-green-800 dark:text-green-300';
      case UAlertColor.info:
        return 'bg-blue-50 ring ring-inset ring-blue-200 text-blue-700 dark:bg-blue-950 dark:ring-blue-800 dark:text-blue-300';
      case UAlertColor.warning:
        return 'bg-yellow-50 ring ring-inset ring-yellow-200 text-yellow-700 dark:bg-yellow-950 dark:ring-yellow-800 dark:text-yellow-300';
      case UAlertColor.error:
        return 'bg-red-50 ring ring-inset ring-red-200 text-red-700 dark:bg-red-950 dark:ring-red-800 dark:text-red-300';
      case UAlertColor.neutral:
        return 'bg-gray-100 ring ring-inset ring-gray-300 text-gray-700 dark:bg-gray-800 dark:ring-gray-700 dark:text-gray-200';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: '$_baseClasses $_variantClasses',
      [
        div(classes: 'flex gap-3', [
          if (icon != null) div(classes: 'shrink-0 size-5', [icon!]),
          if (avatar != null) div(classes: 'shrink-0', [avatar!]),
          div(classes: 'flex-1 min-w-0', [
            if (title != null)
              h3(classes: 'text-sm font-medium', [Component.text(title!)]),
            if (description != null)
              p(
                  classes: 'text-sm mt-1 opacity-90',
                  [Component.text(description!)]),
            ...children,
            if (actions.isNotEmpty)
              div(classes: 'flex items-center gap-2 mt-3', actions),
          ]),
          if (onClose != null)
            button(
              type: ButtonType.button,
              onClick: onClose,
              classes:
                  'shrink-0 -my-1 -mx-1 p-1 rounded-md hover:bg-black/5 dark:hover:bg-white/5 transition-colors',
              [
                span(
                    classes: 'size-5 flex items-center justify-center',
                    [Component.text('×')]),
              ],
            ),
        ]),
      ],
    );
  }
}
