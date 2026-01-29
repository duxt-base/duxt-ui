import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Input sizes matching Nuxt UI
enum UInputSize { xs, sm, md, lg, xl }

/// Input variants matching Nuxt UI
enum UInputVariant { outline, soft, subtle, ghost, none }

/// Input colors matching Nuxt UI
enum UInputColor { primary, secondary, success, info, warning, error, neutral }

/// DuxtUI Input component - Nuxt UI compatible
class UInput extends StatelessComponent {
  final String? label;
  final String? placeholder;
  final String? name;
  final String? value;
  final String? hint;
  final String? error;
  final UInputSize size;
  final UInputVariant variant;
  final UInputColor? highlightColor;
  final bool disabled;
  final bool required;
  final bool readonly;
  final bool loading;
  final InputType type;
  final Component? leadingIcon;
  final Component? trailingIcon;
  final ValueChanged<String>? onInput;

  const UInput({
    super.key,
    this.label,
    this.placeholder,
    this.name,
    this.value,
    this.hint,
    this.error,
    this.size = UInputSize.md,
    this.variant = UInputVariant.outline,
    this.highlightColor,
    this.disabled = false,
    this.required = false,
    this.readonly = false,
    this.loading = false,
    this.type = InputType.text,
    this.leadingIcon,
    this.trailingIcon,
    this.onInput,
  });

  String get _baseClasses =>
      'w-full rounded-md border-0 appearance-none placeholder:text-gray-400 dark:placeholder:text-gray-500 focus:outline-none disabled:cursor-not-allowed disabled:opacity-75 transition-colors';

  String get _sizeClasses {
    switch (size) {
      case UInputSize.xs:
        return 'px-2 py-1 text-xs';
      case UInputSize.sm:
        return 'px-2.5 py-1.5 text-xs';
      case UInputSize.md:
        return 'px-2.5 py-1.5 text-sm';
      case UInputSize.lg:
        return 'px-3 py-2 text-sm';
      case UInputSize.xl:
        return 'px-3 py-2 text-base';
    }
  }

  String get _iconSizeClasses {
    switch (size) {
      case UInputSize.xs:
      case UInputSize.sm:
        return 'size-4';
      case UInputSize.md:
      case UInputSize.lg:
        return 'size-5';
      case UInputSize.xl:
        return 'size-6';
    }
  }

  String get _leadingPadding {
    switch (size) {
      case UInputSize.xs:
        return 'ps-7';
      case UInputSize.sm:
        return 'ps-8';
      case UInputSize.md:
      case UInputSize.lg:
        return 'ps-9';
      case UInputSize.xl:
        return 'ps-10';
    }
  }

  String get _trailingPadding {
    switch (size) {
      case UInputSize.xs:
        return 'pe-7';
      case UInputSize.sm:
        return 'pe-8';
      case UInputSize.md:
      case UInputSize.lg:
        return 'pe-9';
      case UInputSize.xl:
        return 'pe-10';
    }
  }

  String get _variantClasses {
    final hasError = error != null && error!.isNotEmpty;
    if (hasError) {
      return 'text-gray-900 dark:text-white bg-white dark:bg-gray-900 ring ring-inset ring-red-500';
    }

    switch (variant) {
      case UInputVariant.outline:
        return 'text-gray-900 dark:text-white bg-white dark:bg-gray-900 ring ring-inset ring-gray-300 dark:ring-gray-700 focus:ring-2 focus:ring-green-500 dark:focus:ring-green-400';
      case UInputVariant.soft:
        return 'text-gray-900 dark:text-white bg-gray-50/50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 focus:bg-gray-100 dark:focus:bg-gray-800';
      case UInputVariant.subtle:
        return 'text-gray-900 dark:text-white bg-gray-50 dark:bg-gray-800 ring ring-inset ring-gray-300 dark:ring-gray-700 focus:ring-2 focus:ring-green-500';
      case UInputVariant.ghost:
        return 'text-gray-900 dark:text-white bg-transparent hover:bg-gray-50 dark:hover:bg-gray-800 focus:bg-gray-50 dark:focus:bg-gray-800';
      case UInputVariant.none:
        return 'text-gray-900 dark:text-white bg-transparent';
    }
  }

  @override
  Component build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;
    final hasLeading = leadingIcon != null;
    final hasTrailing = trailingIcon != null || loading;

    return div(classes: 'space-y-1.5', [
      if (label != null)
        span(
            classes:
                'block text-sm font-medium text-gray-700 dark:text-gray-200',
            [
              Component.text(label!),
              if (required)
                span(classes: 'text-red-500 ml-0.5', [Component.text('*')]),
            ]),
      div(classes: 'relative', [
        if (hasLeading)
          div(
            classes:
                'absolute inset-y-0 start-0 flex items-center ps-2.5 pointer-events-none text-gray-400 dark:text-gray-500',
            [
              span(classes: '$_iconSizeClasses', [leadingIcon!])
            ],
          ),
        input(
          type: type,
          name: name,
          value: value,
          disabled: disabled || loading,
          onInput: onInput,
          classes:
              '$_baseClasses $_sizeClasses $_variantClasses ${hasLeading ? _leadingPadding : ""} ${hasTrailing ? _trailingPadding : ""}'
                  .trim(),
          attributes: {
            if (placeholder != null) 'placeholder': placeholder!,
            if (readonly) 'readonly': 'true',
          },
        ),
        if (hasTrailing)
          div(
            classes:
                'absolute inset-y-0 end-0 flex items-center pe-2.5 pointer-events-none text-gray-400 dark:text-gray-500',
            [
              if (loading)
                span(
                    classes:
                        '$_iconSizeClasses animate-spin border-2 border-current border-t-transparent rounded-full',
                    [])
              else if (trailingIcon != null)
                span(classes: '$_iconSizeClasses', [trailingIcon!]),
            ],
          ),
      ]),
      if (hasError)
        p(classes: 'text-sm text-red-500', [Component.text(error!)])
      else if (hint != null)
        p(
            classes: 'text-sm text-gray-500 dark:text-gray-400',
            [Component.text(hint!)]),
    ]);
  }
}

/// DuxtUI Textarea component - Nuxt UI compatible
class UTextarea extends StatelessComponent {
  final String? label;
  final String? placeholder;
  final String? name;
  final String? value;
  final String? hint;
  final String? error;
  final int rows;
  final UInputSize size;
  final UInputVariant variant;
  final bool disabled;
  final bool required;
  final bool autoresize;
  final ValueChanged<String>? onInput;

  const UTextarea({
    super.key,
    this.label,
    this.placeholder,
    this.name,
    this.value,
    this.hint,
    this.error,
    this.rows = 3,
    this.size = UInputSize.md,
    this.variant = UInputVariant.outline,
    this.disabled = false,
    this.required = false,
    this.autoresize = false,
    this.onInput,
  });

  String get _baseClasses =>
      'w-full rounded-md border-0 appearance-none placeholder:text-gray-400 dark:placeholder:text-gray-500 focus:outline-none disabled:cursor-not-allowed disabled:opacity-75 transition-colors resize-none';

  String get _sizeClasses {
    switch (size) {
      case UInputSize.xs:
        return 'px-2 py-1 text-xs';
      case UInputSize.sm:
        return 'px-2.5 py-1.5 text-xs';
      case UInputSize.md:
        return 'px-2.5 py-1.5 text-sm';
      case UInputSize.lg:
        return 'px-3 py-2 text-sm';
      case UInputSize.xl:
        return 'px-3 py-2 text-base';
    }
  }

  String get _variantClasses {
    final hasError = error != null && error!.isNotEmpty;
    if (hasError) {
      return 'text-gray-900 dark:text-white bg-white dark:bg-gray-900 ring ring-inset ring-red-500';
    }

    switch (variant) {
      case UInputVariant.outline:
        return 'text-gray-900 dark:text-white bg-white dark:bg-gray-900 ring ring-inset ring-gray-300 dark:ring-gray-700 focus:ring-2 focus:ring-green-500 dark:focus:ring-green-400';
      case UInputVariant.soft:
        return 'text-gray-900 dark:text-white bg-gray-50/50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 focus:bg-gray-100 dark:focus:bg-gray-800';
      case UInputVariant.subtle:
        return 'text-gray-900 dark:text-white bg-gray-50 dark:bg-gray-800 ring ring-inset ring-gray-300 dark:ring-gray-700 focus:ring-2 focus:ring-green-500';
      case UInputVariant.ghost:
        return 'text-gray-900 dark:text-white bg-transparent hover:bg-gray-50 dark:hover:bg-gray-800 focus:bg-gray-50 dark:focus:bg-gray-800';
      case UInputVariant.none:
        return 'text-gray-900 dark:text-white bg-transparent';
    }
  }

  @override
  Component build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;

    return div(classes: 'space-y-1.5', [
      if (label != null)
        span(
            classes:
                'block text-sm font-medium text-gray-700 dark:text-gray-200',
            [
              Component.text(label!),
              if (required)
                span(classes: 'text-red-500 ml-0.5', [Component.text('*')]),
            ]),
      textarea(
        name: name,
        onInput: onInput,
        classes: '$_baseClasses $_sizeClasses $_variantClasses',
        attributes: {
          if (placeholder != null) 'placeholder': placeholder!,
          'rows': rows.toString(),
          if (disabled) 'disabled': 'true',
        },
        [if (value != null) Component.text(value!)],
      ),
      if (hasError)
        p(classes: 'text-sm text-red-500', [Component.text(error!)])
      else if (hint != null)
        p(
            classes: 'text-sm text-gray-500 dark:text-gray-400',
            [Component.text(hint!)]),
    ]);
  }
}
