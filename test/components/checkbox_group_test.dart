import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/form/checkbox_group.dart';
import 'package:duxt_ui/src/components/form/checkbox.dart';

void main() {
  group('DCheckboxGroup', () {
    final testOptions = [
      DCheckboxOption(value: 'option1', label: 'Option 1'),
      DCheckboxOption(value: 'option2', label: 'Option 2'),
      DCheckboxOption(value: 'option3', label: 'Option 3'),
    ];

    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(options: testOptions),
        );

        expect(find.tag('fieldset'), findsOneComponent);
        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders all options', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(options: testOptions),
        );

        expect(find.text('Option 1'), findsOneComponent);
        expect(find.text('Option 2'), findsOneComponent);
        expect(find.text('Option 3'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            label: 'Select options',
            options: testOptions,
          ),
        );

        expect(find.text('Select options'), findsOneComponent);
      });

      testComponents('renders with hint text', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            label: 'Preferences',
            options: testOptions,
            hint: 'Select all that apply',
          ),
        );

        expect(find.text('Preferences'), findsOneComponent);
        expect(find.text('Select all that apply'), findsOneComponent);
      });

      testComponents('renders with error message', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            label: 'Options',
            options: testOptions,
            error: 'Please select at least one option',
          ),
        );

        expect(find.text('Options'), findsOneComponent);
        expect(find.text('Please select at least one option'), findsOneComponent);
      });

      testComponents('renders required indicator', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            label: 'Required options',
            options: testOptions,
            required: true,
          ),
        );

        expect(find.text('Required options'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders with selected values', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            value: ['option1', 'option3'],
          ),
        );

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders options with descriptions', (tester) async {
        final optionsWithDesc = [
          DCheckboxOption(
            value: 'opt1',
            label: 'First',
            description: 'First option description',
          ),
          DCheckboxOption(
            value: 'opt2',
            label: 'Second',
            description: 'Second option description',
          ),
        ];

        tester.pumpComponent(
          DCheckboxGroup<String>(options: optionsWithDesc),
        );

        expect(find.text('First'), findsOneComponent);
        expect(find.text('First option description'), findsOneComponent);
        expect(find.text('Second'), findsOneComponent);
        expect(find.text('Second option description'), findsOneComponent);
      });
    });

    group('orientation', () {
      testComponents('renders vertical orientation (default)', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            orientation: DCheckboxGroupOrientation.vertical,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders horizontal orientation', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            orientation: DCheckboxGroupOrientation.horizontal,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            size: DCheckboxSize.xs,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            size: DCheckboxSize.sm,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            size: DCheckboxSize.md,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            size: DCheckboxSize.lg,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            size: DCheckboxSize.xl,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            color: DCheckboxColor.primary,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders gray color', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            color: DCheckboxColor.gray,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            color: DCheckboxColor.success,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            color: DCheckboxColor.warning,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            color: DCheckboxColor.error,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            disabled: true,
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders with individually disabled options',
          (tester) async {
        final mixedOptions = [
          DCheckboxOption(value: 'opt1', label: 'Enabled'),
          DCheckboxOption(value: 'opt2', label: 'Disabled', disabled: true),
          DCheckboxOption(value: 'opt3', label: 'Also Enabled'),
        ];

        tester.pumpComponent(
          DCheckboxGroup<String>(options: mixedOptions),
        );

        expect(find.text('Enabled'), findsOneComponent);
        expect(find.text('Disabled'), findsOneComponent);
        expect(find.text('Also Enabled'), findsOneComponent);
      });
    });

    group('form attributes', () {
      testComponents('renders with name attribute', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
            name: 'preferences',
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });
    });

    group('error state styling', () {
      testComponents('shows error instead of hint when error present',
          (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            options: testOptions,
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
          DCheckboxGroup<String>(
            options: testOptions,
            onChange: (values) {},
          ),
        );

        expect(find.tag('fieldset'), findsOneComponent);
      });

      testComponents('renders with all props combined', (tester) async {
        tester.pumpComponent(
          DCheckboxGroup<String>(
            label: 'Select features',
            options: testOptions,
            value: ['option1'],
            name: 'features',
            size: DCheckboxSize.lg,
            color: DCheckboxColor.success,
            orientation: DCheckboxGroupOrientation.horizontal,
            hint: 'Choose your preferences',
          ),
        );

        expect(find.text('Select features'), findsOneComponent);
        expect(find.text('Option 1'), findsOneComponent);
        expect(find.text('Choose your preferences'), findsOneComponent);
      });
    });

    group('DCheckboxOption', () {
      testComponents('option with all properties', (tester) async {
        final optionWithAll = [
          DCheckboxOption(
            value: 'full',
            label: 'Full Option',
            description: 'This has all properties',
            disabled: false,
          ),
        ];

        tester.pumpComponent(
          DCheckboxGroup<String>(options: optionWithAll),
        );

        expect(find.text('Full Option'), findsOneComponent);
        expect(find.text('This has all properties'), findsOneComponent);
      });
    });
  });
}
