import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Radio group sizes
enum URadioGroupSize { xs, sm, md, lg, xl }

/// Radio group colors
enum URadioGroupColor { primary, gray, success, warning, error }

/// Radio group orientation
enum URadioGroupOrientation { horizontal, vertical }

/// Radio option item
class URadioOption<T> {
  final T value;
  final String label;
  final String? description;
  final bool disabled;

  const URadioOption({
    required this.value,
    required this.label,
    this.description,
    this.disabled = false,
  });
}

/// DuxtUI Radio Group component - Matches Nuxt UI styling
class URadioGroup<T> extends StatelessComponent {
  final String? label;
  final List<URadioOption<T>> options;
  final T? value;
  final String name;
  final bool disabled;
  final bool required;
  final URadioGroupSize size;
  final URadioGroupColor color;
  final URadioGroupOrientation orientation;
  final String? error;
  final String? hint;
  final ValueChanged<T>? onChange;

  const URadioGroup({
    super.key,
    this.label,
    required this.options,
    required this.name,
    this.value,
    this.disabled = false,
    this.required = false,
    this.size = URadioGroupSize.md,
    this.color = URadioGroupColor.primary,
    this.orientation = URadioGroupOrientation.vertical,
    this.error,
    this.hint,
    this.onChange,
  });

  String get _sizeClasses {
    switch (size) {
      case URadioGroupSize.xs:
        return 'h-3 w-3';
      case URadioGroupSize.sm:
        return 'h-3.5 w-3.5';
      case URadioGroupSize.md:
        return 'h-4 w-4';
      case URadioGroupSize.lg:
        return 'h-5 w-5';
      case URadioGroupSize.xl:
        return 'h-6 w-6';
    }
  }

  String get _labelSizeClasses {
    switch (size) {
      case URadioGroupSize.xs:
        return 'text-xs';
      case URadioGroupSize.sm:
        return 'text-xs';
      case URadioGroupSize.md:
        return 'text-sm';
      case URadioGroupSize.lg:
        return 'text-base';
      case URadioGroupSize.xl:
        return 'text-lg';
    }
  }

  String get _colorClasses {
    final baseColor = switch (color) {
      URadioGroupColor.primary => 'indigo',
      URadioGroupColor.gray => 'gray',
      URadioGroupColor.success => 'green',
      URadioGroupColor.warning => 'yellow',
      URadioGroupColor.error => 'red',
    };
    return 'text-$baseColor-600 focus:ring-$baseColor-500/20';
  }

  String get _orientationClasses {
    switch (orientation) {
      case URadioGroupOrientation.horizontal:
        return 'flex flex-row flex-wrap gap-4';
      case URadioGroupOrientation.vertical:
        return 'flex flex-col gap-2';
    }
  }

  @override
  Component build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;
    final borderColor =
        hasError ? 'border-red-500' : 'border-gray-300 dark:border-gray-600';

    return div(classes: 'space-y-2', [
      if (label != null)
        span(
            classes:
                'block text-sm font-medium text-gray-700 dark:text-gray-200',
            [
              Component.text(label!),
              if (required)
                span(classes: 'text-red-500 ml-1', [Component.text('*')]),
            ]),
      fieldset(
        classes: _orientationClasses,
        [
          for (final option in options)
            div(classes: 'flex items-start gap-2', [
              div(classes: 'flex items-center h-5', [
                input(
                  type: InputType.radio,
                  name: name,
                  disabled: disabled || option.disabled,
                  classes:
                      '$_sizeClasses $_colorClasses rounded-full border-2 $borderColor bg-white dark:bg-gray-900 cursor-pointer focus:ring-2 focus:ring-offset-0 ${disabled || option.disabled ? "opacity-50 cursor-not-allowed" : ""}',
                  attributes: {
                    'value': option.value.toString(),
                    if (value == option.value) 'checked': 'true',
                  },
                  events: {
                    'change': (_) {
                      if (onChange != null && !option.disabled) {
                        onChange!(option.value);
                      }
                    },
                  },
                ),
              ]),
              if (option.label.isNotEmpty || option.description != null)
                div(classes: 'flex flex-col', [
                  span(
                    classes:
                        '$_labelSizeClasses font-medium ${disabled || option.disabled ? "text-gray-400" : "text-gray-700 dark:text-gray-200"} cursor-pointer',
                    [Component.text(option.label)],
                  ),
                  if (option.description != null)
                    p(
                      classes: 'text-xs text-gray-500 dark:text-gray-400',
                      [Component.text(option.description!)],
                    ),
                ]),
            ]),
        ],
      ),
      if (hasError)
        p(classes: 'text-sm text-red-600', [Component.text(error!)])
      else if (hint != null)
        p(classes: 'text-sm text-gray-500', [Component.text(hint!)]),
    ]);
  }
}
