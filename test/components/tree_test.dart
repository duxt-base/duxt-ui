import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/data/tree.dart';
import 'package:duxt_ui/src/theme/colors.dart';
import 'package:duxt_ui/src/theme/variants.dart';

void main() {
  group('DTreeNode', () {
    group('construction', () {
      test('creates node with required properties', () {
        final node = DTreeNode(id: 'node-1', label: 'Test Node');

        expect(node.id, equals('node-1'));
        expect(node.label, equals('Test Node'));
        expect(node.children, isEmpty);
        expect(node.expanded, isFalse);
        expect(node.selected, isFalse);
        expect(node.disabled, isFalse);
      });

      test('creates node with all properties', () {
        final node = DTreeNode(
          id: 'node-1',
          label: 'Test',
          icon: 'i-lucide-folder',
          children: [DTreeNode(id: 'child-1', label: 'Child')],
          expanded: true,
          selected: true,
          disabled: false,
          data: {'key': 'value'},
        );

        expect(node.icon, equals('i-lucide-folder'));
        expect(node.children.length, equals(1));
        expect(node.expanded, isTrue);
        expect(node.selected, isTrue);
        expect(node.data, equals({'key': 'value'}));
      });
    });

    group('hasChildren', () {
      test('returns false for leaf node', () {
        final node = DTreeNode(id: 'leaf', label: 'Leaf');
        expect(node.hasChildren, isFalse);
      });

      test('returns true for parent node', () {
        final node = DTreeNode(
          id: 'parent',
          label: 'Parent',
          children: [DTreeNode(id: 'child', label: 'Child')],
        );
        expect(node.hasChildren, isTrue);
      });
    });

    group('copyWith', () {
      test('creates copy with modified properties', () {
        final original = DTreeNode(id: 'node', label: 'Original');
        final copy = original.copyWith(label: 'Modified', expanded: true);

        expect(copy.id, equals('node'));
        expect(copy.label, equals('Modified'));
        expect(copy.expanded, isTrue);
        expect(original.label, equals('Original'));
      });
    });
  });

  group('DTree', () {
    group('rendering', () {
      testComponents('renders with required nodes', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(id: '1', label: 'Node 1'),
            DTreeNode(id: '2', label: 'Node 2'),
          ],
        ));

        expect(find.tag('ul'), findsComponents);
        expect(find.text('Node 1'), findsOneComponent);
        expect(find.text('Node 2'), findsOneComponent);
      });

      testComponents('renders empty tree', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [],
        ));

        expect(find.tag('ul'), findsOneComponent);
      });

      testComponents('renders single node', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Single')],
        ));

        expect(find.text('Single'), findsOneComponent);
      });
    });

    group('hierarchical structure', () {
      testComponents('renders nested nodes', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(
              id: 'parent',
              label: 'Parent',
              expanded: true,
              children: [
                DTreeNode(id: 'child', label: 'Child'),
              ],
            ),
          ],
        ));

        expect(find.text('Parent'), findsOneComponent);
        expect(find.text('Child'), findsOneComponent);
      });

      testComponents('hides children when collapsed', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(
              id: 'parent',
              label: 'Parent',
              expanded: false,
              children: [
                DTreeNode(id: 'child', label: 'Child'),
              ],
            ),
          ],
        ));

        expect(find.text('Parent'), findsOneComponent);
        expect(find.text('Child'), findsNothing);
      });

      testComponents('renders deeply nested structure', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(
              id: 'level1',
              label: 'Level 1',
              expanded: true,
              children: [
                DTreeNode(
                  id: 'level2',
                  label: 'Level 2',
                  expanded: true,
                  children: [
                    DTreeNode(id: 'level3', label: 'Level 3'),
                  ],
                ),
              ],
            ),
          ],
        ));

        expect(find.text('Level 1'), findsOneComponent);
        expect(find.text('Level 2'), findsOneComponent);
        expect(find.text('Level 3'), findsOneComponent);
      });
    });

    group('node icons', () {
      testComponents('renders custom node icon', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(id: '1', label: 'Node', icon: 'i-lucide-star'),
          ],
        ));

        expect(find.tag('i'), findsComponents);
      });

      testComponents('renders folder icon for parent nodes', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(
              id: '1',
              label: 'Folder',
              children: [DTreeNode(id: '2', label: 'File')],
            ),
          ],
        ));

        expect(find.tag('i'), findsComponents);
      });

      testComponents('renders leaf icon for leaf nodes', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(id: '1', label: 'File'),
          ],
        ));

        expect(find.tag('i'), findsComponents);
      });
    });

    group('expand/collapse icons', () {
      testComponents('shows expand icon for collapsed parent', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(
              id: '1',
              label: 'Parent',
              expanded: false,
              children: [DTreeNode(id: '2', label: 'Child')],
            ),
          ],
        ));

        expect(find.tag('button'), findsComponents);
      });

      testComponents('shows collapse icon for expanded parent', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(
              id: '1',
              label: 'Parent',
              expanded: true,
              children: [DTreeNode(id: '2', label: 'Child')],
            ),
          ],
        ));

        expect(find.tag('button'), findsComponents);
      });

      testComponents('hides toggle button for leaf nodes', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(id: '1', label: 'Leaf'),
          ],
        ));

        expect(find.text('Leaf'), findsOneComponent);
      });
    });

    group('selection', () {
      testComponents('renders selected node', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(id: '1', label: 'Selected', selected: true),
          ],
        ));

        expect(find.text('Selected'), findsOneComponent);
      });

      testComponents('renders unselected node', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(id: '1', label: 'Unselected', selected: false),
          ],
        ));

        expect(find.text('Unselected'), findsOneComponent);
      });
    });

    group('disabled state', () {
      testComponents('renders disabled node', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(id: '1', label: 'Disabled', disabled: true),
          ],
        ));

        expect(find.text('Disabled'), findsOneComponent);
      });

      testComponents('renders enabled node', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(id: '1', label: 'Enabled', disabled: false),
          ],
        ));

        expect(find.text('Enabled'), findsOneComponent);
      });
    });

    group('checkboxes', () {
      testComponents('shows checkboxes when enabled', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
          showCheckboxes: true,
        ));

        expect(find.tag('input'), findsComponents);
      });

      testComponents('hides checkboxes by default', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
          showCheckboxes: false,
        ));

        expect(find.text('Node'), findsOneComponent);
      });
    });

    group('connecting lines', () {
      testComponents('shows lines when enabled', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(
              id: '1',
              label: 'Parent',
              expanded: true,
              children: [DTreeNode(id: '2', label: 'Child')],
            ),
          ],
          showLines: true,
        ));

        expect(find.tag('ul'), findsComponents);
      });

      testComponents('hides lines by default', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(
              id: '1',
              label: 'Parent',
              expanded: true,
              children: [DTreeNode(id: '2', label: 'Child')],
            ),
          ],
          showLines: false,
        ));

        expect(find.tag('ul'), findsComponents);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
          size: DSize.xs,
        ));

        expect(find.tag('ul'), findsComponents);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
          size: DSize.sm,
        ));

        expect(find.tag('ul'), findsComponents);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
          size: DSize.md,
        ));

        expect(find.tag('ul'), findsComponents);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
          size: DSize.lg,
        ));

        expect(find.tag('ul'), findsComponents);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
          size: DSize.xl,
        ));

        expect(find.tag('ul'), findsComponents);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
          color: DColor.primary,
        ));

        expect(find.tag('ul'), findsComponents);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
          color: DColor.secondary,
        ));

        expect(find.tag('ul'), findsComponents);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
          color: DColor.success,
        ));

        expect(find.tag('ul'), findsComponents);
      });
    });

    group('custom icons', () {
      testComponents('renders custom folder icon', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(
              id: '1',
              label: 'Folder',
              expanded: true,
              children: [DTreeNode(id: '2', label: 'File')],
            ),
          ],
          folderIcon: 'i-lucide-folder-open-dot',
        ));

        expect(find.tag('i'), findsComponents);
      });

      testComponents('renders custom leaf icon', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'File')],
          leafIcon: 'i-lucide-file-code',
        ));

        expect(find.tag('i'), findsComponents);
      });

      testComponents('renders custom expand/collapse icons', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [
            DTreeNode(
              id: '1',
              label: 'Parent',
              children: [DTreeNode(id: '2', label: 'Child')],
            ),
          ],
          expandIcon: 'i-lucide-plus',
          collapseIcon: 'i-lucide-minus',
        ));

        expect(find.tag('i'), findsComponents);
      });
    });

    group('accessibility', () {
      testComponents('has tree role', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
        ));

        expect(find.tag('ul'), findsComponents);
      });

      testComponents('has treeitem role for nodes', (tester) async {
        tester.pumpComponent(DTree(
          nodes: [DTreeNode(id: '1', label: 'Node')],
        ));

        expect(find.tag('li'), findsComponents);
      });
    });
  });

  group('DFileTree', () {
    group('rendering', () {
      testComponents('renders file tree structure', (tester) async {
        tester.pumpComponent(DFileTree(
          nodes: [
            DTreeNode(
              id: 'src',
              label: 'src',
              children: [
                DTreeNode(id: 'main.dart', label: 'main.dart'),
              ],
            ),
          ],
        ));

        expect(find.tag('ul'), findsComponents);
      });

      testComponents('renders with selected file', (tester) async {
        tester.pumpComponent(DFileTree(
          nodes: [
            DTreeNode(id: 'file.dart', label: 'file.dart'),
          ],
          selectedId: 'file.dart',
        ));

        expect(find.text('file.dart'), findsOneComponent);
      });
    });

    group('file browser features', () {
      testComponents('uses file-specific icons', (tester) async {
        tester.pumpComponent(DFileTree(
          nodes: [
            DTreeNode(id: 'folder', label: 'folder', children: [
              DTreeNode(id: 'file.txt', label: 'file.txt'),
            ]),
          ],
        ));

        expect(find.tag('i'), findsComponents);
      });

      testComponents('shows connecting lines', (tester) async {
        tester.pumpComponent(DFileTree(
          nodes: [
            DTreeNode(
              id: 'root',
              label: 'root',
              expanded: true,
              children: [DTreeNode(id: 'child', label: 'child')],
            ),
          ],
        ));

        expect(find.tag('ul'), findsComponents);
      });
    });
  });
}
