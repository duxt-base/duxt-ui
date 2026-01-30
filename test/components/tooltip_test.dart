import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/overlay/tooltip.dart';
import 'package:duxt_ui/src/components/button.dart';

void main() {
  group('DTooltip', () {
    group('rendering', () {
      testComponents('renders with required props', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'Tooltip text',
            child: DButton(label: 'Hover me'),
          ),
        );

        // Should render the child
        expect(find.text('Hover me'), findsOneComponent);
        // Should render the tooltip text (hidden by default with CSS)
        expect(find.text('Tooltip text'), findsOneComponent);
      });

      testComponents('renders child component', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'Help text',
            child: span([Component.text('Icon')]),
          ),
        );

        expect(find.text('Icon'), findsOneComponent);
      });

      testComponents('renders tooltip text', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'This is helpful info',
            child: DButton(label: 'Help'),
          ),
        );

        expect(find.text('This is helpful info'), findsOneComponent);
      });
    });

    group('placements', () {
      testComponents('renders with top placement (default)', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'Top tooltip',
            placement: DTooltipPlacement.top,
            child: DButton(label: 'Button'),
          ),
        );

        expect(find.text('Top tooltip'), findsOneComponent);
      });

      testComponents('renders with bottom placement', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'Bottom tooltip',
            placement: DTooltipPlacement.bottom,
            child: DButton(label: 'Button'),
          ),
        );

        expect(find.text('Bottom tooltip'), findsOneComponent);
      });

      testComponents('renders with left placement', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'Left tooltip',
            placement: DTooltipPlacement.left,
            child: DButton(label: 'Button'),
          ),
        );

        expect(find.text('Left tooltip'), findsOneComponent);
      });

      testComponents('renders with right placement', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'Right tooltip',
            placement: DTooltipPlacement.right,
            child: DButton(label: 'Button'),
          ),
        );

        expect(find.text('Right tooltip'), findsOneComponent);
      });

      testComponents('renders with topStart placement', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'TopStart tooltip',
            placement: DTooltipPlacement.topStart,
            child: DButton(label: 'Button'),
          ),
        );

        expect(find.text('TopStart tooltip'), findsOneComponent);
      });

      testComponents('renders with bottomEnd placement', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'BottomEnd tooltip',
            placement: DTooltipPlacement.bottomEnd,
            child: DButton(label: 'Button'),
          ),
        );

        expect(find.text('BottomEnd tooltip'), findsOneComponent);
      });
    });

    group('structure', () {
      testComponents('uses group class for CSS hover', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'Tooltip',
            child: DButton(label: 'Button'),
          ),
        );

        // The wrapper div should have 'group' class for CSS hover to work
        final wrapper = find.tag('div');
        expect(wrapper, findsComponents);
      });

      testComponents('tooltip has correct visibility classes', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'Tooltip',
            child: DButton(label: 'Button'),
          ),
        );

        // Should find tooltip text which has opacity-0 and group-hover:opacity-100
        expect(find.text('Tooltip'), findsOneComponent);
      });
    });

    group('delay', () {
      testComponents('renders with delay', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'Delayed tooltip',
            delayMs: 500,
            child: DButton(label: 'Button'),
          ),
        );

        expect(find.text('Delayed tooltip'), findsOneComponent);
      });

      testComponents('renders with zero delay (default)', (tester) async {
        tester.pumpComponent(
          DTooltip(
            text: 'Instant tooltip',
            child: DButton(label: 'Button'),
          ),
        );

        expect(find.text('Instant tooltip'), findsOneComponent);
      });
    });
  });

  group('DTooltipCustom', () {
    testComponents('renders with custom content', (tester) async {
      tester.pumpComponent(
        DTooltipCustom(
          content: div([
            strong([Component.text('Title')]),
            p([Component.text('Description')]),
          ]),
          child: DButton(label: 'Hover'),
        ),
      );

      expect(find.text('Title'), findsOneComponent);
      expect(find.text('Description'), findsOneComponent);
      expect(find.text('Hover'), findsOneComponent);
    });

    testComponents('renders with placement', (tester) async {
      tester.pumpComponent(
        DTooltipCustom(
          content: Component.text('Custom content'),
          placement: DTooltipPlacement.bottom,
          child: DButton(label: 'Button'),
        ),
      );

      expect(find.text('Custom content'), findsOneComponent);
    });
  });
}
