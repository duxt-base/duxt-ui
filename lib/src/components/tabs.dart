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

/// DuxtUI Tabs component with native JS interactivity
///
/// Uses browser-native JavaScript for tab switching without requiring @client.
/// Tab content is shown/hidden using CSS classes.
class DTabs extends StatelessComponent {
  final List<DTabItem> items;
  final String? defaultValue;
  final DTabsOrientation orientation;

  const DTabs({
    super.key,
    required this.items,
    this.defaultValue,
    this.orientation = DTabsOrientation.horizontal,
  });

  String get _tabsId => 'tabs_$hashCode';

  @override
  Component build(BuildContext context) {
    final isVertical = orientation == DTabsOrientation.vertical;
    final initialValue =
        defaultValue ?? (items.isNotEmpty ? items.first.value : '');

    // Generate JS for tab switching
    final tabScript = '''
      (function() {
        var tabsEl = document.getElementById('$_tabsId');
        if (!tabsEl) return;
        tabsEl.querySelectorAll('[data-tab-trigger]').forEach(function(btn) {
          btn.addEventListener('click', function() {
            var value = this.getAttribute('data-tab-trigger');
            // Update button states
            tabsEl.querySelectorAll('[data-tab-trigger]').forEach(function(b) {
              b.classList.remove('tab-active');
              b.setAttribute('aria-selected', 'false');
            });
            this.classList.add('tab-active');
            this.setAttribute('aria-selected', 'true');
            // Update panel visibility
            tabsEl.querySelectorAll('[data-tab-panel]').forEach(function(p) {
              if (p.getAttribute('data-tab-panel') === value) {
                p.classList.remove('hidden');
              } else {
                p.classList.add('hidden');
              }
            });
          });
        });
      })();
    ''';

    if (isVertical) {
      return div(id: _tabsId, classes: 'flex gap-4', [
        // Tab list (vertical)
        div(
          classes: 'flex flex-col gap-1',
          attributes: {'role': 'tablist', 'aria-orientation': 'vertical'},
          [
            for (final item in items) _buildTab(item, isVertical, initialValue),
          ],
        ),
        // Tab panels
        div(classes: 'flex-1', [
          for (final item in items) _buildPanel(item, initialValue),
        ]),
        // Inline script for interactivity
        RawText('<script>$tabScript</script>'),
      ]);
    }

    return div(id: _tabsId, [
      // Tab list (horizontal)
      div(
        classes: 'flex border-b border-gray-200 dark:border-gray-800 gap-1',
        attributes: {'role': 'tablist'},
        [
          for (final item in items) _buildTab(item, isVertical, initialValue),
        ],
      ),
      // Tab panels
      div(classes: 'mt-4', [
        for (final item in items) _buildPanel(item, initialValue),
      ]),
      // Inline script for interactivity
      RawText('<script>$tabScript</script>'),
    ]);
  }

  Component _buildTab(DTabItem item, bool isVertical, String activeValue) {
    final isActive = item.value == activeValue;

    final baseClasses =
        'flex items-center gap-1.5 px-3 py-2 text-sm font-medium transition-colors focus:outline-none focus-visible:ring-2 focus-visible:ring-cyan-500 focus-visible:ring-offset-2';

    final activeClasses = isVertical
        ? 'bg-gray-100 text-gray-900 dark:bg-zinc-800 dark:text-white rounded-md'
        : 'border-b-2 border-cyan-500 text-cyan-600 dark:text-cyan-400 -mb-px';

    final inactiveClasses = isVertical
        ? 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 rounded-md hover:bg-gray-50 dark:hover:bg-gray-800/50'
        : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 border-b-2 border-transparent hover:border-gray-300 dark:hover:border-gray-700 -mb-px';

    final disabledClasses =
        item.disabled ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer';

    return button(
      type: ButtonType.button,
      disabled: item.disabled,
      classes:
          '$baseClasses ${isActive ? activeClasses : inactiveClasses} $disabledClasses ${isActive ? "tab-active" : ""}',
      attributes: {
        'role': 'tab',
        'data-tab-trigger': item.value,
        'aria-selected': isActive.toString(),
        'aria-controls': 'panel_${item.value}',
      },
      [
        if (item.icon != null) span(classes: 'size-4', [item.icon!]),
        Component.text(item.label),
      ],
    );
  }

  Component _buildPanel(DTabItem item, String activeValue) {
    final isActive = item.value == activeValue;

    return div(
      id: 'panel_${item.value}',
      classes: isActive ? '' : 'hidden',
      attributes: {
        'role': 'tabpanel',
        'data-tab-panel': item.value,
        'aria-labelledby': item.value,
      },
      [if (item.content != null) item.content!],
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
        'flex items-center gap-1.5 px-3 py-2 text-sm font-medium transition-colors focus:outline-none focus-visible:ring-2 focus-visible:ring-cyan-500 focus-visible:ring-offset-2';

    final activeClasses = isVertical
        ? 'bg-gray-100 text-gray-900 dark:bg-zinc-800 dark:text-white rounded-md'
        : 'border-b-2 border-cyan-500 text-cyan-600 dark:text-cyan-400 -mb-px';

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
