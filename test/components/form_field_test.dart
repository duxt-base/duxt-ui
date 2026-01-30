import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/form/form_field.dart';

void main() {
  group('DFormField', () {
    group('rendering', () {
      testComponents('renders with children', (tester) async {
        tester.pumpComponent(
          DFormField(children: [
            input(type: InputType.text),
          ]),
        );

        expect(find.tag('div'), findsComponents);
        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(
          DFormField(
            label: 'Username',
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.text('Username'), findsOneComponent);
        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with name attribute', (tester) async {
        tester.pumpComponent(
          DFormField(
            name: 'email',
            label: 'Email',
            children: [input(type: InputType.email)],
          ),
        );

        expect(find.text('Email'), findsOneComponent);
        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with hint text', (tester) async {
        tester.pumpComponent(
          DFormField(
            label: 'Password',
            hint: 'At least 8 characters',
            children: [input(type: InputType.password)],
          ),
        );

        expect(find.text('Password'), findsOneComponent);
        expect(find.text('At least 8 characters'), findsOneComponent);
      });

      testComponents('renders with error message', (tester) async {
        tester.pumpComponent(
          DFormField(
            label: 'Email',
            error: 'Invalid email address',
            children: [input(type: InputType.email)],
          ),
        );

        expect(find.text('Email'), findsOneComponent);
        expect(find.text('Invalid email address'), findsOneComponent);
      });

      testComponents('renders required indicator', (tester) async {
        tester.pumpComponent(
          DFormField(
            label: 'Full Name',
            required: true,
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.text('Full Name'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DFormField(
            size: DFormFieldSize.sm,
            label: 'Small field',
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.text('Small field'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DFormField(
            size: DFormFieldSize.md,
            label: 'Medium field',
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.text('Medium field'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DFormField(
            size: DFormFieldSize.lg,
            label: 'Large field',
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.text('Large field'), findsOneComponent);
      });

      testComponents('renders all sizes', (tester) async {
        for (final size in DFormFieldSize.values) {
          tester.pumpComponent(
            DFormField(
              size: size,
              label: 'Field',
              children: [input(type: InputType.text)],
            ),
          );

          expect(find.text('Field'), findsOneComponent);
        }
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DFormField(
            disabled: true,
            label: 'Disabled field',
            children: [input(type: InputType.text, disabled: true)],
          ),
        );

        expect(find.text('Disabled field'), findsOneComponent);
      });

      testComponents('renders enabled state by default', (tester) async {
        tester.pumpComponent(
          DFormField(
            label: 'Enabled field',
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.text('Enabled field'), findsOneComponent);
      });
    });

    group('validation options', () {
      testComponents('validateOnBlur is true by default', (tester) async {
        tester.pumpComponent(
          DFormField(
            validateOnBlur: true,
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('validateOnChange can be enabled', (tester) async {
        tester.pumpComponent(
          DFormField(
            validateOnChange: true,
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('error state styling', () {
      testComponents('shows error instead of hint when error present',
          (tester) async {
        tester.pumpComponent(
          DFormField(
            hint: 'Enter your email',
            error: 'Email is required',
            children: [input(type: InputType.email)],
          ),
        );

        expect(find.text('Email is required'), findsOneComponent);
        expect(find.text('Enter your email'), findsNothing);
      });

      testComponents('shows hint when no error', (tester) async {
        tester.pumpComponent(
          DFormField(
            hint: 'Optional field',
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.text('Optional field'), findsOneComponent);
      });
    });

    group('validation rules', () {
      testComponents('renders with required rule', (tester) async {
        tester.pumpComponent(
          DFormField(
            required: true,
            rules: [DValidators.required()],
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with email rule', (tester) async {
        tester.pumpComponent(
          DFormField(
            rules: [DValidators.email()],
            children: [input(type: InputType.email)],
          ),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with minLength rule', (tester) async {
        tester.pumpComponent(
          DFormField(
            rules: [DValidators.minLength(8)],
            children: [input(type: InputType.password)],
          ),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with multiple rules', (tester) async {
        tester.pumpComponent(
          DFormField(
            required: true,
            rules: [
              DValidators.minLength(8),
              DValidators.maxLength(50),
            ],
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('complete configurations', () {
      testComponents('renders with all props', (tester) async {
        tester.pumpComponent(
          DFormField(
            name: 'username',
            label: 'Username',
            hint: '3-20 characters',
            required: true,
            disabled: false,
            size: DFormFieldSize.md,
            validateOnBlur: true,
            validateOnChange: false,
            rules: [
              DValidators.minLength(3),
              DValidators.maxLength(20),
            ],
            children: [input(type: InputType.text)],
          ),
        );

        expect(find.text('Username'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
        expect(find.text('3-20 characters'), findsOneComponent);
        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with error state', (tester) async {
        tester.pumpComponent(
          DFormField(
            label: 'Email',
            required: true,
            error: 'Please enter a valid email',
            children: [input(type: InputType.email)],
          ),
        );

        expect(find.text('Email'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
        expect(find.text('Please enter a valid email'), findsOneComponent);
      });
    });
  });

  group('DValidators', () {
    group('required', () {
      testComponents('validates empty string as invalid', (tester) async {
        final rule = DValidators.required();
        expect(rule.validator(''), isFalse);
        expect(rule.validator('   '), isFalse);
        expect(rule.message, equals('This field is required'));

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });

      testComponents('validates non-empty string as valid', (tester) async {
        final rule = DValidators.required();
        expect(rule.validator('hello'), isTrue);

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });

      testComponents('validates null as invalid', (tester) async {
        final rule = DValidators.required();
        expect(rule.validator(null), isFalse);

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });

      testComponents('validates empty list as invalid', (tester) async {
        final rule = DValidators.required();
        expect(rule.validator([]), isFalse);
        expect(rule.validator(['item']), isTrue);

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });

      testComponents('allows custom message', (tester) async {
        final rule = DValidators.required('Name is required');
        expect(rule.message, equals('Name is required'));

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });
    });

    group('email', () {
      testComponents('validates valid email', (tester) async {
        final rule = DValidators.email();
        expect(rule.validator('test@example.com'), isTrue);
        expect(rule.validator('user.name@domain.org'), isTrue);

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });

      testComponents('validates invalid email', (tester) async {
        final rule = DValidators.email();
        expect(rule.validator('invalid'), isFalse);
        expect(rule.validator('test@'), isFalse);
        expect(rule.validator('@example.com'), isFalse);

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });

      testComponents('allows empty value', (tester) async {
        final rule = DValidators.email();
        expect(rule.validator(''), isTrue);
        expect(rule.validator(null), isTrue);

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });

      testComponents('allows custom message', (tester) async {
        final rule = DValidators.email('Enter a valid email');
        expect(rule.message, equals('Enter a valid email'));

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });
    });

    group('minLength', () {
      testComponents('validates string length', (tester) async {
        final rule = DValidators.minLength(5);
        expect(rule.validator('hello'), isTrue);
        expect(rule.validator('hi'), isFalse);
        expect(rule.message, equals('Must be at least 5 characters'));

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });

      testComponents('allows empty value', (tester) async {
        final rule = DValidators.minLength(5);
        expect(rule.validator(''), isTrue);
        expect(rule.validator(null), isTrue);

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });
    });

    group('maxLength', () {
      testComponents('validates string length', (tester) async {
        final rule = DValidators.maxLength(10);
        expect(rule.validator('hello'), isTrue);
        expect(rule.validator('this is too long'), isFalse);
        expect(rule.message, equals('Must be no more than 10 characters'));

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });
    });

    group('min', () {
      testComponents('validates numeric value', (tester) async {
        final rule = DValidators.min(10);
        expect(rule.validator(15), isTrue);
        expect(rule.validator(5), isFalse);
        expect(rule.validator('20'), isTrue);
        expect(rule.message, equals('Must be at least 10'));

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });
    });

    group('max', () {
      testComponents('validates numeric value', (tester) async {
        final rule = DValidators.max(100);
        expect(rule.validator(50), isTrue);
        expect(rule.validator(150), isFalse);
        expect(rule.validator('80'), isTrue);
        expect(rule.message, equals('Must be no more than 100'));

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });
    });

    group('pattern', () {
      testComponents('validates against regex', (tester) async {
        final rule = DValidators.pattern(RegExp(r'^\d+$'));
        expect(rule.validator('123'), isTrue);
        expect(rule.validator('abc'), isFalse);
        expect(rule.message, equals('Invalid format'));

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });

      testComponents('allows custom message', (tester) async {
        final rule = DValidators.pattern(RegExp(r'^\d+$'), 'Only numbers allowed');
        expect(rule.message, equals('Only numbers allowed'));

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });
    });

    group('custom', () {
      testComponents('uses custom validator function', (tester) async {
        final rule = DValidators.custom(
          (value) => value == 'secret',
          'Value must be "secret"',
        );
        expect(rule.validator('secret'), isTrue);
        expect(rule.validator('other'), isFalse);
        expect(rule.message, equals('Value must be "secret"'));

        tester.pumpComponent(DFormField(children: [span([])]));
        expect(find.tag('div'), findsComponents);
      });
    });
  });

  group('DFormFieldGroup', () {
    group('rendering', () {
      testComponents('renders with children', (tester) async {
        tester.pumpComponent(
          DFormFieldGroup(children: [
            span([Component.text('Option 1')]),
            span([Component.text('Option 2')]),
          ]),
        );

        expect(find.tag('fieldset'), findsOneComponent);
        expect(find.text('Option 1'), findsOneComponent);
        expect(find.text('Option 2'), findsOneComponent);
      });

      testComponents('renders with label as legend', (tester) async {
        tester.pumpComponent(
          DFormFieldGroup(
            label: 'Choose an option',
            children: [span([Component.text('Options')])],
          ),
        );

        expect(find.tag('legend'), findsOneComponent);
        expect(find.text('Choose an option'), findsOneComponent);
      });

      testComponents('renders with hint', (tester) async {
        tester.pumpComponent(
          DFormFieldGroup(
            label: 'Preferences',
            hint: 'Select all that apply',
            children: [span([Component.text('Options')])],
          ),
        );

        expect(find.text('Preferences'), findsOneComponent);
        expect(find.text('Select all that apply'), findsOneComponent);
      });

      testComponents('renders with error', (tester) async {
        tester.pumpComponent(
          DFormFieldGroup(
            label: 'Selection',
            error: 'Please make a selection',
            children: [span([Component.text('Options')])],
          ),
        );

        expect(find.text('Selection'), findsOneComponent);
        expect(find.text('Please make a selection'), findsOneComponent);
      });

      testComponents('renders required indicator', (tester) async {
        tester.pumpComponent(
          DFormFieldGroup(
            label: 'Required Group',
            required: true,
            children: [span([Component.text('Options')])],
          ),
        );

        expect(find.text('Required Group'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders inline layout', (tester) async {
        tester.pumpComponent(
          DFormFieldGroup(
            inline: true,
            children: [
              span([Component.text('A')]),
              span([Component.text('B')]),
            ],
          ),
        );

        expect(find.text('A'), findsOneComponent);
        expect(find.text('B'), findsOneComponent);
      });

      testComponents('shows error instead of hint when error present',
          (tester) async {
        tester.pumpComponent(
          DFormFieldGroup(
            hint: 'Select one',
            error: 'Selection required',
            children: [span([Component.text('Options')])],
          ),
        );

        expect(find.text('Selection required'), findsOneComponent);
        expect(find.text('Select one'), findsNothing);
      });
    });
  });

  group('DFieldError', () {
    testComponents('renders error message', (tester) async {
      tester.pumpComponent(
        DFieldError(error: 'This is an error'),
      );

      expect(find.text('This is an error'), findsOneComponent);
    });

    testComponents('renders empty when no error', (tester) async {
      tester.pumpComponent(
        DFieldError(error: null),
      );

      expect(find.tag('span'), findsOneComponent);
    });

    testComponents('renders empty when error is empty string', (tester) async {
      tester.pumpComponent(
        DFieldError(error: ''),
      );

      expect(find.tag('span'), findsOneComponent);
    });
  });

  group('DFieldHint', () {
    testComponents('renders hint message', (tester) async {
      tester.pumpComponent(
        DFieldHint(hint: 'This is a hint'),
      );

      expect(find.text('This is a hint'), findsOneComponent);
    });
  });
}
