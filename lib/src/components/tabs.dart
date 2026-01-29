import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Tab orientation
enum DTabsOrientation { horizontal, vertical }

/// Tab item data
class DTabItem {
  final String label;
  final String value;
  final Component? icon;
  final Component? content;
  final bool disabled;

  const DTabItem({
    required this.label,
    required this.value,
    this.icon,
    this.content,
    this.disabled = false,
  });
}

/// DuxtUI Tabs component - Nuxt UI compatible
///
/// A stateful component that manages tab selection internally.
/// Use [defaultValue] to set the initial selected tab.
/// Use [onSelect] callback to respond to tab changes.
class DTabs extends StatefulComponent {
  final List<DTabItem> items;
  final String? defaultValue;
  final DTabsOrientation orientation;
  final bool unmountOnHide;
  final ValueChanged<String>? onSelect;

  const DTabs({
    super.key,
    required this.items,
    this.defaultValue,
    this.orientation = DTabsOrientation.horizontal,
    this.unmountOnHide = true,
    this.onSelect,
  });

  @override
  State<DTabs> createState() => _UTabsState();
}

class _UTabsState extends State<DTabs> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = component.defaultValue ??
        (component.items.isNotEmpty ? component.items.first.value : '');
  }

  void _handleSelect(String value) {
    setState(() {
      _selected = value;
    });
    component.onSelect?.call(value);
  }

  @override
  Component build(BuildContext context) {
    final isVertical = component.orientation == DTabsOrientation.vertical;

    if (isVertical) {
      return div(classes: 'flex gap-4', [
        // Tab list (vertical)
        div(
          classes: 'flex flex-col gap-1',
          [
            for (final item in component.items) _buildTab(item, isVertical),
          ],
        ),
        // Tab panels
        div(classes: 'flex-1', [
          for (final item in component.items)
            if (!component.unmountOnHide || item.value == _selected)
              div(
                classes: item.value == _selected ? '' : 'hidden',
                [if (item.content != null) item.content!],
              ),
        ]),
      ]);
    }

    return div([
      // Tab list (horizontal)
      div(
        classes: 'flex border-b border-gray-200 dark:border-gray-800 gap-1',
        [
          for (final item in component.items) _buildTab(item, isVertical),
        ],
      ),
      // Tab panels
      div(classes: 'mt-4', [
        for (final item in component.items)
          if (!component.unmountOnHide || item.value == _selected)
            div(
              classes: item.value == _selected ? '' : 'hidden',
              [if (item.content != null) item.content!],
            ),
      ]),
    ]);
  }

  Component _buildTab(DTabItem item, bool isVertical) {
    final isActive = item.value == _selected;

    final baseClasses =
        'flex items-center gap-1.5 px-3 py-2 text-sm font-medium transition-colors focus:outline-none focus-visible:ring-2 focus-visible:ring-green-500 focus-visible:ring-offset-2';

    final activeClasses = isVertical
        ? 'bg-gray-100 text-gray-900 dark:bg-gray-800 dark:text-white rounded-md'
        : 'border-b-2 border-green-500 text-green-600 dark:text-green-400 -mb-px';

    final inactiveClasses = isVertical
        ? 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 rounded-md hover:bg-gray-50 dark:hover:bg-gray-800/50'
        : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 border-b-2 border-transparent hover:border-gray-300 dark:hover:border-gray-700 -mb-px';

    final stateClasses = isActive ? activeClasses : inactiveClasses;
    final disabledClasses =
        item.disabled ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer';

    return button(
      type: ButtonType.button,
      disabled: item.disabled,
      onClick: item.disabled ? null : () => _handleSelect(item.value),
      classes: '$baseClasses $stateClasses $disabledClasses',
      [
        if (item.icon != null) span(classes: 'size-4', [item.icon!]),
        Component.text(item.label),
      ],
    );
  }
}

/// Controlled tabs variant that allows external state management
class DControlledTabs extends StatelessComponent {
  final List<DTabItem> items;
  final String selected;
  final DTabsOrientation orientation;
  final bool unmountOnHide;
  final ValueChanged<String>? onSelect;

  const DControlledTabs({
    super.key,
    required this.items,
    required this.selected,
    this.orientation = DTabsOrientation.horizontal,
    this.unmountOnHide = true,
    this.onSelect,
  });

  @override
  Component build(BuildContext context) {
    final isVertical = orientation == DTabsOrientation.vertical;

    if (isVertical) {
      return div(classes: 'flex gap-4', [
        div(
          classes: 'flex flex-col gap-1',
          [
            for (final item in items) _buildTab(item, isVertical),
          ],
        ),
        div(classes: 'flex-1', [
          for (final item in items)
            if (!unmountOnHide || item.value == selected)
              div(
                classes: item.value == selected ? '' : 'hidden',
                [if (item.content != null) item.content!],
              ),
        ]),
      ]);
    }

    return div([
      div(
        classes: 'flex border-b border-gray-200 dark:border-gray-800 gap-1',
        [
          for (final item in items) _buildTab(item, isVertical),
        ],
      ),
      div(classes: 'mt-4', [
        for (final item in items)
          if (!unmountOnHide || item.value == selected)
            div(
              classes: item.value == selected ? '' : 'hidden',
              [if (item.content != null) item.content!],
            ),
      ]),
    ]);
  }

  Component _buildTab(DTabItem item, bool isVertical) {
    final isActive = item.value == selected;

    final baseClasses =
        'flex items-center gap-1.5 px-3 py-2 text-sm font-medium transition-colors focus:outline-none focus-visible:ring-2 focus-visible:ring-green-500 focus-visible:ring-offset-2';

    final activeClasses = isVertical
        ? 'bg-gray-100 text-gray-900 dark:bg-gray-800 dark:text-white rounded-md'
        : 'border-b-2 border-green-500 text-green-600 dark:text-green-400 -mb-px';

    final inactiveClasses = isVertical
        ? 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 rounded-md hover:bg-gray-50 dark:hover:bg-gray-800/50'
        : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 border-b-2 border-transparent hover:border-gray-300 dark:hover:border-gray-700 -mb-px';

    final stateClasses = isActive ? activeClasses : inactiveClasses;
    final disabledClasses =
        item.disabled ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer';

    return button(
      type: ButtonType.button,
      disabled: item.disabled,
      onClick: item.disabled ? null : () => onSelect?.call(item.value),
      classes: '$baseClasses $stateClasses $disabledClasses',
      [
        if (item.icon != null) span(classes: 'size-4', [item.icon!]),
        Component.text(item.label),
      ],
    );
  }
}
