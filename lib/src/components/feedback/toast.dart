import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../../theme/variants.dart';

/// Toast color variants
enum UToastColor { primary, secondary, success, info, warning, error }

/// Toast variant styles
enum UToastVariant { solid, outline, soft, subtle }

/// DuxtUI Toast component - Notification message
class UToast extends StatelessComponent {
  final String? title;
  final String? description;
  final UToastColor color;
  final UToastVariant variant;
  final Component? icon;
  final Component? action;
  final bool closable;
  final VoidCallback? onClose;
  final String? id;

  const UToast({
    super.key,
    this.title,
    this.description,
    this.color = UToastColor.primary,
    this.variant = UToastVariant.solid,
    this.icon,
    this.action,
    this.closable = true,
    this.onClose,
    this.id,
  });

  String get _colorName {
    switch (color) {
      case UToastColor.primary:
        return 'green';
      case UToastColor.secondary:
        return 'blue';
      case UToastColor.success:
        return 'green';
      case UToastColor.info:
        return 'blue';
      case UToastColor.warning:
        return 'yellow';
      case UToastColor.error:
        return 'red';
    }
  }

  String get _variantClasses {
    final c = _colorName;
    switch (variant) {
      case UToastVariant.solid:
        return 'bg-$c-500 text-white';
      case UToastVariant.outline:
        return 'bg-white dark:bg-gray-900 ring-1 ring-inset ring-$c-500 text-$c-600 dark:text-$c-400';
      case UToastVariant.soft:
        return 'bg-$c-50 dark:bg-$c-950 text-$c-700 dark:text-$c-300';
      case UToastVariant.subtle:
        return 'bg-$c-50 dark:bg-$c-950 ring-1 ring-inset ring-$c-200 dark:ring-$c-800 text-$c-700 dark:text-$c-300';
    }
  }

  String get _closeButtonClasses {
    switch (variant) {
      case UToastVariant.solid:
        return 'text-white/80 hover:text-white';
      case UToastVariant.outline:
      case UToastVariant.soft:
      case UToastVariant.subtle:
        return 'text-gray-400 hover:text-gray-600 dark:hover:text-gray-300';
    }
  }

  String get _defaultIcon {
    switch (color) {
      case UToastColor.success:
        return '\u2714'; // Check mark
      case UToastColor.error:
        return '\u2716'; // Cross mark
      case UToastColor.warning:
        return '\u26A0'; // Warning
      case UToastColor.info:
        return '\u2139'; // Info
      default:
        return '\u{1F514}'; // Bell
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      id: id,
      classes: cx([
        'flex items-start gap-3',
        'p-4',
        'rounded-lg',
        'shadow-lg',
        'min-w-[300px] max-w-md',
        _variantClasses,
      ]),
      [
        // Icon
        if (icon != null)
          div(classes: 'flex-shrink-0 text-lg', [icon!])
        else
          div(classes: 'flex-shrink-0 text-lg', [Component.text(_defaultIcon)]),
        // Content
        div(
          classes: 'flex-1 min-w-0',
          [
            if (title != null)
              p(
                classes: 'text-sm font-semibold',
                [Component.text(title!)],
              ),
            if (description != null)
              p(
                classes: cx([
                  'text-sm',
                  title != null ? 'mt-1 opacity-90' : null,
                ]),
                [Component.text(description!)],
              ),
          ],
        ),
        // Action
        if (action != null) div(classes: 'flex-shrink-0', [action!]),
        // Close button
        if (closable && onClose != null)
          button(
            type: ButtonType.button,
            onClick: onClose,
            classes: cx([
              'flex-shrink-0',
              'p-1 -m-1',
              'rounded',
              'transition-colors',
              _closeButtonClasses,
            ]),
            [
              span(classes: 'text-lg leading-none', [Component.text('\u00D7')])
            ], // Times symbol
          ),
      ],
    );
  }
}

/// Toast data model for programmatic toasts
class ToastData {
  final String id;
  final String? title;
  final String? description;
  final UToastColor color;
  final UToastVariant variant;
  final int duration;
  final bool closable;

  const ToastData({
    required this.id,
    this.title,
    this.description,
    this.color = UToastColor.primary,
    this.variant = UToastVariant.solid,
    this.duration = 5000,
    this.closable = true,
  });

  /// Create a success toast
  factory ToastData.success({
    required String id,
    String? title,
    String? description,
    int duration = 5000,
  }) {
    return ToastData(
      id: id,
      title: title ?? 'Success',
      description: description,
      color: UToastColor.success,
      duration: duration,
    );
  }

  /// Create an error toast
  factory ToastData.error({
    required String id,
    String? title,
    String? description,
    int duration = 5000,
  }) {
    return ToastData(
      id: id,
      title: title ?? 'Error',
      description: description,
      color: UToastColor.error,
      duration: duration,
    );
  }

  /// Create a warning toast
  factory ToastData.warning({
    required String id,
    String? title,
    String? description,
    int duration = 5000,
  }) {
    return ToastData(
      id: id,
      title: title ?? 'Warning',
      description: description,
      color: UToastColor.warning,
      duration: duration,
    );
  }

  /// Create an info toast
  factory ToastData.info({
    required String id,
    String? title,
    String? description,
    int duration = 5000,
  }) {
    return ToastData(
      id: id,
      title: title ?? 'Info',
      description: description,
      color: UToastColor.info,
      duration: duration,
    );
  }
}
