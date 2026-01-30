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
  final String? icon;

  const DSelectOption({
    required this.value,
    required this.label,
    this.disabled = false,
    this.icon,
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

/// DuxtUI Select component - Matches Nuxt UI styling
class DSelect<T> extends StatefulComponent {
  final String? label;
  final String? placeholder;
  final String? name;
  final T? value;
  final List<DSelectOption<T>> options;
  final List<DSelectOptionGroup<T>>? optionGroups;
  final bool disabled;
  final bool required;
  final bool searchable;
  final bool clearable;
  final bool multiple;
  final DSelectSize size;
  final DSelectColor color;
  final Component? leadingIcon;
  final String? error;
  final String? hint;
  final ValueChanged<T?>? onChange;
  final ValueChanged<List<T>>? onChangeMultiple;

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
    this.searchable = false,
    this.clearable = false,
    this.multiple = false,
    this.size = DSelectSize.md,
    this.color = DSelectColor.primary,
    this.leadingIcon,
    this.error,
    this.hint,
    this.onChange,
    this.onChangeMultiple,
  });

  @override
  State<DSelect<T>> createState() => _USelectState<T>();
}

class _USelectState<T> extends State<DSelect<T>> {
  bool _open = false;
  String _searchQuery = '';

  void _toggle() {
    if (!component.disabled) {
      setState(() => _open = !_open);
    }
  }

  void _close() {
    setState(() {
      _open = false;
      _searchQuery = '';
    });
  }

  void _selectOption(DSelectOption<T> option) {
    if (option.disabled) return;

    if (component.onChange != null) {
      component.onChange!(option.value);
    }
    _close();
  }

  String? _getSelectedLabel() {
    if (component.value == null) return null;

    // Search in options
    for (final option in component.options) {
      if (option.value == component.value) {
        return option.label;
      }
    }

    // Search in option groups
    if (component.optionGroups != null) {
      for (final group in component.optionGroups!) {
        for (final option in group.options) {
          if (option.value == component.value) {
            return option.label;
          }
        }
      }
    }

    return null;
  }

  List<DSelectOption<T>> _getFilteredOptions() {
    final allOptions = <DSelectOption<T>>[...component.options];
    if (component.optionGroups != null) {
      for (final group in component.optionGroups!) {
        allOptions.addAll(group.options);
      }
    }

    if (_searchQuery.isEmpty) return allOptions;

    return allOptions
        .where(
            (o) => o.label.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  String get _sizeClasses {
    switch (component.size) {
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
    final baseColor = switch (component.color) {
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
    final hasError = component.error != null && component.error!.isNotEmpty;
    final borderColor = hasError
        ? 'border-red-500 focus:ring-red-500'
        : 'border-gray-300 dark:border-gray-600 $_focusRingClasses';
    final selectedLabel = _getSelectedLabel();

    return div(classes: 'space-y-1', [
      // Label
      if (component.label != null)
        span(
            classes:
                'block text-sm font-medium text-gray-700 dark:text-gray-200',
            [
              Component.text(component.label!),
              if (component.required)
                span(classes: 'text-red-500 ml-1', [Component.text('*')]),
            ]),

      // Select container
      div(classes: 'relative', [
        // Trigger button
        button(
          type: ButtonType.button,
          disabled: component.disabled,
          onClick: _toggle,
          classes:
              'relative w-full cursor-pointer rounded-lg border $borderColor $_sizeClasses ${component.leadingIcon != null ? "pl-10" : ""} pr-10 text-left bg-white dark:bg-gray-900 focus:outline-none focus:ring-2 ${component.disabled ? "bg-gray-100 dark:bg-gray-800 cursor-not-allowed opacity-50" : ""}',
          [
            // Leading icon
            if (component.leadingIcon != null)
              span(
                classes:
                    'absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-gray-400',
                [component.leadingIcon!],
              ),

            // Selected value or placeholder
            span(
              classes: selectedLabel != null
                  ? 'block truncate text-gray-900 dark:text-white'
                  : 'block truncate text-gray-400',
              [
                Component.text(
                    selectedLabel ?? component.placeholder ?? 'Select...')
              ],
            ),

            // Dropdown icon (chevron down)
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
          ],
        ),

        // Hidden input for form submission
        if (component.name != null)
          input(
            type: InputType.hidden,
            name: component.name,
            value: component.value?.toString(),
          ),

        // Dropdown menu
        if (_open)
          div(
            classes:
                'absolute z-50 mt-1 w-full bg-white dark:bg-gray-900 rounded-lg shadow-lg border border-gray-200 dark:border-gray-700 py-1 max-h-60 overflow-auto focus:outline-none',
            [
              // Search input
              if (component.searchable)
                div(
                    classes:
                        'px-2 py-1.5 sticky top-0 bg-white dark:bg-gray-900',
                    [
                      input(
                        type: InputType.text,
                        classes:
                            'w-full px-3 py-1.5 text-sm border border-gray-300 dark:border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:border-cyan-500 bg-white dark:bg-gray-800',
                        attributes: {
                          'placeholder': 'Search...',
                        },
                        onInput: (value) {
                          setState(() => _searchQuery = value as String? ?? '');
                        },
                      ),
                    ]),

              // Options
              if (component.optionGroups != null)
                for (final group in component.optionGroups!) ...[
                  // Group label
                  div(
                    classes:
                        'px-3 py-1.5 text-xs font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider',
                    [Component.text(group.label)],
                  ),
                  // Group options
                  for (final option in group.options)
                    if (_searchQuery.isEmpty ||
                        option.label
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                      _buildOption(option),
                ]
              else
                for (final option in _getFilteredOptions())
                  _buildOption(option),

              // No results
              if (_getFilteredOptions().isEmpty && _searchQuery.isNotEmpty)
                div(
                  classes: 'px-3 py-2 text-sm text-gray-500 dark:text-gray-400',
                  [Component.text('No results found')],
                ),
            ],
          ),
      ]),

      // Error or hint
      if (hasError)
        p(classes: 'text-sm text-red-600', [Component.text(component.error!)])
      else if (component.hint != null)
        p(classes: 'text-sm text-gray-500', [Component.text(component.hint!)]),
    ]);
  }

  Component _buildOption(DSelectOption<T> option) {
    final isSelected = component.value == option.value;

    return button(
      type: ButtonType.button,
      disabled: option.disabled,
      onClick: option.disabled ? null : () => _selectOption(option),
      classes:
          'w-full px-3 py-2 text-left text-sm flex items-center gap-2 ${option.disabled ? "text-gray-400 cursor-not-allowed" : isSelected ? "bg-cyan-50 dark:bg-cyan-900/20 text-cyan-600 dark:text-cyan-400" : "text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-800"}',
      [
        // Option icon
        if (option.icon != null)
          span(classes: 'flex-shrink-0', [Component.text(option.icon!)]),

        // Option label
        span(classes: 'flex-grow truncate', [Component.text(option.label)]),

        // Check mark for selected
        if (isSelected)
          DIcon(
            name: DIconNames.check,
            size: DIconSize.sm,
            color: 'text-cyan-600 dark:text-cyan-400',
          ),
      ],
    );
  }
}
