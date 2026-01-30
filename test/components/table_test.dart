import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/table.dart';

void main() {
  group('DTable', () {
    final sampleColumns = [
      DTableColumn<Map<String, dynamic>>(key: 'id', label: 'ID'),
      DTableColumn<Map<String, dynamic>>(key: 'name', label: 'Name'),
      DTableColumn<Map<String, dynamic>>(key: 'email', label: 'Email'),
    ];

    final sampleData = [
      {'id': '1', 'name': 'John Doe', 'email': 'john@example.com'},
      {'id': '2', 'name': 'Jane Smith', 'email': 'jane@example.com'},
      {'id': '3', 'name': 'Bob Wilson', 'email': 'bob@example.com'},
    ];

    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
      });

      testComponents('renders table structure', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
        expect(find.tag('thead'), findsOneComponent);
        expect(find.tag('tbody'), findsOneComponent);
      });

      testComponents('renders column headers', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
          ),
        );

        expect(find.text('ID'), findsOneComponent);
        expect(find.text('Name'), findsOneComponent);
        expect(find.text('Email'), findsOneComponent);
      });

      testComponents('renders data rows', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
          ),
        );

        expect(find.text('John Doe'), findsOneComponent);
        expect(find.text('Jane Smith'), findsOneComponent);
        expect(find.text('Bob Wilson'), findsOneComponent);
      });

      testComponents('renders all data cells', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
          ),
        );

        expect(find.text('1'), findsOneComponent);
        expect(find.text('john@example.com'), findsOneComponent);
        expect(find.text('jane@example.com'), findsOneComponent);
      });

      testComponents('renders header row', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
          ),
        );

        expect(find.tag('tr'), findsComponents);
        expect(find.tag('th'), findsComponents);
      });

      testComponents('renders data cells', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
          ),
        );

        expect(find.tag('td'), findsComponents);
      });
    });

    group('empty state', () {
      testComponents('renders empty table when no data', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: [],
          ),
        );

        expect(find.tag('table'), findsOneComponent);
        expect(find.tag('thead'), findsOneComponent);
        expect(find.tag('tbody'), findsOneComponent);
      });

      testComponents('renders emptyState when provided and no data', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: [],
            emptyState: span([Component.text('No data available')]),
          ),
        );

        expect(find.text('No data available'), findsOneComponent);
      });

      testComponents('does not render emptyState when data exists', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
            emptyState: span([Component.text('No data available')]),
          ),
        );

        expect(find.text('No data available'), findsNothing);
        expect(find.text('John Doe'), findsOneComponent);
      });
    });

    group('striped', () {
      testComponents('renders without stripes by default', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
            striped: false,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
      });

      testComponents('renders with striped rows', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
            striped: true,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
        expect(find.tag('tr'), findsComponents);
      });
    });

    group('hoverable', () {
      testComponents('renders with hoverable rows by default', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
      });

      testComponents('renders without hoverable when disabled', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
            hoverable: false,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
      });
    });

    group('bordered', () {
      testComponents('renders without border by default', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
            bordered: false,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
      });

      testComponents('renders with border', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
            bordered: true,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
      });
    });

    group('custom render', () {
      testComponents('renders with custom cell renderer', (tester) async {
        final customColumns = [
          DTableColumn<Map<String, dynamic>>(key: 'id', label: 'ID'),
          DTableColumn<Map<String, dynamic>>(
            key: 'name',
            label: 'Name',
            render: (item) => strong([Component.text(item['name'] as String)]),
          ),
        ];

        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: customColumns,
            data: sampleData,
          ),
        );

        expect(find.tag('strong'), findsComponents);
        expect(find.text('John Doe'), findsOneComponent);
      });

      testComponents('renders with custom classes on column', (tester) async {
        final customColumns = [
          DTableColumn<Map<String, dynamic>>(
            key: 'id',
            label: 'ID',
            classes: 'text-center',
          ),
          DTableColumn<Map<String, dynamic>>(key: 'name', label: 'Name'),
        ];

        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: customColumns,
            data: sampleData,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
      });
    });

    group('combinations', () {
      testComponents('renders striped and bordered', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
            striped: true,
            bordered: true,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
      });

      testComponents('renders striped and hoverable', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
            striped: true,
            hoverable: true,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
      });

      testComponents('renders all options enabled', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
            striped: true,
            hoverable: true,
            bordered: true,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
      });

      testComponents('renders all options disabled', (tester) async {
        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: sampleData,
            striped: false,
            hoverable: false,
            bordered: false,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
      });
    });

    group('single column', () {
      testComponents('renders with single column', (tester) async {
        final singleColumn = [
          DTableColumn<Map<String, dynamic>>(key: 'name', label: 'Name'),
        ];

        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: singleColumn,
            data: sampleData,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
        expect(find.text('Name'), findsOneComponent);
        expect(find.text('John Doe'), findsOneComponent);
      });
    });

    group('single row', () {
      testComponents('renders with single row', (tester) async {
        final singleRow = [
          {'id': '1', 'name': 'Solo User', 'email': 'solo@example.com'},
        ];

        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: singleRow,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
        expect(find.text('Solo User'), findsOneComponent);
      });
    });

    group('missing keys', () {
      testComponents('renders empty string for missing keys', (tester) async {
        final dataWithMissingKey = [
          {'id': '1', 'name': 'John'},
        ];

        tester.pumpComponent(
          DTable<Map<String, dynamic>>(
            columns: sampleColumns,
            data: dataWithMissingKey,
          ),
        );

        expect(find.tag('table'), findsOneComponent);
        expect(find.text('John'), findsOneComponent);
      });
    });
  });

  group('DTableColumn', () {
    testComponents('creates column with required parameters', (tester) async {
      final column = DTableColumn<Map<String, dynamic>>(
        key: 'test',
        label: 'Test Column',
      );

      expect(column.key, equals('test'));
      expect(column.label, equals('Test Column'));
      expect(column.render, isNull);
      expect(column.classes, isNull);
    });

    testComponents('creates column with all parameters', (tester) async {
      final column = DTableColumn<Map<String, dynamic>>(
        key: 'test',
        label: 'Test Column',
        render: (item) => span([Component.text('custom')]),
        classes: 'custom-class',
      );

      expect(column.key, equals('test'));
      expect(column.label, equals('Test Column'));
      expect(column.render, isNotNull);
      expect(column.classes, equals('custom-class'));
    });
  });
}
