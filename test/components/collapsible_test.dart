import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/content/collapsible.dart';

void main() {
  group('DCollapsible', () {
    group('rendering', () {
      testComponents('renders with trigger', (tester) async {
        tester.pumpComponent(
          DCollapsible(
            trigger: span([Component.text('Click me')]),
            children: [Component.text('Collapsible content')],
          ),
        );

        expect(find.text('Click me'), findsOneComponent);
        expect(find.tag('div'), findsComponents);
      });

      testComponents('content is hidden by default', (tester) async {
        tester.pumpComponent(
          DCollapsible(
            trigger: span([Component.text('Trigger')]),
            children: [Component.text('Hidden content')],
          ),
        );

        expect(find.text('Trigger'), findsOneComponent);
        expect(find.text('Hidden content'), findsNothing);
      });

      testComponents('content is visible when defaultOpen=true', (tester) async {
        tester.pumpComponent(
          DCollapsible(
            trigger: span([Component.text('Open Trigger')]),
            defaultOpen: true,
            children: [Component.text('Visible content')],
          ),
        );

        expect(find.text('Open Trigger'), findsOneComponent);
        expect(find.text('Visible content'), findsOneComponent);
      });

      testComponents('renders with multiple children', (tester) async {
        tester.pumpComponent(
          DCollapsible(
            trigger: span([Component.text('Multi Trigger')]),
            defaultOpen: true,
            children: [
              Component.text('Child 1'),
              Component.text('Child 2'),
              Component.text('Child 3'),
            ],
          ),
        );

        expect(find.text('Multi Trigger'), findsOneComponent);
        expect(find.text('Child 1'), findsOneComponent);
        expect(find.text('Child 2'), findsOneComponent);
        expect(find.text('Child 3'), findsOneComponent);
      });

      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DCollapsible(
            trigger: span([Component.text('Disabled Trigger')]),
            disabled: true,
            children: [Component.text('Content')],
          ),
        );

        expect(find.text('Disabled Trigger'), findsOneComponent);
      });

      testComponents('renders with custom trigger component', (tester) async {
        tester.pumpComponent(
          DCollapsible(
            trigger: div(
              classes: 'custom-trigger',
              [
                span([Component.text('Custom')]),
                span([Component.text('Trigger')]),
              ],
            ),
            defaultOpen: true,
            children: [Component.text('Content')],
          ),
        );

        expect(find.text('Custom'), findsOneComponent);
        expect(find.text('Trigger'), findsOneComponent);
        expect(find.text('Content'), findsOneComponent);
      });
    });

    group('integration', () {
      testComponents('renders complete collapsible structure', (tester) async {
        tester.pumpComponent(
          DCollapsible(
            trigger: div([
              span([Component.text('Toggle Section')]),
            ]),
            defaultOpen: true,
            children: [
              div(classes: 'content-wrapper', [
                p([Component.text('Paragraph 1')]),
                p([Component.text('Paragraph 2')]),
              ]),
            ],
          ),
        );

        expect(find.text('Toggle Section'), findsOneComponent);
        expect(find.text('Paragraph 1'), findsOneComponent);
        expect(find.text('Paragraph 2'), findsOneComponent);
      });
    });
  });

  group('DCollapsibleTrigger', () {
    group('rendering', () {
      testComponents('renders with label', (tester) async {
        tester.pumpComponent(
          DCollapsibleTrigger(label: 'Trigger Label'),
        );

        expect(find.text('Trigger Label'), findsOneComponent);
        expect(find.tag('div'), findsComponents);
        expect(find.tag('span'), findsComponents);
      });

      testComponents('renders in closed state', (tester) async {
        tester.pumpComponent(
          DCollapsibleTrigger(
            label: 'Closed',
            open: false,
          ),
        );

        expect(find.text('Closed'), findsOneComponent);
      });

      testComponents('renders in open state', (tester) async {
        tester.pumpComponent(
          DCollapsibleTrigger(
            label: 'Open',
            open: true,
          ),
        );

        expect(find.text('Open'), findsOneComponent);
      });

      testComponents('renders with icon', (tester) async {
        tester.pumpComponent(
          DCollapsibleTrigger(
            label: 'With Icon',
            icon: span([Component.text('*')]),
          ),
        );

        expect(find.text('With Icon'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders chevron indicator', (tester) async {
        tester.pumpComponent(
          DCollapsibleTrigger(label: 'Has Chevron'),
        );

        expect(find.text('Has Chevron'), findsOneComponent);
        // Should render the chevron character
        expect(find.tag('span'), findsComponents);
      });
    });
  });

  group('DCollapsibleContent', () {
    group('rendering', () {
      testComponents('renders children', (tester) async {
        tester.pumpComponent(
          DCollapsibleContent(
            children: [Component.text('Content text')],
          ),
        );

        expect(find.text('Content text'), findsOneComponent);
        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders multiple children', (tester) async {
        tester.pumpComponent(
          DCollapsibleContent(
            children: [
              Component.text('Line 1'),
              Component.text('Line 2'),
              Component.text('Line 3'),
            ],
          ),
        );

        expect(find.text('Line 1'), findsOneComponent);
        expect(find.text('Line 2'), findsOneComponent);
        expect(find.text('Line 3'), findsOneComponent);
      });

      testComponents('renders nested components', (tester) async {
        tester.pumpComponent(
          DCollapsibleContent(
            children: [
              div([
                p([Component.text('Nested paragraph')]),
              ]),
            ],
          ),
        );

        expect(find.text('Nested paragraph'), findsOneComponent);
        expect(find.tag('p'), findsOneComponent);
      });
    });
  });

  group('DCollapsible with helpers', () {
    testComponents('renders with DCollapsibleTrigger and DCollapsibleContent', (tester) async {
      tester.pumpComponent(
        DCollapsible(
          trigger: DCollapsibleTrigger(
            label: 'Toggle',
            icon: span([Component.text('>')]),
          ),
          defaultOpen: true,
          children: [
            DCollapsibleContent(
              children: [
                Component.text('Section content'),
              ],
            ),
          ],
        ),
      );

      expect(find.text('Toggle'), findsOneComponent);
      expect(find.text('>'), findsOneComponent);
      expect(find.text('Section content'), findsOneComponent);
    });
  });
}
