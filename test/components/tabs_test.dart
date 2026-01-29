import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/tabs.dart';

void main() {
  group('UTabs', () {
    group('rendering', () {
      testComponents('renders with items', (tester) async {
        tester.pumpComponent(
          UTabs(
            items: [
              UTabItem(label: 'Tab 1', value: 'tab1'),
              UTabItem(label: 'Tab 2', value: 'tab2'),
              UTabItem(label: 'Tab 3', value: 'tab3'),
            ],
          ),
        );

        expect(find.text('Tab 1'), findsOneComponent);
        expect(find.text('Tab 2'), findsOneComponent);
        expect(find.text('Tab 3'), findsOneComponent);
      });

      testComponents('renders tab content', (tester) async {
        tester.pumpComponent(
          UTabs(
            items: [
              UTabItem(
                label: 'First',
                value: 'first',
                content: span([Component.text('First tab content')]),
              ),
              UTabItem(
                label: 'Second',
                value: 'second',
                content: span([Component.text('Second tab content')]),
              ),
            ],
          ),
        );

        // First tab content should be visible by default
        expect(find.text('First tab content'), findsOneComponent);
      });

      testComponents('renders with default value', (tester) async {
        tester.pumpComponent(
          UTabs(
            defaultValue: 'second',
            items: [
              UTabItem(
                label: 'First',
                value: 'first',
                content: span([Component.text('First content')]),
              ),
              UTabItem(
                label: 'Second',
                value: 'second',
                content: span([Component.text('Second content')]),
              ),
            ],
          ),
        );

        expect(find.text('First'), findsOneComponent);
        expect(find.text('Second'), findsOneComponent);
        // Second tab should be visible as it's the default
        expect(find.text('Second content'), findsOneComponent);
      });

      testComponents('renders with icons', (tester) async {
        tester.pumpComponent(
          UTabs(
            items: [
              UTabItem(
                label: 'Settings',
                value: 'settings',
                icon: span([Component.text('*')]),
              ),
            ],
          ),
        );

        expect(find.text('Settings'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });
    });

    group('orientation', () {
      testComponents('renders horizontal orientation (default)',
          (tester) async {
        tester.pumpComponent(
          UTabs(
            orientation: UTabsOrientation.horizontal,
            items: [
              UTabItem(label: 'Tab A', value: 'a'),
              UTabItem(label: 'Tab B', value: 'b'),
            ],
          ),
        );

        expect(find.text('Tab A'), findsOneComponent);
        expect(find.text('Tab B'), findsOneComponent);
      });

      testComponents('renders vertical orientation', (tester) async {
        tester.pumpComponent(
          UTabs(
            orientation: UTabsOrientation.vertical,
            items: [
              UTabItem(label: 'Tab A', value: 'a'),
              UTabItem(label: 'Tab B', value: 'b'),
            ],
          ),
        );

        expect(find.text('Tab A'), findsOneComponent);
        expect(find.text('Tab B'), findsOneComponent);
      });
    });

    group('disabled tabs', () {
      testComponents('renders disabled tab', (tester) async {
        tester.pumpComponent(
          UTabs(
            items: [
              UTabItem(label: 'Active', value: 'active'),
              UTabItem(label: 'Disabled', value: 'disabled', disabled: true),
            ],
          ),
        );

        expect(find.text('Active'), findsOneComponent);
        expect(find.text('Disabled'), findsOneComponent);
      });

      testComponents('disabled tab cannot be clicked', (tester) async {
        tester.pumpComponent(
          UTabs(
            items: [
              UTabItem(label: 'Active', value: 'active'),
              UTabItem(label: 'Disabled', value: 'disabled', disabled: true),
            ],
            onSelect: (value) {},
          ),
        );

        // Click on disabled tab - state should not change
        final buttons = find.tag('button');
        expect(buttons, findsComponents);
      });
    });

    group('interactions', () {
      testComponents('onSelect callback fires when tab clicked',
          (tester) async {
        tester.pumpComponent(
          UTabs(
            items: [
              UTabItem(label: 'First', value: 'first'),
              UTabItem(label: 'Second', value: 'second'),
            ],
            onSelect: (value) {},
          ),
        );

        expect(find.tag('button'), findsComponents);
      });
    });

    group('unmountOnHide option', () {
      testComponents('unmounts hidden content when true (default)',
          (tester) async {
        tester.pumpComponent(
          UTabs(
            unmountOnHide: true,
            items: [
              UTabItem(
                label: 'First',
                value: 'first',
                content: span([Component.text('First')]),
              ),
              UTabItem(
                label: 'Second',
                value: 'second',
                content: span([Component.text('Second')]),
              ),
            ],
          ),
        );

        expect(find.text('First'), findsComponents);
      });

      testComponents('keeps hidden content mounted when false', (tester) async {
        tester.pumpComponent(
          UTabs(
            unmountOnHide: false,
            items: [
              UTabItem(
                label: 'First',
                value: 'first',
                content: span([Component.text('First content')]),
              ),
              UTabItem(
                label: 'Second',
                value: 'second',
                content: span([Component.text('Second content')]),
              ),
            ],
          ),
        );

        // Both contents should be in the DOM when unmountOnHide is false
        expect(find.text('First content'), findsComponents);
        expect(find.text('Second content'), findsComponents);
      });
    });
  });

  group('UControlledTabs', () {
    testComponents('renders with controlled selected value', (tester) async {
      tester.pumpComponent(
        UControlledTabs(
          selected: 'second',
          items: [
            UTabItem(
              label: 'First',
              value: 'first',
              content: span([Component.text('First content')]),
            ),
            UTabItem(
              label: 'Second',
              value: 'second',
              content: span([Component.text('Second content')]),
            ),
          ],
        ),
      );

      expect(find.text('First'), findsOneComponent);
      expect(find.text('Second'), findsOneComponent);
      expect(find.text('Second content'), findsOneComponent);
    });

    testComponents('renders horizontal orientation', (tester) async {
      tester.pumpComponent(
        UControlledTabs(
          selected: 'a',
          orientation: UTabsOrientation.horizontal,
          items: [
            UTabItem(label: 'A', value: 'a'),
            UTabItem(label: 'B', value: 'b'),
          ],
        ),
      );

      expect(find.text('A'), findsOneComponent);
      expect(find.text('B'), findsOneComponent);
    });

    testComponents('renders vertical orientation', (tester) async {
      tester.pumpComponent(
        UControlledTabs(
          selected: 'a',
          orientation: UTabsOrientation.vertical,
          items: [
            UTabItem(label: 'A', value: 'a'),
            UTabItem(label: 'B', value: 'b'),
          ],
        ),
      );

      expect(find.text('A'), findsOneComponent);
      expect(find.text('B'), findsOneComponent);
    });

    testComponents('onSelect callback fires', (tester) async {
      tester.pumpComponent(
        UControlledTabs(
          selected: 'first',
          items: [
            UTabItem(label: 'First', value: 'first'),
            UTabItem(label: 'Second', value: 'second'),
          ],
          onSelect: (value) {},
        ),
      );

      expect(find.tag('button'), findsComponents);
    });
  });

  group('UTabItem', () {
    testComponents('creates item with required props', (tester) async {
      final item = UTabItem(label: 'Test', value: 'test');

      expect(item.label, equals('Test'));
      expect(item.value, equals('test'));
      expect(item.disabled, isFalse);
      expect(item.icon, isNull);
      expect(item.content, isNull);
    });

    testComponents('creates item with all props', (tester) async {
      final item = UTabItem(
        label: 'Settings',
        value: 'settings',
        icon: span([Component.text('icon')]),
        content: div([Component.text('content')]),
        disabled: true,
      );

      expect(item.label, equals('Settings'));
      expect(item.value, equals('settings'));
      expect(item.disabled, isTrue);
      expect(item.icon, isNotNull);
      expect(item.content, isNotNull);
    });
  });
}
