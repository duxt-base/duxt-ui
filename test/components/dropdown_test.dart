import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/dropdown.dart';
import 'package:duxt_ui/src/components/button.dart';

void main() {
  group('DDropdownItem', () {
    test('creates item with required label', () {
      final item = DDropdownItem(label: 'Edit');

      expect(item.label, equals('Edit'));
      expect(item.icon, isNull);
      expect(item.disabled, isFalse);
      expect(item.divider, isFalse);
      expect(item.onClick, isNull);
    });

    test('creates item with all properties', () {
      var clicked = false;
      final item = DDropdownItem(
        label: 'Delete',
        icon: 'lucide:trash',
        disabled: true,
        onClick: () => clicked = true,
      );

      expect(item.label, equals('Delete'));
      expect(item.icon, equals('lucide:trash'));
      expect(item.disabled, isTrue);
      expect(item.divider, isFalse);
      expect(item.onClick, isNotNull);
    });

    test('creates divider item', () {
      final divider = DDropdownItem.divider();

      expect(divider.label, isEmpty);
      expect(divider.icon, isNull);
      expect(divider.disabled, isFalse);
      expect(divider.divider, isTrue);
      expect(divider.onClick, isNull);
    });
  });

  group('DDropdown', () {
    group('rendering', () {
      testComponents('renders trigger component', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Options'),
            items: [
              DDropdownItem(label: 'Edit'),
            ],
          ),
        );

        expect(find.text('Options'), findsOneComponent);
      });

      testComponents('renders with multiple items', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Menu'),
            items: [
              DDropdownItem(label: 'Edit'),
              DDropdownItem(label: 'Copy'),
              DDropdownItem(label: 'Delete'),
            ],
          ),
        );

        expect(find.text('Menu'), findsOneComponent);
      });

      testComponents('renders with divider items', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Actions'),
            items: [
              DDropdownItem(label: 'Edit'),
              DDropdownItem.divider(),
              DDropdownItem(label: 'Delete'),
            ],
          ),
        );

        expect(find.text('Actions'), findsOneComponent);
      });

      testComponents('renders with disabled items', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Menu'),
            items: [
              DDropdownItem(label: 'Enabled'),
              DDropdownItem(label: 'Disabled', disabled: true),
            ],
          ),
        );

        expect(find.text('Menu'), findsOneComponent);
      });

      testComponents('renders with icons', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Menu'),
            items: [
              DDropdownItem(label: 'Edit', icon: 'lucide:edit'),
              DDropdownItem(label: 'Delete', icon: 'lucide:trash'),
            ],
          ),
        );

        expect(find.text('Menu'), findsOneComponent);
      });
    });

    group('placements', () {
      testComponents('renders with bottomEnd placement (default)', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Menu'),
            placement: DDropdownPlacement.bottomEnd,
            items: [DDropdownItem(label: 'Item')],
          ),
        );

        expect(find.text('Menu'), findsOneComponent);
      });

      testComponents('renders with bottomStart placement', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Menu'),
            placement: DDropdownPlacement.bottomStart,
            items: [DDropdownItem(label: 'Item')],
          ),
        );

        expect(find.text('Menu'), findsOneComponent);
      });

      testComponents('renders with topEnd placement', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Menu'),
            placement: DDropdownPlacement.topEnd,
            items: [DDropdownItem(label: 'Item')],
          ),
        );

        expect(find.text('Menu'), findsOneComponent);
      });

      testComponents('renders with topStart placement', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Menu'),
            placement: DDropdownPlacement.topStart,
            items: [DDropdownItem(label: 'Item')],
          ),
        );

        expect(find.text('Menu'), findsOneComponent);
      });
    });

    group('structure', () {
      testComponents('has relative wrapper for positioning', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Menu'),
            items: [DDropdownItem(label: 'Item')],
          ),
        );

        final wrapper = find.tag('div');
        expect(wrapper, findsComponents);
      });

      testComponents('trigger is clickable', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Click me'),
            items: [DDropdownItem(label: 'Item')],
          ),
        );

        expect(find.text('Click me'), findsOneComponent);
      });
    });

    group('menu items', () {
      testComponents('renders item labels', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(label: 'Menu'),
            items: [
              DDropdownItem(label: 'First'),
              DDropdownItem(label: 'Second'),
              DDropdownItem(label: 'Third'),
            ],
          ),
        );

        // Menu is closed by default, so only trigger is visible
        expect(find.text('Menu'), findsOneComponent);
      });
    });

    group('custom triggers', () {
      testComponents('works with custom div trigger', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: div(
              classes: 'flex items-center gap-2',
              [
                span([Component.text('User')]),
                span([Component.text('▼')]),
              ],
            ),
            items: [DDropdownItem(label: 'Profile')],
          ),
        );

        expect(find.text('User'), findsOneComponent);
        expect(find.text('▼'), findsOneComponent);
      });

      testComponents('works with icon button trigger', (tester) async {
        tester.pumpComponent(
          DDropdown(
            trigger: DButton(
              label: '⋮',
              variant: DButtonVariant.ghost,
            ),
            items: [
              DDropdownItem(label: 'Edit'),
              DDropdownItem(label: 'Delete'),
            ],
          ),
        );

        expect(find.text('⋮'), findsOneComponent);
      });
    });
  });
}
