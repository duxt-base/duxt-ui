import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// Input number sizes
enum DInputNumberSize { xs, sm, md, lg, xl }

/// DuxtUI InputNumber component - Numeric input with increment/decrement buttons
class DInputNumber extends StatefulComponent {
  final String? label;
  final double value;
  final double min;
  final double max;
  final double step;
  final String? name;
  final String? placeholder;
  final DInputNumberSize size;
  final DColor color;
  final bool disabled;
  final bool required;
  final String? hint;
  final String? error;
  final ValueChanged<double>? onChange;

  const DInputNumber({
    super.key,
    this.label,
    this.value = 0,
    this.min = double.negativeInfinity,
    this.max = double.infinity,
    this.step = 1,
    this.name,
    this.placeholder,
    this.size = DInputNumberSize.md,
    this.color = DColor.primary,
    this.disabled = false,
    this.required = false,
    this.hint,
    this.error,
    this.onChange,
  });

  @override
  State<DInputNumber> createState() => _UInputNumberState();
}

class _UInputNumberState extends State<DInputNumber> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = component.value;
  }

  String get _sizeClasses {
    switch (component.size) {
      case DInputNumberSize.xs:
        return 'px-2 py-1 text-xs';
      case DInputNumberSize.sm:
        return 'px-2.5 py-1.5 text-xs';
      case DInputNumberSize.md:
        return 'px-2.5 py-1.5 text-sm';
      case DInputNumberSize.lg:
        return 'px-3 py-2 text-sm';
      case DInputNumberSize.xl:
        return 'px-3 py-2 text-base';
    }
  }

  String get _buttonSizeClasses {
    switch (component.size) {
      case DInputNumberSize.xs:
        return 'px-2 py-1';
      case DInputNumberSize.sm:
        return 'px-2.5 py-1.5';
      case DInputNumberSize.md:
        return 'px-3 py-1.5';
      case DInputNumberSize.lg:
        return 'px-3.5 py-2';
      case DInputNumberSize.xl:
        return 'px-4 py-2';
    }
  }

  String get _colorClasses {
    switch (component.color) {
      case DColor.primary:
        return 'focus:ring-green-500 focus:border-green-500';
      case DColor.secondary:
        return 'focus:ring-blue-500 focus:border-blue-500';
      case DColor.success:
        return 'focus:ring-green-500 focus:border-green-500';
      case DColor.info:
        return 'focus:ring-blue-500 focus:border-blue-500';
      case DColor.warning:
        return 'focus:ring-yellow-500 focus:border-yellow-500';
      case DColor.error:
        return 'focus:ring-red-500 focus:border-red-500';
      case DColor.neutral:
        return 'focus:ring-slate-500 focus:border-slate-500';
    }
  }

  void _increment() {
    if (component.disabled) return;
    final newValue = _value + component.step;
    if (newValue <= component.max) {
      setState(() => _value = newValue);
      component.onChange?.call(_value);
    }
  }

  void _decrement() {
    if (component.disabled) return;
    final newValue = _value - component.step;
    if (newValue >= component.min) {
      setState(() => _value = newValue);
      component.onChange?.call(_value);
    }
  }

  void _handleInput(String value) {
    final doubleValue = double.tryParse(value);
    if (doubleValue != null) {
      final clampedValue = doubleValue.clamp(component.min, component.max);
      setState(() => _value = clampedValue);
      component.onChange?.call(_value);
    }
  }

  @override
  Component build(BuildContext context) {
    final hasError = component.error != null && component.error!.isNotEmpty;
    final borderColor = hasError
        ? 'border-red-500 focus:ring-red-500'
        : 'border-gray-300 dark:border-gray-600 $_colorClasses';

    final buttonBaseClasses = cx([
      _buttonSizeClasses,
      'text-gray-500',
      'dark:text-gray-400',
      'hover:bg-gray-100',
      'dark:hover:bg-gray-700',
      'focus:outline-none',
      'focus:ring-2',
      'focus:ring-inset',
      _colorClasses,
      component.disabled ? 'opacity-50 cursor-not-allowed' : null,
    ]);

    return div(classes: 'space-y-1', [
      if (component.label != null)
        span(
            classes:
                'block text-sm font-medium text-gray-700 dark:text-gray-200',
            [
              Component.text(component.label!),
              if (component.required)
                span(classes: 'text-red-500 ml-1', [Component.text('*')]),
            ]),
      div(classes: 'relative flex items-stretch', [
        // Decrement button
        button(
          type: ButtonType.button,
          disabled: component.disabled || _value <= component.min,
          onClick: _decrement,
          classes: cx([
            buttonBaseClasses,
            'rounded-l-lg',
            'border',
            'border-r-0',
            borderColor,
            'bg-gray-50',
            'dark:bg-gray-800',
          ]),
          [
            span(classes: 'sr-only', [Component.text('Decrement')]),
            span(classes: 'text-lg font-medium', [Component.text('-')]),
          ],
        ),
        // Input
        input(
          type: InputType.number,
          name: component.name,
          value: _value.toString(),
          disabled: component.disabled,
          classes: cx([
            'block',
            'w-full',
            'text-center',
            'border',
            borderColor,
            _sizeClasses,
            component.disabled
                ? 'bg-gray-100 dark:bg-gray-800 cursor-not-allowed'
                : 'bg-white dark:bg-gray-900',
            'focus:outline-none',
            'focus:ring-2',
          ]),
          attributes: {
            if (component.placeholder != null)
              'placeholder': component.placeholder!,
            'min': component.min.isFinite ? component.min.toString() : '',
            'max': component.max.isFinite ? component.max.toString() : '',
            'step': component.step.toString(),
          },
          events: {
            'input': (event) {
              final target = event.target as dynamic;
              _handleInput(target.value as String);
            },
          },
        ),
        // Increment button
        button(
          type: ButtonType.button,
          disabled: component.disabled || _value >= component.max,
          onClick: _increment,
          classes: cx([
            buttonBaseClasses,
            'rounded-r-lg',
            'border',
            'border-l-0',
            borderColor,
            'bg-gray-50',
            'dark:bg-gray-800',
          ]),
          [
            span(classes: 'sr-only', [Component.text('Increment')]),
            span(classes: 'text-lg font-medium', [Component.text('+')]),
          ],
        ),
      ]),
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
