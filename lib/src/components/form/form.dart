import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/variants.dart';

/// Form validation state
enum UFormState { initial, validating, valid, invalid }

/// Form validation result
class UFormValidationResult {
  final bool isValid;
  final Map<String, String?> errors;

  const UFormValidationResult({
    required this.isValid,
    this.errors = const {},
  });

  String? getError(String fieldName) => errors[fieldName];
}

/// Form submission callback with form data
typedef FormSubmitCallback = void Function(Map<String, dynamic> data);

/// Form validation callback
typedef FormValidateCallback = UFormValidationResult Function(Map<String, dynamic> data);

/// DuxtUI Form component - Form wrapper with validation support
class UForm extends StatefulComponent {
  final String? id;
  final String? name;
  final List<Component> children;
  final bool disabled;
  final bool validateOnSubmit;
  final bool validateOnBlur;
  final bool validateOnChange;
  final FormValidateCallback? onValidate;
  final FormSubmitCallback? onSubmit;
  final VoidCallback? onReset;

  const UForm({
    super.key,
    this.id,
    this.name,
    required this.children,
    this.disabled = false,
    this.validateOnSubmit = true,
    this.validateOnBlur = false,
    this.validateOnChange = false,
    this.onValidate,
    this.onSubmit,
    this.onReset,
  });

  @override
  State<UForm> createState() => _UFormState();
}

class _UFormState extends State<UForm> {
  UFormState _state = UFormState.initial;
  Map<String, String?> _errors = {};

  void _handleSubmit(dynamic event) {
    event.preventDefault();

    if (component.disabled) return;

    final formElement = event.target as dynamic;
    final formData = _getFormData(formElement);

    if (component.validateOnSubmit && component.onValidate != null) {
      setState(() => _state = UFormState.validating);

      final result = component.onValidate!(formData);

      setState(() {
        _errors = result.errors;
        _state = result.isValid ? UFormState.valid : UFormState.invalid;
      });

      if (!result.isValid) return;
    }

    component.onSubmit?.call(formData);
  }

  void _handleReset() {
    setState(() {
      _state = UFormState.initial;
      _errors = {};
    });
    component.onReset?.call();
  }

  Map<String, dynamic> _getFormData(dynamic formElement) {
    final data = <String, dynamic>{};
    final elements = formElement.elements;
    final length = elements.length as int;

    for (var i = 0; i < length; i++) {
      final element = elements[i];
      final name = element.name as String?;
      if (name != null && name.isNotEmpty) {
        final tagName = (element.tagName as String).toLowerCase();

        if (tagName == 'input') {
          final type = element.type as String;
          if (type == 'checkbox') {
            data[name] = element.checked as bool;
          } else if (type == 'radio') {
            if (element.checked as bool) {
              data[name] = element.value as String;
            }
          } else if (type == 'file') {
            data[name] = element.files;
          } else if (type == 'number') {
            data[name] = double.tryParse(element.value as String) ?? 0;
          } else {
            data[name] = element.value as String;
          }
        } else if (tagName == 'textarea' || tagName == 'select') {
          data[name] = element.value as String;
        }
      }
    }

    return data;
  }

  @override
  Component build(BuildContext context) {
    return form(
      id: component.id,
      classes: cx([
        'space-y-4',
        component.disabled ? 'opacity-50 pointer-events-none' : null,
      ]),
      attributes: {
        if (component.name != null) 'name': component.name!,
        'novalidate': 'true', // Use custom validation
      },
      events: {
        'submit': _handleSubmit,
        'reset': (_) => _handleReset(),
      },
      [
        // Provide form context via wrapper
        _UFormContext(
          state: _state,
          errors: _errors,
          child: div([...component.children]),
        ),
      ],
    );
  }
}

/// Internal form context wrapper
class _UFormContext extends StatelessComponent {
  final UFormState state;
  final Map<String, String?> errors;
  final Component child;

  const _UFormContext({
    required this.state,
    required this.errors,
    required this.child,
  });

  @override
  Component build(BuildContext context) {
    return child;
  }
}

/// Form actions container for submit/reset buttons
class UFormActions extends StatelessComponent {
  final List<Component> children;
  final MainAxisAlignment alignment;

  const UFormActions({
    super.key,
    required this.children,
    this.alignment = MainAxisAlignment.end,
  });

  String get _alignmentClasses {
    switch (alignment) {
      case MainAxisAlignment.start:
        return 'justify-start';
      case MainAxisAlignment.center:
        return 'justify-center';
      case MainAxisAlignment.end:
        return 'justify-end';
      case MainAxisAlignment.spaceBetween:
        return 'justify-between';
      case MainAxisAlignment.spaceAround:
        return 'justify-around';
      case MainAxisAlignment.spaceEvenly:
        return 'justify-evenly';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'flex items-center gap-3 pt-4 $_alignmentClasses',
      children,
    );
  }
}

/// Main axis alignment options
enum MainAxisAlignment {
  start,
  center,
  end,
  spaceBetween,
  spaceAround,
  spaceEvenly,
}

/// Form row for horizontal field layout
class UFormRow extends StatelessComponent {
  final List<Component> children;
  final int columns;

  const UFormRow({
    super.key,
    required this.children,
    this.columns = 2,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'grid grid-cols-$columns gap-4',
      children,
    );
  }
}

/// Form section with optional title
class UFormSection extends StatelessComponent {
  final String? title;
  final String? description;
  final List<Component> children;

  const UFormSection({
    super.key,
    this.title,
    this.description,
    required this.children,
  });

  @override
  Component build(BuildContext context) {
    return div(classes: 'space-y-4', [
      if (title != null || description != null)
        div(classes: 'border-b border-gray-200 dark:border-gray-700 pb-4', [
          if (title != null)
            h3(
              classes: 'text-lg font-medium text-gray-900 dark:text-white',
              [Component.text(title!)],
            ),
          if (description != null)
            p(
              classes: 'mt-1 text-sm text-gray-500 dark:text-gray-400',
              [Component.text(description!)],
            ),
        ]),
      ...children,
    ]);
  }
}
