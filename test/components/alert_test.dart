import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/button.dart';
import 'package:duxt_ui/src/components/alert.dart';

void main() {
  group('UAlert', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(UAlert());

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with title', (tester) async {
        tester.pumpComponent(
          UAlert(title: 'Success!'),
        );

        expect(find.text('Success!'), findsOneComponent);
        expect(find.tag('h3'), findsOneComponent);
      });

      testComponents('renders with description', (tester) async {
        tester.pumpComponent(
          UAlert(description: 'Your action was completed successfully.'),
        );

        expect(find.text('Your action was completed successfully.'),
            findsOneComponent);
      });

      testComponents('renders with title and description', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Information',
            description: 'This is an informational message.',
          ),
        );

        expect(find.text('Information'), findsOneComponent);
        expect(
            find.text('This is an informational message.'), findsOneComponent);
      });

      testComponents('renders with icon', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Alert',
            icon: span([Component.text('!')]),
          ),
        );

        expect(find.text('!'), findsOneComponent);
        expect(find.text('Alert'), findsOneComponent);
      });

      testComponents('renders with avatar', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'User Alert',
            avatar: div([Component.text('A')]),
          ),
        );

        expect(find.text('A'), findsOneComponent);
        expect(find.text('User Alert'), findsOneComponent);
      });

      testComponents('renders with children', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Custom Content',
            children: [
              p([Component.text('Paragraph 1')]),
              p([Component.text('Paragraph 2')]),
            ],
          ),
        );

        expect(find.text('Custom Content'), findsOneComponent);
        expect(find.text('Paragraph 1'), findsOneComponent);
        expect(find.text('Paragraph 2'), findsOneComponent);
      });

      testComponents('renders with actions', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Action Required',
            actions: [
              UButton(label: 'Dismiss', size: UButtonSize.sm),
              UButton(label: 'View', size: UButtonSize.sm),
            ],
          ),
        );

        expect(find.text('Action Required'), findsOneComponent);
        expect(find.text('Dismiss'), findsOneComponent);
        expect(find.text('View'), findsOneComponent);
      });

      testComponents('renders close button when onClose provided',
          (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Closable',
            onClose: () {},
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('variants', () {
      testComponents('renders solid variant', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Solid',
            variant: UAlertVariant.solid,
          ),
        );

        expect(find.text('Solid'), findsOneComponent);
      });

      testComponents('renders outline variant', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Outline',
            variant: UAlertVariant.outline,
          ),
        );

        expect(find.text('Outline'), findsOneComponent);
      });

      testComponents('renders soft variant (default)', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Soft',
            variant: UAlertVariant.soft,
          ),
        );

        expect(find.text('Soft'), findsOneComponent);
      });

      testComponents('renders subtle variant', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Subtle',
            variant: UAlertVariant.subtle,
          ),
        );

        expect(find.text('Subtle'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Primary',
            color: UAlertColor.primary,
          ),
        );

        expect(find.text('Primary'), findsOneComponent);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Secondary',
            color: UAlertColor.secondary,
          ),
        );

        expect(find.text('Secondary'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Success',
            color: UAlertColor.success,
          ),
        );

        expect(find.text('Success'), findsOneComponent);
      });

      testComponents('renders info color', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Info',
            color: UAlertColor.info,
          ),
        );

        expect(find.text('Info'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Warning',
            color: UAlertColor.warning,
          ),
        );

        expect(find.text('Warning'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Error',
            color: UAlertColor.error,
          ),
        );

        expect(find.text('Error'), findsOneComponent);
      });

      testComponents('renders neutral color', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Neutral',
            color: UAlertColor.neutral,
          ),
        );

        expect(find.text('Neutral'), findsOneComponent);
      });
    });

    group('variant + color combinations', () {
      testComponents('solid + error', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Critical Error',
            description: 'Something went wrong.',
            variant: UAlertVariant.solid,
            color: UAlertColor.error,
          ),
        );

        expect(find.text('Critical Error'), findsOneComponent);
        expect(find.text('Something went wrong.'), findsOneComponent);
      });

      testComponents('outline + success', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Success!',
            variant: UAlertVariant.outline,
            color: UAlertColor.success,
          ),
        );

        expect(find.text('Success!'), findsOneComponent);
      });

      testComponents('soft + warning', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Heads Up',
            description: 'Please review before continuing.',
            variant: UAlertVariant.soft,
            color: UAlertColor.warning,
          ),
        );

        expect(find.text('Heads Up'), findsOneComponent);
      });

      testComponents('subtle + info', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Note',
            variant: UAlertVariant.subtle,
            color: UAlertColor.info,
          ),
        );

        expect(find.text('Note'), findsOneComponent);
      });

      testComponents('solid + neutral', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Update Available',
            variant: UAlertVariant.solid,
            color: UAlertColor.neutral,
          ),
        );

        expect(find.text('Update Available'), findsOneComponent);
      });
    });

    group('interactions', () {
      testComponents('onClose callback fires when close clicked',
          (tester) async {
        var closed = false;
        tester.pumpComponent(
          UAlert(
            title: 'Closable Alert',
            onClose: () => closed = true,
          ),
        );

        await tester.click(find.tag('button'));
        expect(closed, isTrue);
      });

      testComponents('action buttons are clickable', (tester) async {
        tester.pumpComponent(
          UAlert(
            title: 'Alert',
            actions: [
              UButton(
                label: 'Action',
                onClick: () {},
              ),
            ],
          ),
        );

        expect(find.text('Action'), findsOneComponent);
      });
    });

    group('Alert integration', () {
      testComponents('renders complete alert with all elements',
          (tester) async {
        tester.pumpComponent(
          UAlert(
            variant: UAlertVariant.subtle,
            color: UAlertColor.warning,
            icon: span([Component.text('!')]),
            title: 'Security Warning',
            description: 'Your session will expire in 5 minutes.',
            onClose: () {},
            actions: [
              UButton(
                label: 'Stay Logged In',
                size: UButtonSize.sm,
                variant: UButtonVariant.soft,
              ),
            ],
          ),
        );

        expect(find.text('!'), findsOneComponent);
        expect(find.text('Security Warning'), findsOneComponent);
        expect(find.text('Your session will expire in 5 minutes.'),
            findsOneComponent);
        expect(find.text('Stay Logged In'), findsOneComponent);
      });

      testComponents('renders stacked alerts', (tester) async {
        tester.pumpComponent(
          div([
            UAlert(
              title: 'Error',
              color: UAlertColor.error,
            ),
            UAlert(
              title: 'Warning',
              color: UAlertColor.warning,
            ),
            UAlert(
              title: 'Success',
              color: UAlertColor.success,
            ),
          ]),
        );

        expect(find.text('Error'), findsOneComponent);
        expect(find.text('Warning'), findsOneComponent);
        expect(find.text('Success'), findsOneComponent);
      });
    });
  });
}
