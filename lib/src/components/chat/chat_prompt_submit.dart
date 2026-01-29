import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../spinner.dart';

/// Submit button size
enum UChatPromptSubmitSize { sm, md, lg }

/// DuxtUI ChatPromptSubmit component - send button for chat prompt
class UChatPromptSubmit extends StatelessComponent {
  final bool disabled;
  final bool loading;
  final UChatPromptSubmitSize size;
  final String? tooltip;
  final VoidCallback? onSubmit;
  final Component? icon;
  final String? bgColor;

  const UChatPromptSubmit({
    super.key,
    this.disabled = false,
    this.loading = false,
    this.size = UChatPromptSubmitSize.md,
    this.tooltip,
    this.onSubmit,
    this.icon,
    this.bgColor,
  });

  String get _sizeClasses {
    switch (size) {
      case UChatPromptSubmitSize.sm:
        return 'p-1.5';
      case UChatPromptSubmitSize.md:
        return 'p-2';
      case UChatPromptSubmitSize.lg:
        return 'p-3';
    }
  }

  String get _iconSize {
    switch (size) {
      case UChatPromptSubmitSize.sm:
        return 'w-4 h-4';
      case UChatPromptSubmitSize.md:
        return 'w-5 h-5';
      case UChatPromptSubmitSize.lg:
        return 'w-6 h-6';
    }
  }

  USpinnerSize get _spinnerSize {
    switch (size) {
      case UChatPromptSubmitSize.sm:
        return USpinnerSize.xs;
      case UChatPromptSubmitSize.md:
        return USpinnerSize.sm;
      case UChatPromptSubmitSize.lg:
        return USpinnerSize.md;
    }
  }

  @override
  Component build(BuildContext context) {
    final isDisabled = disabled || loading;
    final colorClasses = bgColor ?? 'bg-indigo-600 hover:bg-indigo-700';

    // Default send icon (arrow up)
    final defaultIcon = svg(
      classes: _iconSize,
      attributes: {
        'viewBox': '0 0 24 24',
        'fill': 'none',
        'stroke': 'currentColor',
        'stroke-width': '2',
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
      },
      [
        // Arrow up path
        RawText('<path d="M12 19V5M5 12l7-7 7 7"/>'),
      ],
    );

    return button(
      type: ButtonType.button,
      disabled: isDisabled,
      onClick: isDisabled ? null : onSubmit,
      classes: '$_sizeClasses rounded-lg $colorClasses text-white transition-colors focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed',
      attributes: {
        if (tooltip != null) 'title': tooltip!,
        'aria-label': tooltip ?? 'Send message',
      },
      [
        if (loading)
          USpinner(size: _spinnerSize, color: 'border-white')
        else
          icon ?? defaultIcon,
      ],
    );
  }
}
