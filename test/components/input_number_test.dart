import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/form/input_number.dart';
import 'package:duxt_ui/src/theme/colors.dart';

void main() {
  group('DInputNumber', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DInputNumber());

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(
          DInputNumber(label: 'Quantity'),
        );

        expect(find.text('Quantity'), findsOneComponent);
        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with placeholder', (tester) async {
        tester.pumpComponent(
          DInputNumber(placeholder: 'Enter amount'),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with custom value', (tester) async {
        tester.pumpComponent(
          DInputNumber(value: 42),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with hint text', (tester) async {
        tester.pumpComponent(
          DInputNumber(
            label: 'Age',
            hint: 'Enter your age',
          ),
        );

        expect(find.text('Age'), findsOneComponent);
        expect(find.text('Enter your age'), findsOneComponent);
      });

      testComponents('renders with error message', (tester) async {
        tester.pumpComponent(
          DInputNumber(
            label: 'Quantity',
            error: 'Value must be positive',
          ),
        );

        expect(find.text('Quantity'), findsOneComponent);
        expect(find.text('Value must be positive'), findsOneComponent);
      });

      testComponents('renders required indicator', (tester) async {
        tester.pumpComponent(
          DInputNumber(label: 'Amount', required: true),
        );

        expect(find.text('Amount'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders increment and decrement buttons', (tester) async {
        tester.pumpComponent(DInputNumber());

        expect(find.tag('button'), findsComponents);
        expect(find.text('+'), findsOneComponent);
        expect(find.text('-'), findsOneComponent);
      });
    });

    group('range configuration', () {
      testComponents('renders with custom min and max', (tester) async {
        tester.pumpComponent(
          DInputNumber(
            min: 1,
            max: 10,
            value: 5,
          ),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with custom step', (tester) async {
        tester.pumpComponent(
          DInputNumber(
            step: 0.5,
            value: 2.5,
          ),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with infinite range by default', (tester) async {
        tester.pumpComponent(
          DInputNumber(value: 1000),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DInputNumber(size: DInputNumberSize.xs),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DInputNumber(size: DInputNumberSize.sm),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DInputNumber(size: DInputNumberSize.md),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DInputNumber(size: DInputNumberSize.lg),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DInputNumber(size: DInputNumberSize.xl),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders all sizes', (tester) async {
        for (final size in DInputNumberSize.values) {
          tester.pumpComponent(
            DInputNumber(size: size),
          );

          expect(find.tag('input'), findsOneComponent);
        }
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DInputNumber(color: DColor.primary),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(
          DInputNumber(color: DColor.secondary),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DInputNumber(color: DColor.success),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          DInputNumber(color: DColor.warning),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DInputNumber(color: DColor.error),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders neutral color', (tester) async {
        tester.pumpComponent(
          DInputNumber(color: DColor.neutral),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders all colors', (tester) async {
        for (final color in DColor.values) {
          tester.pumpComponent(
            DInputNumber(color: color),
          );

          expect(find.tag('input'), findsOneComponent);
        }
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DInputNumber(disabled: true),
        );

        expect(find.tag('input'), findsOneComponent);
        expect(find.tag('button'), findsComponents);
      });

      testComponents('renders enabled state by default', (tester) async {
        tester.pumpComponent(
          DInputNumber(),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('error state styling', () {
      testComponents('shows error instead of hint when error present',
          (tester) async {
        tester.pumpComponent(
          DInputNumber(
            hint: 'Enter a number',
            error: 'Invalid value',
          ),
        );

        expect(find.text('Invalid value'), findsOneComponent);
        expect(find.text('Enter a number'), findsNothing);
      });

      testComponents('shows hint when no error', (tester) async {
        tester.pumpComponent(
          DInputNumber(
            hint: 'Enter a positive number',
          ),
        );

        expect(find.text('Enter a positive number'), findsOneComponent);
      });
    });

    group('form integration', () {
      testComponents('renders with name attribute', (tester) async {
        tester.pumpComponent(
          DInputNumber(name: 'quantity_input'),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('interactions', () {
      testComponents('onChange callback can be set', (tester) async {
        double? changedValue;
        tester.pumpComponent(
          DInputNumber(
            value: 10,
            onChange: (value) {
              changedValue = value;
            },
          ),
        );

        expect(find.tag('input'), findsOneComponent);
        expect(find.tag('button'), findsComponents);
      });
    });

    group('complete configurations', () {
      testComponents('renders with all props', (tester) async {
        tester.pumpComponent(
          DInputNumber(
            label: 'Product Quantity',
            value: 5,
            min: 1,
            max: 100,
            step: 1,
            name: 'product_qty',
            placeholder: 'Enter quantity',
            size: DInputNumberSize.lg,
            color: DColor.primary,
            disabled: false,
            required: true,
            hint: 'Maximum 100 items',
          ),
        );

        expect(find.tag('input'), findsOneComponent);
        expect(find.text('Product Quantity'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
        expect(find.text('Maximum 100 items'), findsOneComponent);
        expect(find.text('+'), findsOneComponent);
        expect(find.text('-'), findsOneComponent);
      });

      testComponents('renders with error state and required', (tester) async {
        tester.pumpComponent(
          DInputNumber(
            label: 'Count',
            required: true,
            error: 'This field is required',
          ),
        );

        expect(find.text('Count'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
        expect(find.text('This field is required'), findsOneComponent);
      });
    });
  });
}
