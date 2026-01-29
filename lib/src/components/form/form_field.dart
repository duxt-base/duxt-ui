import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/variants.dart';

/// Form field sizes
enum UFormFieldSize { sm, md, lg }

/// Validation rule
class UValidationRule {
  final String message;
  final bool Function(dynamic value) validator;

  const UValidationRule({
    required this.message,
    required this.validator,
  });
}

/// Common validation rules
class UValidators {
  /// Required field validator
  static UValidationRule required([String? message]) {
    return UValidationRule(
      message: message ?? 'This field is required',
      validator: (value) {
        if (value == null) return false;
        if (value is String) return value.trim().isNotEmpty;
        if (value is List) return value.isNotEmpty;
        return true;
      },
    );
  }

  /// Email validator
  static UValidationRule email([String? message]) {
    return UValidationRule(
      message: message ?? 'Please enter a valid email address',
      validator: (value) {
        if (value == null || value is! String || value.isEmpty) return true;
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        return emailRegex.hasMatch(value);
      },
    );
  }

  /// Minimum length validator
  static UValidationRule minLength(int length, [String? message]) {
    return UValidationRule(
      message: message ?? 'Must be at least $length characters',
      validator: (value) {
        if (value == null || value is! String) return true;
        return value.length >= length;
      },
    );
  }

  /// Maximum length validator
  static UValidationRule maxLength(int length, [String? message]) {
    return UValidationRule(
      message: message ?? 'Must be no more than $length characters',
      validator: (value) {
        if (value == null || value is! String) return true;
        return value.length <= length;
      },
    );
  }

  /// Minimum value validator (for numbers)
  static UValidationRule min(num minValue, [String? message]) {
    return UValidationRule(
      message: message ?? 'Must be at least $minValue',
      validator: (value) {
        if (value == null) return true;
        final numValue = value is num ? value : num.tryParse(value.toString());
        if (numValue == null) return true;
        return numValue >= minValue;
      },
    );
  }

  /// Maximum value validator (for numbers)
  static UValidationRule max(num maxValue, [String? message]) {
    return UValidationRule(
      message: message ?? 'Must be no more than $maxValue',
      validator: (value) {
        if (value == null) return true;
        final numValue = value is num ? value : num.tryParse(value.toString());
        if (numValue == null) return true;
        return numValue <= maxValue;
      },
    );
  }

  /// Pattern validator (regex)
  static UValidationRule pattern(RegExp regex, [String? message]) {
    return UValidationRule(
      message: message ?? 'Invalid format',
      validator: (value) {
        if (value == null || value is! String || value.isEmpty) return true;
        return regex.hasMatch(value);
      },
    );
  }

  /// Custom validator
  static UValidationRule custom(
    bool Function(dynamic value) validator,
    String message,
  ) {
    return UValidationRule(
      message: message,
      validator: validator,
    );
  }
}

/// DuxtUI FormField component - Field wrapper with label, validation, and error display
class UFormField extends StatefulComponent {
  final String? name;
  final String? label;
  final String? hint;
  final String? error;
  final bool required;
  final bool disabled;
  final UFormFieldSize size;
  final List<UValidationRule> rules;
  final List<Component> children;
  final bool validateOnBlur;
  final bool validateOnChange;

  const UFormField({
    super.key,
    this.name,
    this.label,
    this.hint,
    this.error,
    this.required = false,
    this.disabled = false,
    this.size = UFormFieldSize.md,
    this.rules = const [],
    required this.children,
    this.validateOnBlur = true,
    this.validateOnChange = false,
  });

  @override
  State<UFormField> createState() => _UFormFieldState();
}

class _UFormFieldState extends State<UFormField> {
  String? _error;
  bool _touched = false;

  String get _labelSizeClasses {
    switch (component.size) {
      case UFormFieldSize.sm:
        return 'text-xs';
      case UFormFieldSize.md:
        return 'text-sm';
      case UFormFieldSize.lg:
        return 'text-base';
    }
  }

  String get _hintSizeClasses {
    switch (component.size) {
      case UFormFieldSize.sm:
        return 'text-xs';
      case UFormFieldSize.md:
        return 'text-sm';
      case UFormFieldSize.lg:
        return 'text-sm';
    }
  }

  String? validate(dynamic value) {
    // Check required first
    if (component.required) {
      final requiredRule = UValidators.required();
      if (!requiredRule.validator(value)) {
        return requiredRule.message;
      }
    }

    // Check other rules
    for (final rule in component.rules) {
      if (!rule.validator(value)) {
        return rule.message;
      }
    }

    return null;
  }

  void _handleBlur(dynamic value) {
    if (!component.validateOnBlur) return;
    setState(() {
      _touched = true;
      _error = validate(value);
    });
  }

  void _handleChange(dynamic value) {
    if (!component.validateOnChange && !_touched) return;
    setState(() {
      _error = validate(value);
    });
  }

  @override
  Component build(BuildContext context) {
    final displayError = component.error ?? _error;
    final hasError = displayError != null && displayError.isNotEmpty;

    return div(
      classes: cx([
        'space-y-1',
        component.disabled ? 'opacity-50' : null,
      ]),
      events: {
        'focusout': (event) {
          final target = event.target as dynamic;
          _handleBlur(target.value);
        },
        'input': (event) {
          final target = event.target as dynamic;
          _handleChange(target.value);
        },
      },
      [
        // Label
        if (component.label != null)
          label(
            classes: cx([
              'block',
              'font-medium',
              _labelSizeClasses,
              hasError
                  ? 'text-red-700 dark:text-red-400'
                  : 'text-gray-700 dark:text-gray-200',
            ]),
            attributes: {
              if (component.name != null) 'for': component.name!,
            },
            [
              Component.text(component.label!),
              if (component.required)
                span(classes: 'text-red-500 ml-1', [Component.text('*')]),
            ],
          ),
        // Field content (input, select, etc.)
        div(classes: 'relative', component.children),
        // Error or hint message
        if (hasError)
          p(
            classes: cx([
              _hintSizeClasses,
              'text-red-600',
              'dark:text-red-400',
              'mt-1',
            ]),
            [Component.text(displayError)],
          )
        else if (component.hint != null)
          p(
            classes: cx([
              _hintSizeClasses,
              'text-gray-500',
              'dark:text-gray-400',
              'mt-1',
            ]),
            [Component.text(component.hint!)],
          ),
      ],
    );
  }
}

/// Form field group for grouping related fields (e.g., radio buttons)
class UFormFieldGroup extends StatelessComponent {
  final String? label;
  final String? hint;
  final String? error;
  final bool required;
  final List<Component> children;
  final bool inline;

  const UFormFieldGroup({
    super.key,
    this.label,
    this.hint,
    this.error,
    this.required = false,
    required this.children,
    this.inline = false,
  });

  @override
  Component build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;

    return fieldset(
      classes: 'space-y-2',
      [
        if (label != null)
          legend(
            classes: cx([
              'text-sm',
              'font-medium',
              hasError
                  ? 'text-red-700 dark:text-red-400'
                  : 'text-gray-700 dark:text-gray-200',
            ]),
            [
              Component.text(label!),
              if (required)
                span(classes: 'text-red-500 ml-1', [Component.text('*')]),
            ],
          ),
        div(
          classes: inline ? 'flex flex-wrap gap-4' : 'space-y-2',
          children,
        ),
        if (hasError)
          p(
              classes: 'text-sm text-red-600 dark:text-red-400',
              [Component.text(error!)])
        else if (hint != null)
          p(
              classes: 'text-sm text-gray-500 dark:text-gray-400',
              [Component.text(hint!)]),
      ],
    );
  }
}

/// Helper component for displaying field errors
class UFieldError extends StatelessComponent {
  final String? error;

  const UFieldError({super.key, this.error});

  @override
  Component build(BuildContext context) {
    if (error == null || error!.isEmpty) {
      return span([]);
    }

    return p(
      classes: 'text-sm text-red-600 dark:text-red-400 mt-1',
      [Component.text(error!)],
    );
  }
}

/// Helper component for displaying field hints
class UFieldHint extends StatelessComponent {
  final String hint;

  const UFieldHint({super.key, required this.hint});

  @override
  Component build(BuildContext context) {
    return p(
      classes: 'text-sm text-gray-500 dark:text-gray-400 mt-1',
      [Component.text(hint)],
    );
  }
}
