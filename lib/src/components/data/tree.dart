import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// Tree node data structure
class UTreeNode {
  /// Unique identifier for the node
  final String id;

  /// Display label
  final String label;

  /// Optional icon class
  final String? icon;

  /// Child nodes
  final List<UTreeNode> children;

  /// Whether this node is initially expanded
  final bool expanded;

  /// Whether this node is selected
  final bool selected;

  /// Whether this node is disabled
  final bool disabled;

  /// Custom data associated with this node
  final dynamic data;

  const UTreeNode({
    required this.id,
    required this.label,
    this.icon,
    this.children = const [],
    this.expanded = false,
    this.selected = false,
    this.disabled = false,
    this.data,
  });

  /// Check if node has children
  bool get hasChildren => children.isNotEmpty;

  /// Create a copy with modified properties
  UTreeNode copyWith({
    String? id,
    String? label,
    String? icon,
    List<UTreeNode>? children,
    bool? expanded,
    bool? selected,
    bool? disabled,
    dynamic data,
  }) {
    return UTreeNode(
      id: id ?? this.id,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      children: children ?? this.children,
      expanded: expanded ?? this.expanded,
      selected: selected ?? this.selected,
      disabled: disabled ?? this.disabled,
      data: data ?? this.data,
    );
  }
}

/// DuxtUI Tree component - Hierarchical list with expand/collapse
class UTree extends StatefulComponent {
  /// Root nodes of the tree
  final List<UTreeNode> nodes;

  /// Callback when a node is selected
  final void Function(UTreeNode node)? onSelect;

  /// Callback when a node is expanded/collapsed
  final void Function(UTreeNode node, bool expanded)? onToggle;

  /// Whether multiple nodes can be selected
  final bool multiSelect;

  /// Whether to show checkboxes
  final bool showCheckboxes;

  /// Whether to show connecting lines
  final bool showLines;

  /// Default icon for folder/parent nodes
  final String folderIcon;

  /// Default icon for collapsed folder
  final String folderCollapsedIcon;

  /// Default icon for leaf nodes
  final String leafIcon;

  /// Expand icon
  final String expandIcon;

  /// Collapse icon
  final String collapseIcon;

  /// Tree color
  final UColor color;

  /// Size
  final USize size;

  const UTree({
    super.key,
    required this.nodes,
    this.onSelect,
    this.onToggle,
    this.multiSelect = false,
    this.showCheckboxes = false,
    this.showLines = false,
    this.folderIcon = 'i-lucide-folder-open',
    this.folderCollapsedIcon = 'i-lucide-folder',
    this.leafIcon = 'i-lucide-file',
    this.expandIcon = 'i-lucide-chevron-down',
    this.collapseIcon = 'i-lucide-chevron-right',
    this.color = UColor.primary,
    this.size = USize.md,
  });

  @override
  State<UTree> createState() => _UTreeState();
}

class _UTreeState extends State<UTree> {
  late Map<String, bool> _expandedState;
  late Set<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _expandedState = {};
    _selectedIds = {};
    _initializeState(component.nodes);
  }

  void _initializeState(List<UTreeNode> nodes) {
    for (final node in nodes) {
      _expandedState[node.id] = node.expanded;
      if (node.selected) {
        _selectedIds.add(node.id);
      }
      if (node.hasChildren) {
        _initializeState(node.children);
      }
    }
  }

  bool _isExpanded(String id) => _expandedState[id] ?? false;

  bool _isSelected(String id) => _selectedIds.contains(id);

  void _toggleExpand(UTreeNode node) {
    setState(() {
      _expandedState[node.id] = !_isExpanded(node.id);
    });
    component.onToggle?.call(node, _isExpanded(node.id));
  }

  void _selectNode(UTreeNode node) {
    if (node.disabled) return;

    setState(() {
      if (component.multiSelect) {
        if (_selectedIds.contains(node.id)) {
          _selectedIds.remove(node.id);
        } else {
          _selectedIds.add(node.id);
        }
      } else {
        _selectedIds.clear();
        _selectedIds.add(node.id);
      }
    });
    component.onSelect?.call(node);
  }

  String get _iconSize {
    switch (component.size) {
      case USize.xs:
        return 'size-3';
      case USize.sm:
        return 'size-3.5';
      case USize.md:
        return 'size-4';
      case USize.lg:
        return 'size-5';
      case USize.xl:
        return 'size-6';
    }
  }

  String get _textSize {
    switch (component.size) {
      case USize.xs:
        return 'text-xs';
      case USize.sm:
        return 'text-sm';
      case USize.md:
        return 'text-sm';
      case USize.lg:
        return 'text-base';
      case USize.xl:
        return 'text-lg';
    }
  }

  String get _itemPadding {
    switch (component.size) {
      case USize.xs:
        return 'py-0.5 px-1';
      case USize.sm:
        return 'py-1 px-1.5';
      case USize.md:
        return 'py-1.5 px-2';
      case USize.lg:
        return 'py-2 px-2.5';
      case USize.xl:
        return 'py-2.5 px-3';
    }
  }

  String get _selectedColor {
    final baseColor = defaultColorMapping[component.color] ?? 'green';
    return 'bg-$baseColor-50 dark:bg-$baseColor-950 text-$baseColor-700 dark:text-$baseColor-300';
  }

  @override
  Component build(BuildContext context) {
    return ul(
      classes: 'tree-root',
      attributes: {'role': 'tree'},
      [
        for (final node in component.nodes) _buildNode(node, 0),
      ],
    );
  }

  Component _buildNode(UTreeNode node, int depth) {
    final isExpanded = _isExpanded(node.id);
    final isSelected = _isSelected(node.id);
    final hasChildren = node.hasChildren;

    return li(
      classes: 'tree-item',
      attributes: {
        'role': 'treeitem',
        if (hasChildren) 'aria-expanded': '$isExpanded',
        'aria-selected': '$isSelected',
      },
      [
        // Node row
        div(
          classes: cx([
            'flex items-center gap-1 rounded-md cursor-pointer transition-colors',
            _itemPadding,
            if (isSelected) _selectedColor,
            if (!isSelected && !node.disabled)
              'hover:bg-gray-100 dark:hover:bg-gray-800',
            if (node.disabled) 'opacity-50 cursor-not-allowed',
          ]),
          styles: Styles(raw: {'paddingLeft': '${depth * 20 + 4}px'}),
          events: events(onClick: () {
            if (!node.disabled) {
              _selectNode(node);
            }
          }),
          [
            // Expand/collapse button
            if (hasChildren)
              button(
                type: ButtonType.button,
                classes:
                    'shrink-0 p-0.5 rounded hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors',
                events: {'click': (event) {
                  event.stopPropagation();
                  _toggleExpand(node);
                }},
                [
                  i(
                    classes: cx([
                      isExpanded
                          ? component.expandIcon
                          : component.collapseIcon,
                      _iconSize,
                      'text-gray-500 dark:text-gray-400',
                    ]),
                    [],
                  ),
                ],
              )
            else
              // Spacer for alignment
              span(classes: '${_iconSize} shrink-0', []),

            // Checkbox (if enabled)
            if (component.showCheckboxes)
              input(
                type: InputType.checkbox,
                classes: cx([
                  'rounded border-gray-300 dark:border-gray-600 shrink-0',
                  'text-${defaultColorMapping[component.color]}-500',
                  'focus:ring-${defaultColorMapping[component.color]}-500',
                ]),
                attributes: {
                  if (isSelected) 'checked': 'true',
                  if (node.disabled) 'disabled': 'true',
                },
                events: {'click': (event) {
                  event.stopPropagation();
                  _selectNode(node);
                }},
              ),

            // Icon
            i(
              classes: cx([
                node.icon ??
                    (hasChildren
                        ? (isExpanded
                            ? component.folderIcon
                            : component.folderCollapsedIcon)
                        : component.leafIcon),
                _iconSize,
                'shrink-0',
                if (isSelected)
                  'text-${defaultColorMapping[component.color]}-600 dark:text-${defaultColorMapping[component.color]}-400'
                else
                  'text-gray-500 dark:text-gray-400',
              ]),
              [],
            ),

            // Label
            span(
              classes: cx([
                _textSize,
                'truncate',
                if (isSelected) 'font-medium',
              ]),
              [Component.text(node.label)],
            ),
          ],
        ),

        // Children (if expanded)
        if (hasChildren && isExpanded)
          ul(
            classes: cx([
              'tree-children',
              if (component.showLines)
                'ml-3 border-l border-gray-200 dark:border-gray-700',
            ]),
            attributes: {'role': 'group'},
            [
              for (final child in node.children) _buildNode(child, depth + 1),
            ],
          ),
      ],
    );
  }
}

/// Simple tree for file browser use case
class UFileTree extends StatelessComponent {
  /// Root nodes
  final List<UTreeNode> nodes;

  /// Callback when a file is selected
  final void Function(UTreeNode node)? onSelect;

  /// Currently selected file ID
  final String? selectedId;

  const UFileTree({
    super.key,
    required this.nodes,
    this.onSelect,
    this.selectedId,
  });

  @override
  Component build(BuildContext context) {
    return UTree(
      nodes: nodes,
      onSelect: onSelect,
      folderIcon: 'i-lucide-folder-open',
      folderCollapsedIcon: 'i-lucide-folder',
      leafIcon: 'i-lucide-file-text',
      showLines: true,
      color: UColor.primary,
    );
  }
}
