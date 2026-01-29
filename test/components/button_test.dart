import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/button.dart';

void main() {
  group('DButton', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DButton(label: 'Click me'));

        expect(find.text('Click me'), findsOneComponent);
        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(DButton(label: 'Submit'));

        expect(find.text('Submit'), findsOneComponent);
      });

      testComponents('renders children when provided', (tester) async {
        tester.pumpComponent(
          DButton(children: [Component.text('Child content')]),
        );

        expect(find.text('Child content'), findsOneComponent);
      });

      testComponents('renders without label when none provided',
          (tester) async {
        tester.pumpComponent(DButton());

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('variants', () {
      testComponents('renders solid variant', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Solid', variant: DButtonVariant.solid),
        );

        final button = find.tag('button');
        expect(button, findsOneComponent);
      });

      testComponents('renders outline variant', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Outline', variant: DButtonVariant.outline),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('Outline'), findsOneComponent);
      });

      testComponents('renders soft variant', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Soft', variant: DButtonVariant.soft),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('Soft'), findsOneComponent);
      });

      testComponents('renders subtle variant', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Subtle', variant: DButtonVariant.subtle),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('Subtle'), findsOneComponent);
      });

      testComponents('renders ghost variant', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Ghost', variant: DButtonVariant.ghost),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('Ghost'), findsOneComponent);
      });

      testComponents('renders link variant', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Link', variant: DButtonVariant.link),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('Link'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DButton(label: 'XS', size: DButtonSize.xs),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DButton(label: 'SM', size: DButtonSize.sm),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DButton(label: 'MD', size: DButtonSize.md),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DButton(label: 'LG', size: DButtonSize.lg),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DButton(label: 'XL', size: DButtonSize.xl),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Primary', color: DButtonColor.primary),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Secondary', color: DButtonColor.secondary),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Success', color: DButtonColor.success),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders info color', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Info', color: DButtonColor.info),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Warning', color: DButtonColor.warning),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Error', color: DButtonColor.error),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders neutral color', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Neutral', color: DButtonColor.neutral),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Disabled', disabled: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders loading state', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Loading', loading: true),
        );

        expect(find.tag('button'), findsOneComponent);
        // Loading spinner should be present
        expect(find.tag('span'), findsComponents);
      });

      testComponents('renders block (full-width) state', (tester) async {
        tester.pumpComponent(
          DButton(label: 'Block', block: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders square state', (tester) async {
        tester.pumpComponent(
          DButton(label: 'S', square: true),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });

    group('icons', () {
      testComponents('renders with leading icon', (tester) async {
        tester.pumpComponent(
          DButton(
            label: 'With Icon',
            leadingIcon: span([Component.text('+')]),
          ),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('+'), findsOneComponent);
      });

      testComponents('renders with trailing icon', (tester) async {
        tester.pumpComponent(
          DButton(
            label: 'With Icon',
            trailingIcon: span([Component.text('>')]),
          ),
        );

        expect(find.tag('button'), findsOneComponent);
        expect(find.text('>'), findsOneComponent);
      });

      testComponents('renders with both icons', (tester) async {
        tester.pumpComponent(
          DButton(
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
          DButton(
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
          DButton(
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
          DButton(
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
          DButton(
            label: 'Delete',
            variant: DButtonVariant.solid,
            color: DButtonColor.error,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('outline + secondary', (tester) async {
        tester.pumpComponent(
          DButton(
            label: 'Secondary',
            variant: DButtonVariant.outline,
            color: DButtonColor.secondary,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('soft + success', (tester) async {
        tester.pumpComponent(
          DButton(
            label: 'Done',
            variant: DButtonVariant.soft,
            color: DButtonColor.success,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('ghost + neutral', (tester) async {
        tester.pumpComponent(
          DButton(
            label: 'Cancel',
            variant: DButtonVariant.ghost,
            color: DButtonColor.neutral,
          ),
        );

        expect(find.tag('button'), findsOneComponent);
      });
    });
  });

  group('DButtonGroup', () {
    testComponents('renders multiple buttons horizontally', (tester) async {
      tester.pumpComponent(
        DButtonGroup(
          children: [
            DButton(label: 'One'),
            DButton(label: 'Two'),
            DButton(label: 'Three'),
          ],
        ),
      );

      expect(find.text('One'), findsOneComponent);
      expect(find.text('Two'), findsOneComponent);
      expect(find.text('Three'), findsOneComponent);
    });

    testComponents('renders vertically when orientation set', (tester) async {
      tester.pumpComponent(
        DButtonGroup(
          orientation: 'vertical',
          children: [
            DButton(label: 'Top'),
            DButton(label: 'Bottom'),
          ],
        ),
      );

      expect(find.text('Top'), findsOneComponent);
      expect(find.text('Bottom'), findsOneComponent);
    });
  });
}
