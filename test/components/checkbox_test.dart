import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/form/checkbox.dart';

void main() {
  group('DCheckbox', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DCheckbox());

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(
          DCheckbox(label: 'Accept terms'),
        );

        expect(find.text('Accept terms'), findsOneComponent);
        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with description', (tester) async {
        tester.pumpComponent(
          DCheckbox(
            label: 'Newsletter',
            description: 'Receive weekly updates',
          ),
        );

        expect(find.text('Newsletter'), findsOneComponent);
        expect(find.text('Receive weekly updates'), findsOneComponent);
      });

      testComponents('renders with hint text', (tester) async {
        tester.pumpComponent(
          DCheckbox(
            label: 'Terms',
            hint: 'Please review our terms',
          ),
        );

        expect(find.text('Terms'), findsOneComponent);
        expect(find.text('Please review our terms'), findsOneComponent);
      });

      testComponents('renders with error message', (tester) async {
        tester.pumpComponent(
          DCheckbox(
            label: 'Terms',
            error: 'You must accept the terms',
          ),
        );

        expect(find.text('Terms'), findsOneComponent);
        expect(find.text('You must accept the terms'), findsOneComponent);
      });

      testComponents('renders required indicator', (tester) async {
        tester.pumpComponent(
          DCheckbox(label: 'Accept', required: true),
        );

        expect(find.text('Accept'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders checked state', (tester) async {
        tester.pumpComponent(
          DCheckbox(checked: true),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders unchecked state', (tester) async {
        tester.pumpComponent(
          DCheckbox(checked: false),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DCheckbox(size: DCheckboxSize.xs),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DCheckbox(size: DCheckboxSize.sm),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DCheckbox(size: DCheckboxSize.md),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DCheckbox(size: DCheckboxSize.lg),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DCheckbox(size: DCheckboxSize.xl),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DCheckbox(color: DCheckboxColor.primary),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders gray color', (tester) async {
        tester.pumpComponent(
          DCheckbox(color: DCheckboxColor.gray),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DCheckbox(color: DCheckboxColor.success),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          DCheckbox(color: DCheckboxColor.warning),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DCheckbox(color: DCheckboxColor.error),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DCheckbox(disabled: true),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders indeterminate state', (tester) async {
        tester.pumpComponent(
          DCheckbox(indeterminate: true),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders disabled with label', (tester) async {
        tester.pumpComponent(
          DCheckbox(label: 'Disabled option', disabled: true),
        );

        expect(find.text('Disabled option'), findsOneComponent);
        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('form attributes', () {
      testComponents('renders with name attribute', (tester) async {
        tester.pumpComponent(
          DCheckbox(name: 'terms-checkbox'),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders required attribute', (tester) async {
        tester.pumpComponent(
          DCheckbox(required: true, label: 'Required field'),
        );

        expect(find.text('Required field'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });
    });

    group('error state styling', () {
      testComponents('shows error instead of hint when error present',
          (tester) async {
        tester.pumpComponent(
          DCheckbox(
            label: 'Terms',
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
          DCheckbox(
            onChange: (value) {},
          ),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with all props combined', (tester) async {
        tester.pumpComponent(
          DCheckbox(
            label: 'Complete task',
            description: 'Mark as completed',
            name: 'task-checkbox',
            checked: true,
            size: DCheckboxSize.lg,
            color: DCheckboxColor.success,
            hint: 'Click to toggle',
          ),
        );

        expect(find.text('Complete task'), findsOneComponent);
        expect(find.text('Mark as completed'), findsOneComponent);
        expect(find.text('Click to toggle'), findsOneComponent);
      });
    });
  });
}
