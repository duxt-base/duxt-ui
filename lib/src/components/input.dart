import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Input sizes
enum UInputSize { sm, md, lg }

/// DuxtUI Input component
class UInput extends StatelessComponent {
  final String? label;
  final String? placeholder;
  final String? name;
  final String? value;
  final String? hint;
  final String? error;
  final UInputSize size;
  final bool disabled;
  final bool required;
  final bool readonly;
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
    this.disabled = false,
    this.required = false,
    this.readonly = false,
    this.type = InputType.text,
    this.leadingIcon,
    this.trailingIcon,
    this.onInput,
  });

  String get _sizeClasses {
    switch (size) {
      case UInputSize.sm:
        return 'px-2.5 py-1.5 text-sm';
      case UInputSize.md:
        return 'px-3 py-2 text-sm';
      case UInputSize.lg:
        return 'px-4 py-2.5 text-base';
    }
  }

  @override
  Component build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;
    final borderColor = hasError ? 'border-red-500 focus:ring-red-500' : 'border-gray-300 focus:ring-indigo-500 focus:border-indigo-500';

    return div(classes: 'space-y-1', [
      if (label != null)
        span(classes: 'block text-sm font-medium text-gray-700', [
          text(label!),
          if (required) span(classes: 'text-red-500 ml-1', [text('*')]),
        ]),
      div(classes: 'relative', [
        if (leadingIcon != null)
          div(classes: 'absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-gray-400', [
            leadingIcon!,
          ]),
        input(
          type: type,
          name: name,
          value: value,
          disabled: disabled,
          onInput: onInput,
          classes: 'block w-full rounded-lg border $borderColor $_sizeClasses ${leadingIcon != null ? "pl-10" : ""} ${trailingIcon != null ? "pr-10" : ""} ${disabled ? "bg-gray-100 cursor-not-allowed" : "bg-white"} focus:outline-none focus:ring-2',
          attributes: {
            if (placeholder != null) 'placeholder': placeholder!,
            if (readonly) 'readonly': 'true',
          },
        ),
        if (trailingIcon != null)
          div(classes: 'absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none text-gray-400', [
            trailingIcon!,
          ]),
      ]),
      if (hasError)
        p(classes: 'text-sm text-red-600', [text(error!)])
      else if (hint != null)
        p(classes: 'text-sm text-gray-500', [text(hint!)]),
    ]);
  }
}

/// DuxtUI Textarea component
class UTextarea extends StatelessComponent {
  final String? label;
  final String? placeholder;
  final String? name;
  final String? value;
  final String? hint;
  final String? error;
  final int rows;
  final bool disabled;
  final bool required;
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
    this.disabled = false,
    this.required = false,
    this.onInput,
  });

  @override
  Component build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;
    final borderColor = hasError ? 'border-red-500 focus:ring-red-500' : 'border-gray-300 focus:ring-indigo-500 focus:border-indigo-500';

    return div(classes: 'space-y-1', [
      if (label != null)
        span(classes: 'block text-sm font-medium text-gray-700', [
          text(label!),
          if (required) span(classes: 'text-red-500 ml-1', [text('*')]),
        ]),
      textarea(
        name: name,
        onInput: onInput,
        classes: 'block w-full rounded-lg border $borderColor px-3 py-2 text-sm ${disabled ? "bg-gray-100 cursor-not-allowed" : "bg-white"} focus:outline-none focus:ring-2',
        attributes: {
          if (placeholder != null) 'placeholder': placeholder!,
          'rows': rows.toString(),
          if (disabled) 'disabled': 'true',
        },
        [if (value != null) text(value!)],
      ),
      if (hasError)
        p(classes: 'text-sm text-red-600', [text(error!)])
      else if (hint != null)
        p(classes: 'text-sm text-gray-500', [text(hint!)]),
    ]);
  }
}
