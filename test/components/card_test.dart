import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/button.dart';
import 'package:duxt_ui/src/components/card.dart';

void main() {
  group('UCard', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(
          UCard(children: [Component.text('Card content')]),
        );

        expect(find.text('Card content'), findsOneComponent);
        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders header when provided', (tester) async {
        tester.pumpComponent(
          UCard(
            header: span([Component.text('Header')]),
            children: [Component.text('Body')],
          ),
        );

        expect(find.text('Header'), findsOneComponent);
        expect(find.text('Body'), findsOneComponent);
      });

      testComponents('renders footer when provided', (tester) async {
        tester.pumpComponent(
          UCard(
            children: [Component.text('Body')],
            footer: span([Component.text('Footer')]),
          ),
        );

        expect(find.text('Body'), findsOneComponent);
        expect(find.text('Footer'), findsOneComponent);
      });

      testComponents('renders with header and footer', (tester) async {
        tester.pumpComponent(
          UCard(
            header: span([Component.text('Title')]),
            children: [Component.text('Content')],
            footer: span([Component.text('Actions')]),
          ),
        );

        expect(find.text('Title'), findsOneComponent);
        expect(find.text('Content'), findsOneComponent);
        expect(find.text('Actions'), findsOneComponent);
      });

      testComponents('renders with custom classes', (tester) async {
        tester.pumpComponent(
          UCard(
            classes: 'custom-class',
            children: [Component.text('Content')],
          ),
        );

        expect(find.text('Content'), findsOneComponent);
      });

      testComponents('renders with noPadding', (tester) async {
        tester.pumpComponent(
          UCard(
            noPadding: true,
            children: [Component.text('No padding content')],
          ),
        );

        expect(find.text('No padding content'), findsOneComponent);
      });
    });

    group('variants', () {
      testComponents('renders solid variant', (tester) async {
        tester.pumpComponent(
          UCard(
            variant: UCardVariant.solid,
            children: [Component.text('Solid')],
          ),
        );

        expect(find.text('Solid'), findsOneComponent);
      });

      testComponents('renders outline variant (default)', (tester) async {
        tester.pumpComponent(
          UCard(
            variant: UCardVariant.outline,
            children: [Component.text('Outline')],
          ),
        );

        expect(find.text('Outline'), findsOneComponent);
      });

      testComponents('renders soft variant', (tester) async {
        tester.pumpComponent(
          UCard(
            variant: UCardVariant.soft,
            children: [Component.text('Soft')],
          ),
        );

        expect(find.text('Soft'), findsOneComponent);
      });

      testComponents('renders subtle variant', (tester) async {
        tester.pumpComponent(
          UCard(
            variant: UCardVariant.subtle,
            children: [Component.text('Subtle')],
          ),
        );

        expect(find.text('Subtle'), findsOneComponent);
      });
    });
  });

  group('UCardHeader', () {
    testComponents('renders with title', (tester) async {
      tester.pumpComponent(
        UCardHeader(title: 'Card Title'),
      );

      expect(find.text('Card Title'), findsOneComponent);
      expect(find.tag('h3'), findsOneComponent);
    });

    testComponents('renders with description', (tester) async {
      tester.pumpComponent(
        UCardHeader(
          title: 'Title',
          description: 'Description text',
        ),
      );

      expect(find.text('Title'), findsOneComponent);
      expect(find.text('Description text'), findsOneComponent);
    });

    testComponents('renders with trailing component', (tester) async {
      tester.pumpComponent(
        UCardHeader(
          title: 'Title',
          trailing: span([Component.text('Action')]),
        ),
      );

      expect(find.text('Title'), findsOneComponent);
      expect(find.text('Action'), findsOneComponent);
    });

    testComponents('renders with children', (tester) async {
      tester.pumpComponent(
        UCardHeader(
          title: 'Title',
          children: [
            span([Component.text('Extra content')])
          ],
        ),
      );

      expect(find.text('Title'), findsOneComponent);
      expect(find.text('Extra content'), findsOneComponent);
    });
  });

  group('UCardBody', () {
    testComponents('renders children', (tester) async {
      tester.pumpComponent(
        UCardBody(
          children: [Component.text('Body content')],
        ),
      );

      expect(find.text('Body content'), findsOneComponent);
    });

    testComponents('renders with custom classes', (tester) async {
      tester.pumpComponent(
        UCardBody(
          classes: 'my-custom-class',
          children: [Component.text('Content')],
        ),
      );

      expect(find.text('Content'), findsOneComponent);
    });
  });

  group('UCardFooter', () {
    testComponents('renders children', (tester) async {
      tester.pumpComponent(
        UCardFooter(
          children: [
            UButton(label: 'Cancel'),
            UButton(label: 'Save'),
          ],
        ),
      );

      expect(find.text('Cancel'), findsOneComponent);
      expect(find.text('Save'), findsOneComponent);
    });

    testComponents('renders with custom classes', (tester) async {
      tester.pumpComponent(
        UCardFooter(
          classes: 'footer-class',
          children: [Component.text('Footer text')],
        ),
      );

      expect(find.text('Footer text'), findsOneComponent);
    });
  });

  group('UCard integration', () {
    testComponents('renders complete card structure', (tester) async {
      tester.pumpComponent(
        UCard(
          variant: UCardVariant.outline,
          header: UCardHeader(
            title: 'User Profile',
            description: 'Manage your account',
          ),
          children: [
            UCardBody(
              children: [Component.text('Profile settings here')],
            ),
          ],
          footer: UCardFooter(
            children: [
              UButton(label: 'Cancel', variant: UButtonVariant.ghost),
              UButton(label: 'Save'),
            ],
          ),
        ),
      );

      expect(find.text('User Profile'), findsOneComponent);
      expect(find.text('Manage your account'), findsOneComponent);
      expect(find.text('Profile settings here'), findsOneComponent);
      expect(find.text('Cancel'), findsOneComponent);
      expect(find.text('Save'), findsOneComponent);
    });
  });
}
