import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// Pin input sizes
enum UPinInputSize { xs, sm, md, lg, xl }

/// Pin input types
enum UPinInputType { text, number, password }

/// DuxtUI PinInput component - PIN/OTP entry with individual digit inputs
class UPinInput extends StatefulComponent {
  final int length;
  final String? label;
  final String value;
  final UPinInputSize size;
  final UPinInputType type;
  final UColor color;
  final bool disabled;
  final bool required;
  final bool autofocus;
  final String? placeholder;
  final String? hint;
  final String? error;
  final String? name;
  final ValueChanged<String>? onChange;
  final VoidCallback? onComplete;

  const UPinInput({
    super.key,
    this.length = 4,
    this.label,
    this.value = '',
    this.size = UPinInputSize.md,
    this.type = UPinInputType.number,
    this.color = UColor.primary,
    this.disabled = false,
    this.required = false,
    this.autofocus = false,
    this.placeholder,
    this.hint,
    this.error,
    this.name,
    this.onChange,
    this.onComplete,
  });

  @override
  State<UPinInput> createState() => _UPinInputState();
}

class _UPinInputState extends State<UPinInput> {
  late List<String> _digits;

  @override
  void initState() {
    super.initState();
    _digits = List.generate(
      component.length,
      (i) => i < component.value.length ? component.value[i] : '',
    );
  }

  String get _sizeClasses {
    switch (component.size) {
      case UPinInputSize.xs:
        return 'w-8 h-8 text-sm';
      case UPinInputSize.sm:
        return 'w-10 h-10 text-base';
      case UPinInputSize.md:
        return 'w-12 h-12 text-lg';
      case UPinInputSize.lg:
        return 'w-14 h-14 text-xl';
      case UPinInputSize.xl:
        return 'w-16 h-16 text-2xl';
    }
  }

  String get _gapClasses {
    switch (component.size) {
      case UPinInputSize.xs:
        return 'gap-1';
      case UPinInputSize.sm:
        return 'gap-1.5';
      case UPinInputSize.md:
        return 'gap-2';
      case UPinInputSize.lg:
        return 'gap-2.5';
      case UPinInputSize.xl:
        return 'gap-3';
    }
  }

  String get _colorClasses {
    switch (component.color) {
      case UColor.primary:
        return 'focus:ring-green-500 focus:border-green-500';
      case UColor.secondary:
        return 'focus:ring-blue-500 focus:border-blue-500';
      case UColor.success:
        return 'focus:ring-green-500 focus:border-green-500';
      case UColor.info:
        return 'focus:ring-blue-500 focus:border-blue-500';
      case UColor.warning:
        return 'focus:ring-yellow-500 focus:border-yellow-500';
      case UColor.error:
        return 'focus:ring-red-500 focus:border-red-500';
      case UColor.neutral:
        return 'focus:ring-slate-500 focus:border-slate-500';
    }
  }

  InputType get _inputType {
    switch (component.type) {
      case UPinInputType.text:
        return InputType.text;
      case UPinInputType.number:
        return InputType
            .text; // Use text with inputmode for better mobile support
      case UPinInputType.password:
        return InputType.password;
    }
  }

  void _handleInput(int index, String value) {
    if (component.disabled) return;

    // Handle paste - distribute characters across inputs
    if (value.length > 1) {
      for (var i = 0; i < value.length && index + i < component.length; i++) {
        _digits[index + i] = value[i];
      }
    } else {
      _digits[index] = value.isNotEmpty ? value[value.length - 1] : '';
    }

    setState(() {});

    final fullValue = _digits.join();
    component.onChange?.call(fullValue);

    // Auto-advance to next input
    if (value.isNotEmpty && index < component.length - 1) {
      _focusNext(index);
    }

    // Check if complete
    if (fullValue.length == component.length && !fullValue.contains('')) {
      component.onComplete?.call();
    }
  }

  void _handleKeyDown(int index, String key) {
    if (component.disabled) return;

    if (key == 'Backspace' && _digits[index].isEmpty && index > 0) {
      _focusPrevious(index);
    } else if (key == 'ArrowLeft' && index > 0) {
      _focusPrevious(index);
    } else if (key == 'ArrowRight' && index < component.length - 1) {
      _focusNext(index);
    }
  }

  void _focusNext(int currentIndex) {
    // Focus management would require DOM access
    // In Jaspr, this is typically handled via refs or native JS interop
  }

  void _focusPrevious(int currentIndex) {
    // Focus management would require DOM access
  }

  @override
  Component build(BuildContext context) {
    final hasError = component.error != null && component.error!.isNotEmpty;
    final borderColor =
        hasError ? 'border-red-500' : 'border-gray-300 dark:border-gray-600';

    return div(classes: 'space-y-2', [
      if (component.label != null)
        span(
            classes:
                'block text-sm font-medium text-gray-700 dark:text-gray-200',
            [
              Component.text(component.label!),
              if (component.required)
                span(classes: 'text-red-500 ml-1', [Component.text('*')]),
            ]),
      div(classes: 'flex items-center $_gapClasses', [
        for (var i = 0; i < component.length; i++)
          input(
            type: _inputType,
            name: component.name != null ? '${component.name}_$i' : null,
            value: _digits[i],
            disabled: component.disabled,
            classes: cx([
              _sizeClasses,
              'text-center',
              'font-medium',
              'rounded-lg',
              'border',
              borderColor,
              _colorClasses,
              component.disabled
                  ? 'bg-gray-100 dark:bg-gray-800 cursor-not-allowed'
                  : 'bg-white dark:bg-gray-900',
              'focus:outline-none',
              'focus:ring-2',
            ]),
            attributes: {
              'maxlength': '1',
              if (component.type == UPinInputType.number)
                'inputmode': 'numeric',
              if (component.type == UPinInputType.number) 'pattern': '[0-9]*',
              if (component.placeholder != null)
                'placeholder': component.placeholder!,
              if (component.autofocus && i == 0) 'autofocus': 'true',
            },
            events: {
              'input': (event) {
                final target = event.target as dynamic;
                _handleInput(i, target.value as String);
              },
              'keydown': (event) {
                final keyEvent = event as dynamic;
                _handleKeyDown(i, keyEvent.key as String);
              },
            },
          ),
      ]),
      // Hidden input for form submission with complete value
      if (component.name != null)
        input(
          type: InputType.hidden,
          name: component.name,
          value: _digits.join(),
        ),
      if (hasError)
        p(
            classes: 'text-sm text-red-600 dark:text-red-400',
            [Component.text(component.error!)])
      else if (component.hint != null)
        p(
            classes: 'text-sm text-gray-500 dark:text-gray-400',
            [Component.text(component.hint!)]),
    ]);
  }
}
