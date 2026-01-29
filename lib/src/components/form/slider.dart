import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// Slider sizes
enum USliderSize { xs, sm, md, lg, xl }

/// DuxtUI Slider component - Range input with Nuxt UI styling
class USlider extends StatefulComponent {
  final String? label;
  final double value;
  final double min;
  final double max;
  final double step;
  final String? name;
  final USliderSize size;
  final UColor color;
  final bool disabled;
  final bool showValue;
  final String? hint;
  final ValueChanged<double>? onChange;

  const USlider({
    super.key,
    this.label,
    this.value = 0,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.name,
    this.size = USliderSize.md,
    this.color = UColor.primary,
    this.disabled = false,
    this.showValue = false,
    this.hint,
    this.onChange,
  });

  @override
  State<USlider> createState() => _USliderState();
}

class _USliderState extends State<USlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = component.value;
  }

  String get _trackHeightClass {
    switch (component.size) {
      case USliderSize.xs:
        return 'h-1';
      case USliderSize.sm:
        return 'h-1.5';
      case USliderSize.md:
        return 'h-2';
      case USliderSize.lg:
        return 'h-2.5';
      case USliderSize.xl:
        return 'h-3';
    }
  }

  String get _accentColor {
    switch (component.color) {
      case UColor.primary:
        return 'accent-green-500';
      case UColor.secondary:
        return 'accent-blue-500';
      case UColor.success:
        return 'accent-green-500';
      case UColor.info:
        return 'accent-blue-500';
      case UColor.warning:
        return 'accent-yellow-500';
      case UColor.error:
        return 'accent-red-500';
      case UColor.neutral:
        return 'accent-slate-500';
    }
  }

  void _handleInput(String value) {
    final doubleValue = double.tryParse(value) ?? component.min;
    setState(() => _value = doubleValue);
    component.onChange?.call(doubleValue);
  }

  @override
  Component build(BuildContext context) {
    final baseClasses = cx([
      'w-full',
      _trackHeightClass,
      'bg-gray-200',
      'dark:bg-gray-700',
      'rounded-lg',
      'appearance-none',
      'cursor-pointer',
      _accentColor,
      component.disabled ? 'opacity-50 cursor-not-allowed' : null,
    ]);

    return div(classes: 'space-y-2', [
      if (component.label != null || component.showValue)
        div(classes: 'flex justify-between items-center', [
          if (component.label != null)
            span(
              classes:
                  'block text-sm font-medium text-gray-700 dark:text-gray-200',
              [Component.text(component.label!)],
            )
          else
            span([]),
          if (component.showValue)
            span(
              classes: 'text-sm font-medium text-gray-500 dark:text-gray-400',
              [
                Component.text(
                    _value.toStringAsFixed(component.step < 1 ? 1 : 0))
              ],
            ),
        ]),
      input(
        type: InputType.range,
        name: component.name,
        value: _value.toString(),
        disabled: component.disabled,
        classes: baseClasses,
        attributes: {
          'min': component.min.toString(),
          'max': component.max.toString(),
          'step': component.step.toString(),
        },
        events: {
          'input': (event) {
            final target = event.target as dynamic;
            _handleInput(target.value as String);
          },
        },
      ),
      if (component.hint != null)
        p(
          classes: 'text-sm text-gray-500 dark:text-gray-400',
          [Component.text(component.hint!)],
        ),
    ]);
  }
}
