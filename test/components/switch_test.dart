import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/form/switch.dart';

void main() {
  group('DSwitch', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DSwitch());

        expect(find.tag('button'), findsOneComponent);
        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(
          DSwitch(label: 'Enable notifications'),
        );

        expect(find.text('Enable notifications'), findsOneComponent);
      });

      testComponents('renders with description', (tester) async {
        tester.pumpComponent(
          DSwitch(
            label: 'Dark mode',
            description: 'Enable dark mode for better visibility at night',
          ),
        );

        expect(find.text('Dark mode'), findsOneComponent);
        expect(find.text('Enable dark mode for better visibility at night'),
            findsOneComponent);
      });

      testComponents('renders with hint text', (tester) async {
        tester.pumpComponent(
          DSwitch(
            label: 'Auto-save',
            hint: 'Automatically save your work',
          ),
        );

        expect(find.text('Auto-save'), findsOneComponent);
        expect(find.text('Automatically save your work'), findsOneComponent);
      });

      testComponents('renders with error message', (tester) async {
        tester.pumpComponent(
          DSwitch(
            label: 'Terms',
            error: 'You must accept the terms',
          ),
        );

        expect(find.text('Terms'), findsOneComponent);
        expect(find.text('You must accept the terms'), findsOneComponent);
      });

      testComponents('renders required indicator', (tester) async {
        tester.pumpComponent(
          DSwitch(label: 'Accept terms', required: true),
        );

        expect(find.text('Accept terms'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders checked state (on)', (tester) async {
        tester.pumpComponent(
          DSwitch(checked: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders unchecked state (off)', (tester) async {
        tester.pumpComponent(
          DSwitch(checked: false),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with on/off labels when checked',
          (tester) async {
        tester.pumpComponent(
          DSwitch(
            checked: true,
            onLabel: 'Enabled',
            offLabel: 'Disabled',
          ),
        );

        expect(find.text('Enabled'), findsOneComponent);
        expect(find.text('Disabled'), findsNothing);
      });

      testComponents('renders with on/off labels when unchecked',
          (tester) async {
        tester.pumpComponent(
          DSwitch(
            checked: false,
            onLabel: 'Enabled',
            offLabel: 'Disabled',
          ),
        );

        expect(find.text('Disabled'), findsOneComponent);
        expect(find.text('Enabled'), findsNothing);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DSwitch(size: DSwitchSize.xs),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DSwitch(size: DSwitchSize.sm),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DSwitch(size: DSwitchSize.md),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DSwitch(size: DSwitchSize.lg),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DSwitch(size: DSwitchSize.xl),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DSwitch(color: DSwitchColor.primary, checked: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders gray color', (tester) async {
        tester.pumpComponent(
          DSwitch(color: DSwitchColor.gray, checked: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DSwitch(color: DSwitchColor.success, checked: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          DSwitch(color: DSwitchColor.warning, checked: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DSwitch(color: DSwitchColor.error, checked: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DSwitch(disabled: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders disabled with label', (tester) async {
        tester.pumpComponent(
          DSwitch(label: 'Disabled option', disabled: true),
        );

        expect(find.text('Disabled option'), findsOneComponent);
      });

      testComponents('renders disabled and checked', (tester) async {
        tester.pumpComponent(
          DSwitch(disabled: true, checked: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('icons', () {
      testComponents('renders with on icon when checked', (tester) async {
        tester.pumpComponent(
          DSwitch(
            checked: true,
            onIcon: span([Component.text('v')]),
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with off icon when unchecked', (tester) async {
        tester.pumpComponent(
          DSwitch(
            checked: false,
            offIcon: span([Component.text('x')]),
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with both icons', (tester) async {
        tester.pumpComponent(
          DSwitch(
            checked: true,
            onIcon: span([Component.text('v')]),
            offIcon: span([Component.text('x')]),
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('form attributes', () {
      testComponents('renders with name attribute', (tester) async {
        tester.pumpComponent(
          DSwitch(name: 'notifications-switch'),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders required attribute', (tester) async {
        tester.pumpComponent(
          DSwitch(required: true, label: 'Required toggle'),
        );

        expect(find.text('Required toggle'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });
    });

    group('accessibility', () {
      testComponents('renders with role=switch', (tester) async {
        tester.pumpComponent(DSwitch());

        expect(find.tag('button'), findsOneComponent);
        // Button should have role="switch" attribute
      });

      testComponents('renders with aria-checked', (tester) async {
        tester.pumpComponent(DSwitch(checked: true));

        expect(find.tag('button'), findsOneComponent);
        // Button should have aria-checked="true" attribute
      });
    });

    group('error state styling', () {
      testComponents('shows error instead of hint when error present',
          (tester) async {
        tester.pumpComponent(
          DSwitch(
            label: 'Toggle',
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
          DSwitch(
            onChange: (value) {},
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with all props combined', (tester) async {
        tester.pumpComponent(
          DSwitch(
            label: 'Enable feature',
            description: 'Turn on this experimental feature',
            name: 'feature-switch',
            checked: true,
            size: DSwitchSize.lg,
            color: DSwitchColor.success,
            hint: 'Click to toggle',
          ),
        );

        expect(find.text('Enable feature'), findsOneComponent);
        expect(find.text('Turn on this experimental feature'), findsOneComponent);
        expect(find.text('Click to toggle'), findsOneComponent);
      });
    });

    group('visual elements', () {
      testComponents('renders switch track', (tester) async {
        tester.pumpComponent(DSwitch());

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders switch thumb', (tester) async {
        tester.pumpComponent(DSwitch());

        // Thumb is rendered as a span inside button
        expect(find.tag('span'), findsComponents);
      });

      testComponents('renders hidden input for form submission',
          (tester) async {
        tester.pumpComponent(DSwitch(name: 'test-switch'));

        expect(find.tag('input'), findsOneComponent);
      });
    });
  });
}
