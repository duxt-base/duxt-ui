import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../utility/icon.dart';

/// Select sizes
enum DSelectSize { xs, sm, md, lg, xl }

/// Select colors
enum DSelectColor { primary, gray, success, warning, error }

/// Select option item
class DSelectOption<T> {
  final T value;
  final String label;
  final bool disabled;

  const DSelectOption({
    required this.value,
    required this.label,
    this.disabled = false,
  });
}

/// Select option group
class DSelectOptionGroup<T> {
  final String label;
  final List<DSelectOption<T>> options;

  const DSelectOptionGroup({
    required this.label,
    required this.options,
  });
}

/// DuxtUI Select component using native HTML select
///
/// Uses native `<select>` element for full browser compatibility and accessibility.
/// Works without JavaScript - values are submitted with forms automatically.
class DSelect<T> extends StatelessComponent {
  final String? label;
  final String? placeholder;
  final String? name;
  final T? value;
  final List<DSelectOption<T>> options;
  final List<DSelectOptionGroup<T>>? optionGroups;
  final bool disabled;
  final bool required;
  final bool multiple;
  final DSelectSize size;
  final DSelectColor color;
  final String? error;
  final String? hint;

  const DSelect({
    super.key,
    this.label,
    this.placeholder,
    this.name,
    this.value,
    this.options = const [],
    this.optionGroups,
    this.disabled = false,
    this.required = false,
    this.multiple = false,
    this.size = DSelectSize.md,
    this.color = DSelectColor.primary,
    this.error,
    this.hint,
  });

  String get _sizeClasses {
    switch (size) {
      case DSelectSize.xs:
        return 'px-2 py-1 text-xs';
      case DSelectSize.sm:
        return 'px-2.5 py-1.5 text-xs';
      case DSelectSize.md:
        return 'px-3 py-2 text-sm';
      case DSelectSize.lg:
        return 'px-4 py-2.5 text-sm';
      case DSelectSize.xl:
        return 'px-4 py-3 text-base';
    }
  }

  String get _focusRingClasses {
    final baseColor = switch (color) {
      DSelectColor.primary => 'cyan',
      DSelectColor.gray => 'gray',
      DSelectColor.success => 'green',
      DSelectColor.warning => 'yellow',
      DSelectColor.error => 'red',
    };
    return 'focus:ring-$baseColor-500 focus:border-$baseColor-500';
  }

  @override
  Component build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;
    final borderColor = hasError
        ? 'border-red-500 focus:ring-red-500'
        : 'border-gray-300 dark:border-gray-600 $_focusRingClasses';

    return div(classes: 'space-y-1', [
      // Label
      if (label != null)
        span(
            classes:
                'block text-sm font-medium text-gray-700 dark:text-gray-200',
            [
              Component.text(label!),
              if (required)
                span(classes: 'text-red-500 ml-1', [Component.text('*')]),
            ]),

      // Native select with custom styling
      div(classes: 'relative', [
        select(
          name: name,
          disabled: disabled,
          classes:
              'w-full cursor-pointer rounded-lg border $borderColor $_sizeClasses pr-10 bg-white dark:bg-zinc-900 text-gray-900 dark:text-white focus:outline-none focus:ring-2 appearance-none ${disabled ? "bg-gray-100 dark:bg-zinc-800 cursor-not-allowed opacity-50" : ""}',
          attributes: {
            if (required) 'required': 'true',
            if (multiple) 'multiple': 'true',
          },
          [
            // Placeholder option
            if (placeholder != null)
              option(
                value: '',
                disabled: true,
                selected: value == null,
                [Component.text(placeholder!)],
              ),

            // Option groups
            if (optionGroups != null)
              for (final group in optionGroups!)
                optgroup(
                  label: group.label,
                  [
                    for (final opt in group.options)
                      option(
                        value: opt.value.toString(),
                        disabled: opt.disabled,
                        selected: value == opt.value,
                        [Component.text(opt.label)],
                      ),
                  ],
                )
            else
              // Regular options
              for (final opt in options)
                option(
                  value: opt.value.toString(),
                  disabled: opt.disabled,
                  selected: value == opt.value,
                  [Component.text(opt.label)],
                ),
          ],
        ),
        // Custom dropdown arrow
        span(
          classes:
              'absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none',
          [
            DIcon(
              name: DIconNames.chevronDown,
              size: DIconSize.sm,
              color: 'text-gray-400',
            ),
          ],
        ),
      ]),

      // Error or hint
      if (hasError)
        p(classes: 'text-sm text-red-600', [Component.text(error!)])
      else if (hint != null)
        p(classes: 'text-sm text-gray-500', [Component.text(hint!)]),
    ]);
  }
}
