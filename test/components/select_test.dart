import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/form/select.dart';

void main() {
  group('DSelect', () {
    final testOptions = [
      DSelectOption(value: 'option1', label: 'Option 1'),
      DSelectOption(value: 'option2', label: 'Option 2'),
      DSelectOption(value: 'option3', label: 'Option 3'),
    ];

    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(
          DSelect<String>(options: testOptions),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            label: 'Select option',
            options: testOptions,
          ),
        );

        expect(find.text('Select option'), findsOneComponent);
      });

      testComponents('renders with placeholder', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            placeholder: 'Choose an option...',
          ),
        );

        expect(find.text('Choose an option...'), findsOneComponent);
      });

      testComponents('renders default placeholder when none provided',
          (tester) async {
        tester.pumpComponent(
          DSelect<String>(options: testOptions),
        );

        expect(find.text('Select...'), findsOneComponent);
      });

      testComponents('renders with selected value', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            value: 'option2',
          ),
        );

        expect(find.text('Option 2'), findsOneComponent);
      });

      testComponents('renders with hint text', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            label: 'Country',
            options: testOptions,
            hint: 'Select your country',
          ),
        );

        expect(find.text('Country'), findsOneComponent);
        expect(find.text('Select your country'), findsOneComponent);
      });

      testComponents('renders with error message', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            label: 'Category',
            options: testOptions,
            error: 'Please select a category',
          ),
        );

        expect(find.text('Category'), findsOneComponent);
        expect(find.text('Please select a category'), findsOneComponent);
      });

      testComponents('renders required indicator', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            label: 'Required field',
            options: testOptions,
            required: true,
          ),
        );

        expect(find.text('Required field'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders with leading icon', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            leadingIcon: span([Component.text('@')]),
          ),
        );

        expect(find.text('@'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            size: DSelectSize.xs,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            size: DSelectSize.sm,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            size: DSelectSize.md,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            size: DSelectSize.lg,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            size: DSelectSize.xl,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            color: DSelectColor.primary,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders gray color', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            color: DSelectColor.gray,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            color: DSelectColor.success,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            color: DSelectColor.warning,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            color: DSelectColor.error,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            disabled: true,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with disabled options', (tester) async {
        final mixedOptions = [
          DSelectOption(value: 'opt1', label: 'Enabled'),
          DSelectOption(value: 'opt2', label: 'Disabled', disabled: true),
          DSelectOption(value: 'opt3', label: 'Also Enabled'),
        ];

        tester.pumpComponent(
          DSelect<String>(options: mixedOptions),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('features', () {
      testComponents('renders with searchable enabled', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            searchable: true,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with clearable enabled', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            clearable: true,
            value: 'option1',
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with multiple enabled', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            multiple: true,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('option groups', () {
      testComponents('renders with option groups', (tester) async {
        final optionGroups = [
          DSelectOptionGroup(
            label: 'Fruits',
            options: [
              DSelectOption(value: 'apple', label: 'Apple'),
              DSelectOption(value: 'banana', label: 'Banana'),
            ],
          ),
          DSelectOptionGroup(
            label: 'Vegetables',
            options: [
              DSelectOption(value: 'carrot', label: 'Carrot'),
              DSelectOption(value: 'broccoli', label: 'Broccoli'),
            ],
          ),
        ];

        tester.pumpComponent(
          DSelect<String>(
            options: [],
            optionGroups: optionGroups,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('form attributes', () {
      testComponents('renders with name attribute', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            name: 'country-select',
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('error state styling', () {
      testComponents('shows error instead of hint when error present',
          (tester) async {
        tester.pumpComponent(
          DSelect<String>(
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
          DSelect<String>(
            options: testOptions,
            onChange: (value) {},
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('onChangeMultiple callback is provided', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            options: testOptions,
            multiple: true,
            onChangeMultiple: (values) {},
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with all props combined', (tester) async {
        tester.pumpComponent(
          DSelect<String>(
            label: 'Country',
            placeholder: 'Select a country',
            options: testOptions,
            value: 'option1',
            name: 'country',
            size: DSelectSize.lg,
            color: DSelectColor.primary,
            searchable: true,
            hint: 'Choose your country',
          ),
        );

        expect(find.text('Country'), findsOneComponent);
        expect(find.text('Option 1'), findsOneComponent);
        expect(find.text('Choose your country'), findsOneComponent);
      });
    });

    group('DSelectOption', () {
      testComponents('option with all properties', (tester) async {
        final optionWithAll = [
          DSelectOption(
            value: 'full',
            label: 'Full Option',
            disabled: false,
            icon: 'star',
          ),
        ];

        tester.pumpComponent(
          DSelect<String>(options: optionWithAll),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('DSelectOptionGroup', () {
      testComponents('option group with options', (tester) async {
        final groups = [
          DSelectOptionGroup(
            label: 'Group A',
            options: [
              DSelectOption(value: 'a1', label: 'A1'),
              DSelectOption(value: 'a2', label: 'A2'),
            ],
          ),
        ];

        tester.pumpComponent(
          DSelect<String>(options: [], optionGroups: groups),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('generic type support', () {
      testComponents('works with int values', (tester) async {
        final intOptions = [
          DSelectOption<int>(value: 1, label: 'One'),
          DSelectOption<int>(value: 2, label: 'Two'),
          DSelectOption<int>(value: 3, label: 'Three'),
        ];

        tester.pumpComponent(
          DSelect<int>(
            options: intOptions,
            value: 2,
          ),
        );

        expect(find.text('Two'), findsOneComponent);
      });
    });

    group('dropdown indicator', () {
      testComponents('renders chevron down icon', (tester) async {
        tester.pumpComponent(
          DSelect<String>(options: testOptions),
        );

        // DIcon renders an iconify-icon custom element inside a span
        expect(find.tag('iconify-icon'), findsOneComponent);
      });
    });
  });
}
