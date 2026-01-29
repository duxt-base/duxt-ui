import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/button.dart';

void main() {
  group('UButton', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(UButton(label: 'Click me'));

        expect(find.text('Click me'), findsOneComponent);
        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(UButton(label: 'Submit'));

        expect(find.text('Submit'), findsOneComponent);
      });

      testComponents('renders children when provided', (tester) async {
        tester.pumpComponent(
          UButton(children: [Component.text('Child content')]),
        );

        expect(find.text('Child content'), findsOneComponent);
      });

      testComponents('renders without label when none provided',
          (tester) async {
        tester.pumpComponent(UButton());

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('variants', () {
      testComponents('renders solid variant', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Solid', variant: UButtonVariant.solid),
        );

        final button = find.tag('button');
        expect(button, findsOneComponent);
      });

      testComponents('renders outline variant', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Outline', variant: UButtonVariant.outline),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('Outline'), findsOneComponent);
      });

      testComponents('renders soft variant', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Soft', variant: UButtonVariant.soft),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('Soft'), findsOneComponent);
      });

      testComponents('renders subtle variant', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Subtle', variant: UButtonVariant.subtle),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('Subtle'), findsOneComponent);
      });

      testComponents('renders ghost variant', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Ghost', variant: UButtonVariant.ghost),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('Ghost'), findsOneComponent);
      });

      testComponents('renders link variant', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Link', variant: UButtonVariant.link),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('Link'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          UButton(label: 'XS', size: UButtonSize.xs),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          UButton(label: 'SM', size: UButtonSize.sm),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          UButton(label: 'MD', size: UButtonSize.md),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          UButton(label: 'LG', size: UButtonSize.lg),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          UButton(label: 'XL', size: UButtonSize.xl),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Primary', color: UButtonColor.primary),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Secondary', color: UButtonColor.secondary),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Success', color: UButtonColor.success),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders info color', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Info', color: UButtonColor.info),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Warning', color: UButtonColor.warning),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Error', color: UButtonColor.error),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders neutral color', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Neutral', color: UButtonColor.neutral),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Disabled', disabled: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders loading state', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Loading', loading: true),
        );

        expect(find.tag('button'), findsOneComponent);
        // Loading spinner should be present
        expect(find.tag('span'), findsComponents);
      });

      testComponents('renders block (full-width) state', (tester) async {
        tester.pumpComponent(
          UButton(label: 'Block', block: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders square state', (tester) async {
        tester.pumpComponent(
          UButton(label: 'S', square: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('icons', () {
      testComponents('renders with leading icon', (tester) async {
        tester.pumpComponent(
          UButton(
            label: 'With Icon',
            leadingIcon: span([Component.text('+')]),
          ),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('+'), findsOneComponent);
      });

      testComponents('renders with trailing icon', (tester) async {
        tester.pumpComponent(
          UButton(
            label: 'With Icon',
            trailingIcon: span([Component.text('>')]),
          ),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('>'), findsOneComponent);
      });

      testComponents('renders with both icons', (tester) async {
        tester.pumpComponent(
          UButton(
            label: 'Both Icons',
            leadingIcon: span([Component.text('<')]),
            trailingIcon: span([Component.text('>')]),
          ),
        );

        expect(find.text('<'), findsOneComponent);
        expect(find.text('>'), findsOneComponent);
      });
    });

    group('interactions', () {
      testComponents('onClick callback fires when clicked', (tester) async {
        var clicked = false;
        tester.pumpComponent(
          UButton(
            label: 'Click',
            onClick: () => clicked = true,
          ),
        );

        await tester.click(find.tag('button'));
        expect(clicked, isTrue);
      });

      testComponents('onClick does not fire when disabled', (tester) async {
        var clicked = false;
        tester.pumpComponent(
          UButton(
            label: 'Disabled',
            disabled: true,
            onClick: () => clicked = true,
          ),
        );

        await tester.click(find.tag('button'));
        expect(clicked, isFalse);
      });

      testComponents('onClick does not fire when loading', (tester) async {
        var clicked = false;
        tester.pumpComponent(
          UButton(
            label: 'Loading',
            loading: true,
            onClick: () => clicked = true,
          ),
        );

        await tester.click(find.tag('button'));
        expect(clicked, isFalse);
      });
    });

    group('variant + color combinations', () {
      testComponents('solid + error', (tester) async {
        tester.pumpComponent(
          UButton(
            label: 'Delete',
            variant: UButtonVariant.solid,
            color: UButtonColor.error,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('outline + secondary', (tester) async {
        tester.pumpComponent(
          UButton(
            label: 'Secondary',
            variant: UButtonVariant.outline,
            color: UButtonColor.secondary,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('soft + success', (tester) async {
        tester.pumpComponent(
          UButton(
            label: 'Done',
            variant: UButtonVariant.soft,
            color: UButtonColor.success,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('ghost + neutral', (tester) async {
        tester.pumpComponent(
          UButton(
            label: 'Cancel',
            variant: UButtonVariant.ghost,
            color: UButtonColor.neutral,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });
  });

  group('UButtonGroup', () {
    testComponents('renders multiple buttons horizontally', (tester) async {
      tester.pumpComponent(
        UButtonGroup(
          children: [
            UButton(label: 'One'),
            UButton(label: 'Two'),
            UButton(label: 'Three'),
          ],
        ),
      );

      expect(find.text('One'), findsOneComponent);
      expect(find.text('Two'), findsOneComponent);
      expect(find.text('Three'), findsOneComponent);
    });

    testComponents('renders vertically when orientation set', (tester) async {
      tester.pumpComponent(
        UButtonGroup(
          orientation: 'vertical',
          children: [
            UButton(label: 'Top'),
            UButton(label: 'Bottom'),
          ],
        ),
      );

      expect(find.text('Top'), findsOneComponent);
      expect(find.text('Bottom'), findsOneComponent);
    });
  });
}
