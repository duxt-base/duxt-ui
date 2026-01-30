import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/content/empty.dart';
import 'package:duxt_ui/src/theme/variants.dart';

void main() {
  group('DEmpty', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(
          DEmpty(),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with title', (tester) async {
        tester.pumpComponent(
          DEmpty(title: 'No items'),
        );

        expect(find.text('No items'), findsOneComponent);
        expect(find.tag('h3'), findsOneComponent);
      });

      testComponents('renders with description', (tester) async {
        tester.pumpComponent(
          DEmpty(
            title: 'Empty',
            description: 'There is nothing here yet',
          ),
        );

        expect(find.text('Empty'), findsOneComponent);
        expect(find.text('There is nothing here yet'), findsOneComponent);
      });

      testComponents('renders with custom icon string', (tester) async {
        tester.pumpComponent(
          DEmpty(
            icon: '📭',
            title: 'No messages',
          ),
        );

        expect(find.text('📭'), findsOneComponent);
        expect(find.text('No messages'), findsOneComponent);
      });

      testComponents('renders with icon component', (tester) async {
        tester.pumpComponent(
          DEmpty(
            iconComponent: span([Component.text('Custom Icon')]),
            title: 'With Icon Component',
          ),
        );

        expect(find.text('Custom Icon'), findsOneComponent);
        expect(find.text('With Icon Component'), findsOneComponent);
      });

      testComponents('renders with action', (tester) async {
        tester.pumpComponent(
          DEmpty(
            title: 'No data',
            action: button([Component.text('Add Item')]),
          ),
        );

        expect(find.text('No data'), findsOneComponent);
        expect(find.text('Add Item'), findsOneComponent);
        expect(find.tag('button'), findsOneComponent);
      });

      testComponents('renders with children', (tester) async {
        tester.pumpComponent(
          DEmpty(
            title: 'Empty State',
            children: [
              p([Component.text('Additional info')]),
            ],
          ),
        );

        expect(find.text('Empty State'), findsOneComponent);
        expect(find.text('Additional info'), findsOneComponent);
      });

      testComponents('renders with padded=false', (tester) async {
        tester.pumpComponent(
          DEmpty(
            title: 'No padding',
            padded: false,
          ),
        );

        expect(find.text('No padding'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DEmpty(
            size: DSize.xs,
            title: 'XS Empty',
          ),
        );

        expect(find.text('XS Empty'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DEmpty(
            size: DSize.sm,
            title: 'SM Empty',
          ),
        );

        expect(find.text('SM Empty'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DEmpty(
            size: DSize.md,
            title: 'MD Empty',
          ),
        );

        expect(find.text('MD Empty'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DEmpty(
            size: DSize.lg,
            title: 'LG Empty',
          ),
        );

        expect(find.text('LG Empty'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DEmpty(
            size: DSize.xl,
            title: 'XL Empty',
          ),
        );

        expect(find.text('XL Empty'), findsOneComponent);
      });
    });

    group('integration', () {
      testComponents('renders complete empty state', (tester) async {
        tester.pumpComponent(
          DEmpty(
            icon: '📋',
            title: 'No tasks yet',
            description: 'Create your first task to get started',
            action: button([Component.text('Create Task')]),
            size: DSize.lg,
          ),
        );

        expect(find.text('📋'), findsOneComponent);
        expect(find.text('No tasks yet'), findsOneComponent);
        expect(find.text('Create your first task to get started'), findsOneComponent);
        expect(find.text('Create Task'), findsOneComponent);
      });
    });
  });

  group('DEmptyNoData', () {
    testComponents('renders default no data state', (tester) async {
      tester.pumpComponent(
        DEmptyNoData(),
      );

      expect(find.text('No data'), findsOneComponent);
      expect(find.text('There is no data to display at the moment.'), findsOneComponent);
    });

    testComponents('renders with action', (tester) async {
      tester.pumpComponent(
        DEmptyNoData(
          action: button([Component.text('Refresh')]),
        ),
      );

      expect(find.text('No data'), findsOneComponent);
      expect(find.text('Refresh'), findsOneComponent);
    });
  });

  group('DEmptyNoResults', () {
    testComponents('renders default no results state', (tester) async {
      tester.pumpComponent(
        DEmptyNoResults(),
      );

      expect(find.text('No results found'), findsOneComponent);
      expect(find.text('No results match your search criteria.'), findsOneComponent);
    });

    testComponents('renders with search term', (tester) async {
      tester.pumpComponent(
        DEmptyNoResults(searchTerm: 'flutter'),
      );

      expect(find.text('No results found'), findsOneComponent);
      expect(find.text('No results found for "flutter". Try a different search term.'), findsOneComponent);
    });

    testComponents('renders with action', (tester) async {
      tester.pumpComponent(
        DEmptyNoResults(
          action: button([Component.text('Clear Search')]),
        ),
      );

      expect(find.text('No results found'), findsOneComponent);
      expect(find.text('Clear Search'), findsOneComponent);
    });

    testComponents('renders with search term and action', (tester) async {
      tester.pumpComponent(
        DEmptyNoResults(
          searchTerm: 'test query',
          action: button([Component.text('Reset')]),
        ),
      );

      expect(find.text('No results found'), findsOneComponent);
      expect(find.text('No results found for "test query". Try a different search term.'), findsOneComponent);
      expect(find.text('Reset'), findsOneComponent);
    });
  });
}
