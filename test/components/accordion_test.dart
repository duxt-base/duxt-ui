import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/content/accordion.dart';
import 'package:duxt_ui/src/theme/variants.dart';

void main() {
  group('DAccordionItem', () {
    test('creates item with required parameters', () {
      final item = DAccordionItem(
        label: 'Test Label',
        content: Component.text('Test Content'),
      );

      expect(item.label, equals('Test Label'));
      expect(item.disabled, isFalse);
      expect(item.description, isNull);
      expect(item.icon, isNull);
      expect(item.value, isNull);
    });

    test('creates item with all parameters', () {
      final item = DAccordionItem(
        label: 'Full Item',
        content: Component.text('Content'),
        description: 'Description text',
        icon: Component.text('Icon'),
        disabled: true,
        value: 'custom-value',
      );

      expect(item.label, equals('Full Item'));
      expect(item.description, equals('Description text'));
      expect(item.disabled, isTrue);
      expect(item.value, equals('custom-value'));
    });
  });

  group('DAccordion', () {
    group('rendering', () {
      testComponents('renders with single item', (tester) async {
        tester.pumpComponent(
          DAccordion(
            items: [
              DAccordionItem(
                label: 'Item 1',
                content: Component.text('Content 1'),
              ),
            ],
          ),
        );

        expect(find.text('Item 1'), findsOneComponent);
        expect(find.tag('div'), findsComponents);
        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with multiple items', (tester) async {
        tester.pumpComponent(
          DAccordion(
            items: [
              DAccordionItem(
                label: 'First Item',
                content: Component.text('First Content'),
              ),
              DAccordionItem(
                label: 'Second Item',
                content: Component.text('Second Content'),
              ),
              DAccordionItem(
                label: 'Third Item',
                content: Component.text('Third Content'),
              ),
            ],
          ),
        );

        expect(find.text('First Item'), findsOneComponent);
        expect(find.text('Second Item'), findsOneComponent);
        expect(find.text('Third Item'), findsOneComponent);
      });

      testComponents('renders item with description', (tester) async {
        tester.pumpComponent(
          DAccordion(
            items: [
              DAccordionItem(
                label: 'Label',
                description: 'Item description',
                content: Component.text('Content'),
              ),
            ],
          ),
        );

        expect(find.text('Label'), findsOneComponent);
        expect(find.text('Item description'), findsOneComponent);
      });

      testComponents('renders item with icon', (tester) async {
        tester.pumpComponent(
          DAccordion(
            items: [
              DAccordionItem(
                label: 'Icon Item',
                icon: span([Component.text('*')]),
                content: Component.text('Content'),
              ),
            ],
          ),
        );

        expect(find.text('Icon Item'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('content is hidden by default', (tester) async {
        tester.pumpComponent(
          DAccordion(
            items: [
              DAccordionItem(
                label: 'Closed Item',
                content: Component.text('Hidden Content'),
              ),
            ],
          ),
        );

        expect(find.text('Closed Item'), findsOneComponent);
        expect(find.text('Hidden Content'), findsNothing);
      });

      testComponents('renders with defaultValue showing content', (tester) async {
        tester.pumpComponent(
          DAccordion(
            defaultValue: 'item-0',
            items: [
              DAccordionItem(
                label: 'Open Item',
                content: Component.text('Visible Content'),
              ),
            ],
          ),
        );

        expect(find.text('Open Item'), findsOneComponent);
        expect(find.text('Visible Content'), findsOneComponent);
      });

      testComponents('renders with custom value and defaultValue', (tester) async {
        tester.pumpComponent(
          DAccordion(
            defaultValue: 'custom',
            items: [
              DAccordionItem(
                label: 'Custom Value Item',
                content: Component.text('Custom Content'),
                value: 'custom',
              ),
            ],
          ),
        );

        expect(find.text('Custom Value Item'), findsOneComponent);
        expect(find.text('Custom Content'), findsOneComponent);
      });

      testComponents('renders disabled item', (tester) async {
        tester.pumpComponent(
          DAccordion(
            items: [
              DAccordionItem(
                label: 'Disabled Item',
                content: Component.text('Content'),
                disabled: true,
              ),
            ],
          ),
        );

        expect(find.text('Disabled Item'), findsOneComponent);
      });
    });

    group('variants', () {
      testComponents('renders soft variant (default)', (tester) async {
        tester.pumpComponent(
          DAccordion(
            variant: DAccordionVariant.soft,
            items: [
              DAccordionItem(
                label: 'Soft Item',
                content: Component.text('Content'),
              ),
            ],
          ),
        );

        expect(find.text('Soft Item'), findsOneComponent);
      });

      testComponents('renders ghost variant', (tester) async {
        tester.pumpComponent(
          DAccordion(
            variant: DAccordionVariant.ghost,
            items: [
              DAccordionItem(
                label: 'Ghost Item',
                content: Component.text('Content'),
              ),
            ],
          ),
        );

        expect(find.text('Ghost Item'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DAccordion(
            size: DSize.xs,
            items: [
              DAccordionItem(
                label: 'XS Item',
                content: Component.text('Content'),
              ),
            ],
          ),
        );

        expect(find.text('XS Item'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DAccordion(
            size: DSize.sm,
            items: [
              DAccordionItem(
                label: 'SM Item',
                content: Component.text('Content'),
              ),
            ],
          ),
        );

        expect(find.text('SM Item'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DAccordion(
            size: DSize.md,
            items: [
              DAccordionItem(
                label: 'MD Item',
                content: Component.text('Content'),
              ),
            ],
          ),
        );

        expect(find.text('MD Item'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DAccordion(
            size: DSize.lg,
            items: [
              DAccordionItem(
                label: 'LG Item',
                content: Component.text('Content'),
              ),
            ],
          ),
        );

        expect(find.text('LG Item'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DAccordion(
            size: DSize.xl,
            items: [
              DAccordionItem(
                label: 'XL Item',
                content: Component.text('Content'),
              ),
            ],
          ),
        );

        expect(find.text('XL Item'), findsOneComponent);
      });
    });

    group('multiple mode', () {
      testComponents('renders with multiple=true', (tester) async {
        tester.pumpComponent(
          DAccordion(
            multiple: true,
            items: [
              DAccordionItem(
                label: 'Multi 1',
                content: Component.text('Content 1'),
              ),
              DAccordionItem(
                label: 'Multi 2',
                content: Component.text('Content 2'),
              ),
            ],
          ),
        );

        expect(find.text('Multi 1'), findsOneComponent);
        expect(find.text('Multi 2'), findsOneComponent);
      });

      testComponents('renders with multiple=false (default)', (tester) async {
        tester.pumpComponent(
          DAccordion(
            multiple: false,
            items: [
              DAccordionItem(
                label: 'Single 1',
                content: Component.text('Content 1'),
              ),
              DAccordionItem(
                label: 'Single 2',
                content: Component.text('Content 2'),
              ),
            ],
          ),
        );

        expect(find.text('Single 1'), findsOneComponent);
        expect(find.text('Single 2'), findsOneComponent);
      });
    });

    group('integration', () {
      testComponents('renders complete accordion structure', (tester) async {
        tester.pumpComponent(
          DAccordion(
            defaultValue: 'first',
            multiple: false,
            size: DSize.md,
            variant: DAccordionVariant.soft,
            items: [
              DAccordionItem(
                label: 'Getting Started',
                description: 'Learn the basics',
                content: div([
                  p([Component.text('Welcome to the accordion!')]),
                ]),
                value: 'first',
              ),
              DAccordionItem(
                label: 'Advanced Topics',
                description: 'Deep dive into features',
                content: Component.text('Advanced content here'),
                value: 'second',
              ),
              DAccordionItem(
                label: 'FAQ',
                content: Component.text('Frequently asked questions'),
                value: 'faq',
                disabled: true,
              ),
            ],
          ),
        );

        expect(find.text('Getting Started'), findsOneComponent);
        expect(find.text('Learn the basics'), findsOneComponent);
        expect(find.text('Welcome to the accordion!'), findsOneComponent);
        expect(find.text('Advanced Topics'), findsOneComponent);
        expect(find.text('Deep dive into features'), findsOneComponent);
        expect(find.text('FAQ'), findsOneComponent);
        // FAQ content should not be visible since it's not defaultValue
        expect(find.text('Frequently asked questions'), findsNothing);
      });
    });
  });
}
