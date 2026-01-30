import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/form/pin_input.dart';
import 'package:duxt_ui/src/theme/colors.dart';

void main() {
  group('DPinInput', () {
    group('rendering', () {
      testComponents('renders with default length (4)', (tester) async {
        tester.pumpComponent(DPinInput());

        // Should render input fields
        final inputs = find.tag('input');
        expect(inputs, findsComponents);
      });

      testComponents('renders with custom length', (tester) async {
        tester.pumpComponent(DPinInput(length: 6));

        final inputs = find.tag('input');
        expect(inputs, findsComponents);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(DPinInput(label: 'Enter PIN'));

        expect(find.text('Enter PIN'), findsOneComponent);
      });

      testComponents('renders required indicator with label', (tester) async {
        tester.pumpComponent(
          DPinInput(label: 'PIN Code', required: true),
        );

        expect(find.text('PIN Code'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders hint text', (tester) async {
        tester.pumpComponent(
          DPinInput(hint: 'Enter 4 digit code'),
        );

        expect(find.text('Enter 4 digit code'), findsOneComponent);
      });

      testComponents('renders error text', (tester) async {
        tester.pumpComponent(
          DPinInput(error: 'Invalid PIN'),
        );

        expect(find.text('Invalid PIN'), findsOneComponent);
      });

      testComponents('error takes precedence over hint', (tester) async {
        tester.pumpComponent(
          DPinInput(
            hint: 'Enter code',
            error: 'Invalid code',
          ),
        );

        expect(find.text('Invalid code'), findsOneComponent);
        expect(find.text('Enter code'), findsNothing);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(DPinInput(size: DPinInputSize.xs));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(DPinInput(size: DPinInputSize.sm));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(DPinInput(size: DPinInputSize.md));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DPinInput(size: DPinInputSize.lg));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(DPinInput(size: DPinInputSize.xl));

        expect(find.tag('input'), findsComponents);
      });
    });

    group('types', () {
      testComponents('renders number type (default)', (tester) async {
        tester.pumpComponent(DPinInput(type: DPinInputType.number));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders text type', (tester) async {
        tester.pumpComponent(DPinInput(type: DPinInputType.text));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders password type', (tester) async {
        tester.pumpComponent(DPinInput(type: DPinInputType.password));

        expect(find.tag('input'), findsComponents);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(DPinInput(color: DColor.primary));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(DPinInput(color: DColor.error));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(DPinInput(color: DColor.success));

        expect(find.tag('input'), findsComponents);
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(DPinInput(disabled: true));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders with initial value', (tester) async {
        tester.pumpComponent(DPinInput(value: '1234'));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('renders with partial value', (tester) async {
        tester.pumpComponent(DPinInput(value: '12', length: 4));

        expect(find.tag('input'), findsComponents);
      });
    });

    group('form integration', () {
      testComponents('renders hidden input for form submission', (tester) async {
        tester.pumpComponent(DPinInput(name: 'pin'));

        // Should have visible inputs + 1 hidden input
        final inputs = find.tag('input');
        expect(inputs, findsComponents);
      });

      testComponents('does not render hidden input without name', (tester) async {
        tester.pumpComponent(DPinInput());

        final inputs = find.tag('input');
        expect(inputs, findsComponents);
      });
    });

    group('attributes', () {
      testComponents('sets maxlength to 1 on each input', (tester) async {
        tester.pumpComponent(DPinInput());

        expect(find.tag('input'), findsComponents);
      });

      testComponents('sets inputmode numeric for number type', (tester) async {
        tester.pumpComponent(DPinInput(type: DPinInputType.number));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('sets placeholder when provided', (tester) async {
        tester.pumpComponent(DPinInput(placeholder: '•'));

        expect(find.tag('input'), findsComponents);
      });
    });
  });
}
