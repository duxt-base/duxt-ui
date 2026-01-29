import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/input.dart';

void main() {
  group('DInput', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DInput());

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(
          DInput(label: 'Email'),
        );

        expect(find.text('Email'), findsOneComponent);
        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with placeholder', (tester) async {
        tester.pumpComponent(
          DInput(placeholder: 'Enter your email'),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with value', (tester) async {
        tester.pumpComponent(
          DInput(value: 'test@example.com'),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with hint text', (tester) async {
        tester.pumpComponent(
          DInput(
            label: 'Password',
            hint: 'Must be at least 8 characters',
          ),
        );

        expect(find.text('Password'), findsOneComponent);
        expect(find.text('Must be at least 8 characters'),
            findsOneComponent);
      });

      testComponents('renders with error message', (tester) async {
        tester.pumpComponent(
          DInput(
            label: 'Email',
            error: 'Invalid email format',
          ),
        );

        expect(find.text('Email'), findsOneComponent);
        expect(find.text('Invalid email format'), findsOneComponent);
      });

      testComponents('renders required indicator', (tester) async {
        tester.pumpComponent(
          DInput(label: 'Name', required: true),
        );

        expect(find.text('Name'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });
    });

    group('variants', () {
      testComponents('renders outline variant (default)', (tester) async {
        tester.pumpComponent(
          DInput(variant: DInputVariant.outline),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders soft variant', (tester) async {
        tester.pumpComponent(
          DInput(variant: DInputVariant.soft),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders subtle variant', (tester) async {
        tester.pumpComponent(
          DInput(variant: DInputVariant.subtle),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders ghost variant', (tester) async {
        tester.pumpComponent(
          DInput(variant: DInputVariant.ghost),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders none variant', (tester) async {
        tester.pumpComponent(
          DInput(variant: DInputVariant.none),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DInput(size: DInputSize.xs),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DInput(size: DInputSize.sm),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DInput(size: DInputSize.md),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DInput(size: DInputSize.lg),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DInput(size: DInputSize.xl),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('input types', () {
      testComponents('renders text type (default)', (tester) async {
        tester.pumpComponent(
          DInput(type: InputType.text),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders email type', (tester) async {
        tester.pumpComponent(
          DInput(type: InputType.email),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders password type', (tester) async {
        tester.pumpComponent(
          DInput(type: InputType.password),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders number type', (tester) async {
        tester.pumpComponent(
          DInput(type: InputType.number),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders tel type', (tester) async {
        tester.pumpComponent(
          DInput(type: InputType.tel),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders url type', (tester) async {
        tester.pumpComponent(
          DInput(type: InputType.url),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DInput(disabled: true),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders readonly state', (tester) async {
        tester.pumpComponent(
          DInput(readonly: true, value: 'Read only'),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders loading state', (tester) async {
        tester.pumpComponent(
          DInput(loading: true),
        );

        expect(find.tag('input'), findsOneComponent);
        // Loading spinner should be present
        expect(find.tag('span'), findsComponents);
      });
    });

    group('icons', () {
      testComponents('renders with leading icon', (tester) async {
        tester.pumpComponent(
          DInput(
            leadingIcon: span([Component.text('@')]),
          ),
        );

        expect(find.tag('input'), findsOneComponent);
        expect(find.text('@'), findsOneComponent);
      });

      testComponents('renders with trailing icon', (tester) async {
        tester.pumpComponent(
          DInput(
            trailingIcon: span([Component.text('x')]),
          ),
        );

        expect(find.tag('input'), findsOneComponent);
        expect(find.text('x'), findsOneComponent);
      });

      testComponents('renders with both icons', (tester) async {
        tester.pumpComponent(
          DInput(
            leadingIcon: span([Component.text('@')]),
            trailingIcon: span([Component.text('x')]),
          ),
        );

        expect(find.text('@'), findsOneComponent);
        expect(find.text('x'), findsOneComponent);
      });
    });

    group('interactions', () {
      testComponents('onInput callback fires', (tester) async {
        tester.pumpComponent(
          DInput(
            onInput: (value) {},
          ),
        );

        expect(find.tag('input'), findsOneComponent);
        // Note: Direct input value change testing may require browser environment
      });
    });

    group('error state styling', () {
      testComponents('shows error instead of hint when error present',
          (tester) async {
        tester.pumpComponent(
          DInput(
            hint: 'Helper text',
            error: 'Error message',
          ),
        );

        expect(find.text('Error message'), findsOneComponent);
        expect(find.text('Helper text'), findsNothing);
      });
    });
  });

  group('DTextarea', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DTextarea());

        expect(find.tag('textarea'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(
          DTextarea(label: 'Description'),
        );

        expect(find.text('Description'), findsOneComponent);
      });

      testComponents('renders with placeholder', (tester) async {
        tester.pumpComponent(
          DTextarea(placeholder: 'Enter description...'),
        );

        expect(find.tag('textarea'), findsOneComponent);
      });

      testComponents('renders with value', (tester) async {
        tester.pumpComponent(
          DTextarea(value: 'Initial content'),
        );

        expect(find.text('Initial content'), findsOneComponent);
      });

      testComponents('renders with hint', (tester) async {
        tester.pumpComponent(
          DTextarea(
            label: 'Bio',
            hint: 'Max 500 characters',
          ),
        );

        expect(find.text('Bio'), findsOneComponent);
        expect(find.text('Max 500 characters'), findsOneComponent);
      });

      testComponents('renders with error', (tester) async {
        tester.pumpComponent(
          DTextarea(
            label: 'Message',
            error: 'This field is required',
          ),
        );

        expect(find.text('Message'), findsOneComponent);
        expect(
            find.text('This field is required'), findsOneComponent);
      });

      testComponents('renders required indicator', (tester) async {
        tester.pumpComponent(
          DTextarea(label: 'Comments', required: true),
        );

        expect(find.text('Comments'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });
    });

    group('variants', () {
      testComponents('renders outline variant (default)', (tester) async {
        tester.pumpComponent(
          DTextarea(variant: DInputVariant.outline),
        );

        expect(find.tag('textarea'), findsOneComponent);
      });

      testComponents('renders soft variant', (tester) async {
        tester.pumpComponent(
          DTextarea(variant: DInputVariant.soft),
        );

        expect(find.tag('textarea'), findsOneComponent);
      });

      testComponents('renders subtle variant', (tester) async {
        tester.pumpComponent(
          DTextarea(variant: DInputVariant.subtle),
        );

        expect(find.tag('textarea'), findsOneComponent);
      });

      testComponents('renders ghost variant', (tester) async {
        tester.pumpComponent(
          DTextarea(variant: DInputVariant.ghost),
        );

        expect(find.tag('textarea'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders all sizes', (tester) async {
        for (final size in DInputSize.values) {
          tester.pumpComponent(
            DTextarea(size: size),
          );

          expect(find.tag('textarea'), findsOneComponent);
        }
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DTextarea(disabled: true),
        );

        expect(find.tag('textarea'), findsOneComponent);
      });
    });
  });
}
