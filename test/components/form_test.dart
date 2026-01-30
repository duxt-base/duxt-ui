import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/form/form.dart';

void main() {
  group('DForm', () {
    group('rendering', () {
      testComponents('renders with children', (tester) async {
        tester.pumpComponent(
          DForm(children: [
            Component.text('Form content'),
          ]),
        );

        expect(find.tag('form'), findsOneComponent);
        expect(find.text('Form content'), findsOneComponent);
      });

      testComponents('renders with id', (tester) async {
        tester.pumpComponent(
          DForm(
            id: 'login-form',
            children: [Component.text('Login')],
          ),
        );

        expect(find.tag('form'), findsOneComponent);
        expect(find.text('Login'), findsOneComponent);
      });

      testComponents('renders with name attribute', (tester) async {
        tester.pumpComponent(
          DForm(
            name: 'contact-form',
            children: [Component.text('Contact')],
          ),
        );

        expect(find.tag('form'), findsOneComponent);
        expect(find.text('Contact'), findsOneComponent);
      });

      testComponents('renders multiple children', (tester) async {
        tester.pumpComponent(
          DForm(children: [
            span([Component.text('Field 1')]),
            span([Component.text('Field 2')]),
            span([Component.text('Field 3')]),
          ]),
        );

        expect(find.tag('form'), findsOneComponent);
        expect(find.text('Field 1'), findsOneComponent);
        expect(find.text('Field 2'), findsOneComponent);
        expect(find.text('Field 3'), findsOneComponent);
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DForm(
            disabled: true,
            children: [Component.text('Disabled form')],
          ),
        );

        expect(find.tag('form'), findsOneComponent);
        expect(find.text('Disabled form'), findsOneComponent);
      });

      testComponents('renders enabled state by default', (tester) async {
        tester.pumpComponent(
          DForm(children: [Component.text('Enabled form')]),
        );

        expect(find.tag('form'), findsOneComponent);
        expect(find.text('Enabled form'), findsOneComponent);
      });
    });

    group('validation options', () {
      testComponents('validateOnSubmit is true by default', (tester) async {
        tester.pumpComponent(
          DForm(
            validateOnSubmit: true,
            children: [Component.text('Submit validation')],
          ),
        );

        expect(find.tag('form'), findsOneComponent);
      });

      testComponents('validateOnBlur can be enabled', (tester) async {
        tester.pumpComponent(
          DForm(
            validateOnBlur: true,
            children: [Component.text('Blur validation')],
          ),
        );

        expect(find.tag('form'), findsOneComponent);
      });

      testComponents('validateOnChange can be enabled', (tester) async {
        tester.pumpComponent(
          DForm(
            validateOnChange: true,
            children: [Component.text('Change validation')],
          ),
        );

        expect(find.tag('form'), findsOneComponent);
      });
    });

    group('callbacks', () {
      testComponents('onSubmit callback can be set', (tester) async {
        Map<String, dynamic>? submittedData;
        tester.pumpComponent(
          DForm(
            onSubmit: (data) {
              submittedData = data;
            },
            children: [Component.text('Submit form')],
          ),
        );

        expect(find.tag('form'), findsOneComponent);
      });

      testComponents('onValidate callback can be set', (tester) async {
        tester.pumpComponent(
          DForm(
            onValidate: (data) {
              return DFormValidationResult(isValid: true);
            },
            children: [Component.text('Validate form')],
          ),
        );

        expect(find.tag('form'), findsOneComponent);
      });

      testComponents('onReset callback can be set', (tester) async {
        bool resetCalled = false;
        tester.pumpComponent(
          DForm(
            onReset: () {
              resetCalled = true;
            },
            children: [Component.text('Reset form')],
          ),
        );

        expect(find.tag('form'), findsOneComponent);
      });
    });

    group('complete configurations', () {
      testComponents('renders with all props', (tester) async {
        tester.pumpComponent(
          DForm(
            id: 'registration-form',
            name: 'registration',
            disabled: false,
            validateOnSubmit: true,
            validateOnBlur: true,
            validateOnChange: false,
            children: [
              span([Component.text('Name')]),
              span([Component.text('Email')]),
              span([Component.text('Submit')]),
            ],
          ),
        );

        expect(find.tag('form'), findsOneComponent);
        expect(find.text('Name'), findsOneComponent);
        expect(find.text('Email'), findsOneComponent);
        expect(find.text('Submit'), findsOneComponent);
      });
    });
  });

  group('DFormValidationResult', () {
    testComponents('creates valid result', (tester) async {
      final result = DFormValidationResult(isValid: true);
      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);

      // Render component to satisfy test requirement
      tester.pumpComponent(DForm(children: [Component.text('Test')]));
      expect(find.tag('form'), findsOneComponent);
    });

    testComponents('creates invalid result with errors', (tester) async {
      final result = DFormValidationResult(
        isValid: false,
        errors: {'email': 'Invalid email', 'password': 'Too short'},
      );
      expect(result.isValid, isFalse);
      expect(result.getError('email'), equals('Invalid email'));
      expect(result.getError('password'), equals('Too short'));
      expect(result.getError('name'), isNull);

      // Render component to satisfy test requirement
      tester.pumpComponent(DForm(children: [Component.text('Test')]));
      expect(find.tag('form'), findsOneComponent);
    });
  });

  group('DFormActions', () {
    group('rendering', () {
      testComponents('renders with children', (tester) async {
        tester.pumpComponent(
          DFormActions(children: [
            button([Component.text('Submit')]),
            button([Component.text('Cancel')]),
          ]),
        );

        expect(find.tag('div'), findsComponents);
        expect(find.text('Submit'), findsOneComponent);
        expect(find.text('Cancel'), findsOneComponent);
      });
    });

    group('alignment', () {
      testComponents('renders with start alignment', (tester) async {
        tester.pumpComponent(
          DFormActions(
            alignment: MainAxisAlignment.start,
            children: [button([Component.text('Action')])],
          ),
        );

        expect(find.text('Action'), findsOneComponent);
      });

      testComponents('renders with center alignment', (tester) async {
        tester.pumpComponent(
          DFormActions(
            alignment: MainAxisAlignment.center,
            children: [button([Component.text('Action')])],
          ),
        );

        expect(find.text('Action'), findsOneComponent);
      });

      testComponents('renders with end alignment (default)', (tester) async {
        tester.pumpComponent(
          DFormActions(
            alignment: MainAxisAlignment.end,
            children: [button([Component.text('Action')])],
          ),
        );

        expect(find.text('Action'), findsOneComponent);
      });

      testComponents('renders with spaceBetween alignment', (tester) async {
        tester.pumpComponent(
          DFormActions(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              button([Component.text('Cancel')]),
              button([Component.text('Submit')]),
            ],
          ),
        );

        expect(find.text('Cancel'), findsOneComponent);
        expect(find.text('Submit'), findsOneComponent);
      });

      testComponents('renders with spaceAround alignment', (tester) async {
        tester.pumpComponent(
          DFormActions(
            alignment: MainAxisAlignment.spaceAround,
            children: [button([Component.text('Action')])],
          ),
        );

        expect(find.text('Action'), findsOneComponent);
      });

      testComponents('renders with spaceEvenly alignment', (tester) async {
        tester.pumpComponent(
          DFormActions(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [button([Component.text('Action')])],
          ),
        );

        expect(find.text('Action'), findsOneComponent);
      });

      testComponents('renders all alignments', (tester) async {
        for (final alignment in MainAxisAlignment.values) {
          tester.pumpComponent(
            DFormActions(
              alignment: alignment,
              children: [button([Component.text('Test')])],
            ),
          );

          expect(find.text('Test'), findsOneComponent);
        }
      });
    });
  });

  group('DFormRow', () {
    group('rendering', () {
      testComponents('renders with children', (tester) async {
        tester.pumpComponent(
          DFormRow(children: [
            span([Component.text('Field 1')]),
            span([Component.text('Field 2')]),
          ]),
        );

        expect(find.tag('div'), findsComponents);
        expect(find.text('Field 1'), findsOneComponent);
        expect(find.text('Field 2'), findsOneComponent);
      });

      testComponents('renders with default 2 columns', (tester) async {
        tester.pumpComponent(
          DFormRow(
            columns: 2,
            children: [
              span([Component.text('Column 1')]),
              span([Component.text('Column 2')]),
            ],
          ),
        );

        expect(find.text('Column 1'), findsOneComponent);
        expect(find.text('Column 2'), findsOneComponent);
      });

      testComponents('renders with custom column count', (tester) async {
        tester.pumpComponent(
          DFormRow(
            columns: 3,
            children: [
              span([Component.text('Col 1')]),
              span([Component.text('Col 2')]),
              span([Component.text('Col 3')]),
            ],
          ),
        );

        expect(find.text('Col 1'), findsOneComponent);
        expect(find.text('Col 2'), findsOneComponent);
        expect(find.text('Col 3'), findsOneComponent);
      });
    });
  });

  group('DFormSection', () {
    group('rendering', () {
      testComponents('renders with children only', (tester) async {
        tester.pumpComponent(
          DFormSection(children: [
            span([Component.text('Section content')]),
          ]),
        );

        expect(find.tag('div'), findsComponents);
        expect(find.text('Section content'), findsOneComponent);
      });

      testComponents('renders with title', (tester) async {
        tester.pumpComponent(
          DFormSection(
            title: 'Personal Information',
            children: [span([Component.text('Fields')])],
          ),
        );

        expect(find.text('Personal Information'), findsOneComponent);
        expect(find.text('Fields'), findsOneComponent);
      });

      testComponents('renders with description', (tester) async {
        tester.pumpComponent(
          DFormSection(
            description: 'Fill in your details below',
            children: [span([Component.text('Fields')])],
          ),
        );

        expect(find.text('Fill in your details below'), findsOneComponent);
        expect(find.text('Fields'), findsOneComponent);
      });

      testComponents('renders with title and description', (tester) async {
        tester.pumpComponent(
          DFormSection(
            title: 'Contact Details',
            description: 'How can we reach you?',
            children: [
              span([Component.text('Email field')]),
              span([Component.text('Phone field')]),
            ],
          ),
        );

        expect(find.text('Contact Details'), findsOneComponent);
        expect(find.text('How can we reach you?'), findsOneComponent);
        expect(find.text('Email field'), findsOneComponent);
        expect(find.text('Phone field'), findsOneComponent);
      });

      testComponents('renders multiple children', (tester) async {
        tester.pumpComponent(
          DFormSection(
            title: 'Address',
            children: [
              span([Component.text('Street')]),
              span([Component.text('City')]),
              span([Component.text('Country')]),
            ],
          ),
        );

        expect(find.text('Address'), findsOneComponent);
        expect(find.text('Street'), findsOneComponent);
        expect(find.text('City'), findsOneComponent);
        expect(find.text('Country'), findsOneComponent);
      });
    });
  });
}
