import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Checkbox sizes
enum DCheckboxSize { xs, sm, md, lg, xl }

/// Checkbox colors
enum DCheckboxColor { primary, gray, success, warning, error }

/// DuxtUI Checkbox component - Matches Nuxt UI styling
class DCheckbox extends StatelessComponent {
  final String? label;
  final String? description;
  final String? name;
  final bool checked;
  final bool disabled;
  final bool required;
  final bool indeterminate;
  final DCheckboxSize size;
  final DCheckboxColor color;
  final String? error;
  final String? hint;
  final ValueChanged<bool>? onChange;

  const DCheckbox({
    super.key,
    this.label,
    this.description,
    this.name,
    this.checked = false,
    this.disabled = false,
    this.required = false,
    this.indeterminate = false,
    this.size = DCheckboxSize.md,
    this.color = DCheckboxColor.primary,
    this.error,
    this.hint,
    this.onChange,
  });

  String get _sizeClasses {
    switch (size) {
      case DCheckboxSize.xs:
        return 'h-3 w-3';
      case DCheckboxSize.sm:
        return 'h-3.5 w-3.5';
      case DCheckboxSize.md:
        return 'h-4 w-4';
      case DCheckboxSize.lg:
        return 'h-5 w-5';
      case DCheckboxSize.xl:
        return 'h-6 w-6';
    }
  }

  String get _labelSizeClasses {
    switch (size) {
      case DCheckboxSize.xs:
        return 'text-xs';
      case DCheckboxSize.sm:
        return 'text-xs';
      case DCheckboxSize.md:
        return 'text-sm';
      case DCheckboxSize.lg:
        return 'text-base';
      case DCheckboxSize.xl:
        return 'text-lg';
    }
  }

  String get _colorClasses {
    final baseColor = switch (color) {
      DCheckboxColor.primary => 'indigo',
      DCheckboxColor.gray => 'gray',
      DCheckboxColor.success => 'green',
      DCheckboxColor.warning => 'yellow',
      DCheckboxColor.error => 'red',
    };
    return 'text-$baseColor-600 focus:ring-$baseColor-500/20';
  }

  @override
  Component build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;
    final borderColor =
        hasError ? 'border-red-500' : 'border-gray-300 dark:border-gray-600';

    return div(classes: 'space-y-1', [
      div(classes: 'flex items-start gap-2', [
        div(classes: 'flex items-center h-5', [
          input(
            type: InputType.checkbox,
            name: name,
            disabled: disabled,
            classes:
                '$_sizeClasses $_colorClasses rounded border-2 $borderColor bg-white dark:bg-gray-900 cursor-pointer focus:ring-2 focus:ring-offset-0 ${disabled ? "opacity-50 cursor-not-allowed" : ""}',
            attributes: {
              if (checked) 'checked': 'true',
              if (indeterminate) 'indeterminate': 'true',
              if (required) 'required': 'true',
            },
            events: {
              'change': (event) {
                if (onChange != null) {
                  // Toggle the current state
                  onChange!(!checked);
                }
              },
            },
          ),
        ]),
        if (label != null || description != null)
          div(classes: 'flex flex-col', [
            if (label != null)
              span(
                classes:
                    '$_labelSizeClasses font-medium ${disabled ? "text-gray-400" : "text-gray-700 dark:text-gray-200"} cursor-pointer',
                [
                  Component.text(label!),
                  if (required)
                    span(classes: 'text-red-500 ml-1', [Component.text('*')]),
                ],
              ),
            if (description != null)
              p(
                classes: 'text-xs text-gray-500 dark:text-gray-400',
                [Component.text(description!)],
              ),
          ]),
      ]),
      if (hasError)
        p(classes: 'text-sm text-red-600', [Component.text(error!)])
      else if (hint != null)
        p(classes: 'text-sm text-gray-500', [Component.text(hint!)]),
    ]);
  }
}
