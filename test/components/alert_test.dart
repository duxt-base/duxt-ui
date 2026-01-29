import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/button.dart';
import 'package:duxt_ui/src/components/alert.dart';

void main() {
  group('DAlert', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DAlert());

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with title', (tester) async {
        tester.pumpComponent(
          DAlert(title: 'Success!'),
        );

        expect(find.text('Success!'), findsOneComponent);
        expect(find.tag('h3'), findsOneComponent);
      });

      testComponents('renders with description', (tester) async {
        tester.pumpComponent(
          DAlert(description: 'Your action was completed successfully.'),
        );

        expect(find.text('Your action was completed successfully.'),
            findsOneComponent);
      });

      testComponents('renders with title and description', (tester) async {
        tester.pumpComponent(
          DAlert(
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
          DAlert(
            title: 'Alert',
            icon: span([Component.text('!')]),
          ),
        );

        expect(find.text('!'), findsOneComponent);
        expect(find.text('Alert'), findsOneComponent);
      });

      testComponents('renders with avatar', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'User Alert',
            avatar: div([Component.text('A')]),
          ),
        );

        expect(find.text('A'), findsOneComponent);
        expect(find.text('User Alert'), findsOneComponent);
      });

      testComponents('renders with children', (tester) async {
        tester.pumpComponent(
          DAlert(
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
          DAlert(
            title: 'Action Required',
            actions: [
              DButton(label: 'Dismiss', size: DButtonSize.sm),
              DButton(label: 'View', size: DButtonSize.sm),
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
          DAlert(
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
          DAlert(
            title: 'Solid',
            variant: DAlertVariant.solid,
          ),
        );

        expect(find.text('Solid'), findsOneComponent);
      });

      testComponents('renders outline variant', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Outline',
            variant: DAlertVariant.outline,
          ),
        );

        expect(find.text('Outline'), findsOneComponent);
      });

      testComponents('renders soft variant (default)', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Soft',
            variant: DAlertVariant.soft,
          ),
        );

        expect(find.text('Soft'), findsOneComponent);
      });

      testComponents('renders subtle variant', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Subtle',
            variant: DAlertVariant.subtle,
          ),
        );

        expect(find.text('Subtle'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Primary',
            color: DAlertColor.primary,
          ),
        );

        expect(find.text('Primary'), findsOneComponent);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Secondary',
            color: DAlertColor.secondary,
          ),
        );

        expect(find.text('Secondary'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Success',
            color: DAlertColor.success,
          ),
        );

        expect(find.text('Success'), findsOneComponent);
      });

      testComponents('renders info color', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Info',
            color: DAlertColor.info,
          ),
        );

        expect(find.text('Info'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Warning',
            color: DAlertColor.warning,
          ),
        );

        expect(find.text('Warning'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Error',
            color: DAlertColor.error,
          ),
        );

        expect(find.text('Error'), findsOneComponent);
      });

      testComponents('renders neutral color', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Neutral',
            color: DAlertColor.neutral,
          ),
        );

        expect(find.text('Neutral'), findsOneComponent);
      });
    });

    group('variant + color combinations', () {
      testComponents('solid + error', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Critical Error',
            description: 'Something went wrong.',
            variant: DAlertVariant.solid,
            color: DAlertColor.error,
          ),
        );

        expect(find.text('Critical Error'), findsOneComponent);
        expect(find.text('Something went wrong.'), findsOneComponent);
      });

      testComponents('outline + success', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Success!',
            variant: DAlertVariant.outline,
            color: DAlertColor.success,
          ),
        );

        expect(find.text('Success!'), findsOneComponent);
      });

      testComponents('soft + warning', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Heads Up',
            description: 'Please review before continuing.',
            variant: DAlertVariant.soft,
            color: DAlertColor.warning,
          ),
        );

        expect(find.text('Heads Up'), findsOneComponent);
      });

      testComponents('subtle + info', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Note',
            variant: DAlertVariant.subtle,
            color: DAlertColor.info,
          ),
        );

        expect(find.text('Note'), findsOneComponent);
      });

      testComponents('solid + neutral', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Update Available',
            variant: DAlertVariant.solid,
            color: DAlertColor.neutral,
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
          DAlert(
            title: 'Closable Alert',
            onClose: () => closed = true,
          ),
        );

        await tester.click(find.tag('button'));
        expect(closed, isTrue);
      });

      testComponents('action buttons are clickable', (tester) async {
        tester.pumpComponent(
          DAlert(
            title: 'Alert',
            actions: [
              DButton(
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
          DAlert(
            variant: DAlertVariant.subtle,
            color: DAlertColor.warning,
            icon: span([Component.text('!')]),
            title: 'Security Warning',
            description: 'Your session will expire in 5 minutes.',
            onClose: () {},
            actions: [
              DButton(
                label: 'Stay Logged In',
                size: DButtonSize.sm,
                variant: DButtonVariant.soft,
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
            DAlert(
              title: 'Error',
              color: DAlertColor.error,
            ),
            DAlert(
              title: 'Warning',
              color: DAlertColor.warning,
            ),
            DAlert(
              title: 'Success',
              color: DAlertColor.success,
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
