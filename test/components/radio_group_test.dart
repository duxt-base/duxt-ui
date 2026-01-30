import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/form/radio_group.dart';

void main() {
  group('DRadioGroup', () {
    final testOptions = [
      DRadioOption(value: 'option1', label: 'Option 1'),
      DRadioOption(value: 'option2', label: 'Option 2'),
      DRadioOption(value: 'option3', label: 'Option 3'),
    ];

    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(options: testOptions, name: 'test-radio'),
        );

        expect(find.tag('fieldset'), findsOneComponent);
        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders all options', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(options: testOptions, name: 'test-radio'),
        );

        expect(find.text('Option 1'), findsOneComponent);
        expect(find.text('Option 2'), findsOneComponent);
        expect(find.text('Option 3'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            label: 'Select one option',
            options: testOptions,
            name: 'test-radio',
          ),
        );

        expect(find.text('Select one option'), findsOneComponent);
      });

      testComponents('renders with hint text', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            label: 'Payment method',
            options: testOptions,
            name: 'payment',
            hint: 'Choose your preferred payment',
          ),
        );

        expect(find.text('Payment method'), findsOneComponent);
        expect(find.text('Choose your preferred payment'), findsOneComponent);
      });

      testComponents('renders with error message', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            label: 'Options',
            options: testOptions,
            name: 'required-radio',
            error: 'Please select an option',
          ),
        );

        expect(find.text('Options'), findsOneComponent);
        expect(find.text('Please select an option'), findsOneComponent);
      });

      testComponents('renders required indicator', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            label: 'Required choice',
            options: testOptions,
            name: 'required-radio',
            required: true,
          ),
        );

        expect(find.text('Required choice'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders with selected value', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            value: 'option2',
          ),
        );

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders options with descriptions', (tester) async {
        final optionsWithDesc = [
          DRadioOption(
            value: 'basic',
            label: 'Basic Plan',
            description: 'Free forever',
          ),
          DRadioOption(
            value: 'pro',
            label: 'Pro Plan',
            description: '\$9.99/month',
          ),
        ];

        tester.pumpComponent(
          DRadioGroup<String>(options: optionsWithDesc, name: 'plan'),
        );

        expect(find.text('Basic Plan'), findsOneComponent);
        expect(find.text('Free forever'), findsOneComponent);
        expect(find.text('Pro Plan'), findsOneComponent);
        expect(find.text('\$9.99/month'), findsOneComponent);
      });
    });

    group('orientation', () {
      testComponents('renders vertical orientation (default)', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            orientation: DRadioGroupOrientation.vertical,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders horizontal orientation', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            orientation: DRadioGroupOrientation.horizontal,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            size: DRadioGroupSize.xs,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            size: DRadioGroupSize.sm,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            size: DRadioGroupSize.md,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            size: DRadioGroupSize.lg,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            size: DRadioGroupSize.xl,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            color: DRadioGroupColor.primary,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders gray color', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            color: DRadioGroupColor.gray,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            color: DRadioGroupColor.success,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            color: DRadioGroupColor.warning,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            color: DRadioGroupColor.error,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            disabled: true,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders with individually disabled options',
          (tester) async {
        final mixedOptions = [
          DRadioOption(value: 'opt1', label: 'Enabled'),
          DRadioOption(value: 'opt2', label: 'Disabled', disabled: true),
          DRadioOption(value: 'opt3', label: 'Also Enabled'),
        ];

        tester.pumpComponent(
          DRadioGroup<String>(options: mixedOptions, name: 'mixed-radio'),
        );

        expect(find.text('Enabled'), findsOneComponent);
        expect(find.text('Disabled'), findsOneComponent);
        expect(find.text('Also Enabled'), findsOneComponent);
      });
    });

    group('form attributes', () {
      testComponents('renders with name attribute', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'subscription-type',
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });
    });

    group('error state styling', () {
      testComponents('shows error instead of hint when error present',
          (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            hint: 'Optional hint',
            error: 'Error message',
          ),
        );

        expect(find.text('Error message'), findsOneComponent);
        expect(find.text('Optional hint'), findsNothing);
      });
    });

    group('interactions', () {
      testComponents('onChange callback is provided', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            options: testOptions,
            name: 'test-radio',
            onChange: (value) {},
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders with all props combined', (tester) async {
        tester.pumpComponent(
          DRadioGroup<String>(
            label: 'Choose plan',
            options: testOptions,
            name: 'plan-radio',
            value: 'option1',
            size: DRadioGroupSize.lg,
            color: DRadioGroupColor.success,
            orientation: DRadioGroupOrientation.horizontal,
            hint: 'Select your subscription',
          ),
        );

        expect(find.text('Choose plan'), findsOneComponent);
        expect(find.text('Option 1'), findsOneComponent);
        expect(find.text('Select your subscription'), findsOneComponent);
      });
    });

    group('DRadioOption', () {
      testComponents('option with all properties', (tester) async {
        final optionWithAll = [
          DRadioOption(
            value: 'full',
            label: 'Full Option',
            description: 'This has all properties',
            disabled: false,
          ),
        ];

        tester.pumpComponent(
          DRadioGroup<String>(options: optionWithAll, name: 'full-radio'),
        );

        expect(find.text('Full Option'), findsOneComponent);
        expect(find.text('This has all properties'), findsOneComponent);
      });
    });

    group('generic type support', () {
      testComponents('works with int values', (tester) async {
        final intOptions = [
          DRadioOption<int>(value: 1, label: 'One'),
          DRadioOption<int>(value: 2, label: 'Two'),
          DRadioOption<int>(value: 3, label: 'Three'),
        ];

        tester.pumpComponent(
          DRadioGroup<int>(
            options: intOptions,
            name: 'int-radio',
            value: 2,
          ),
        );

        expect(find.text('One'), findsOneComponent);
        expect(find.text('Two'), findsOneComponent);
        expect(find.text('Three'), findsOneComponent);
      });
    });
  });
}
