import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Context menu item
class UContextMenuItem {
  final String label;
  final String? icon;
  final String? shortcut;
  final bool disabled;
  final bool divider;
  final VoidCallback? onClick;
  final List<UContextMenuItem>? submenu;

  const UContextMenuItem({
    required this.label,
    this.icon,
    this.shortcut,
    this.disabled = false,
    this.divider = false,
    this.onClick,
    this.submenu,
  });

  const UContextMenuItem.divider()
      : label = '',
        icon = null,
        shortcut = null,
        disabled = false,
        divider = true,
        onClick = null,
        submenu = null;
}

/// DuxtUI Context Menu component - right-click menu
class UContextMenu extends StatefulComponent {
  final Component child;
  final List<UContextMenuItem> items;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

  const UContextMenu({
    super.key,
    required this.child,
    required this.items,
    this.onOpen,
    this.onClose,
  });

  @override
  State<UContextMenu> createState() => _UContextMenuState();
}

class _UContextMenuState extends State<UContextMenu> {
  bool _open = false;
  double _x = 0;
  double _y = 0;

  void _handleContextMenu(dynamic event) {
    // Prevent default browser context menu
    // Note: In Jaspr web, we would handle event.preventDefault() differently
    // For now, this is a placeholder

    setState(() {
      _open = true;
      // Get mouse position from event
      // Note: In Jaspr, we need to handle this differently
      // For now, we position relative to the element
      _x = 0;
      _y = 0;
      component.onOpen?.call();
    });
  }

  void _close() {
    if (_open) {
      setState(() {
        _open = false;
        component.onClose?.call();
      });
    }
  }

  void _handleItemClick(UContextMenuItem item) {
    if (!item.disabled && item.onClick != null) {
      _close();
      item.onClick!();
    }
  }

  Component _buildMenuItem(UContextMenuItem item) {
    if (item.divider) {
      return div(
        classes: 'border-t border-gray-200 dark:border-gray-700 my-1',
        [],
      );
    }

    final hasSubmenu = item.submenu != null && item.submenu!.isNotEmpty;

    return div(
      classes: 'relative group',
      [
        button(
          type: ButtonType.button,
          disabled: item.disabled,
          onClick:
              item.disabled || hasSubmenu ? null : () => _handleItemClick(item),
          classes:
              'w-full flex items-center justify-between px-3 py-2 text-sm ${item.disabled ? "text-gray-400 dark:text-gray-600 cursor-not-allowed" : "text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800"}',
          [
            div(
              classes: 'flex items-center gap-2',
              [
                if (item.icon != null)
                  span(classes: 'w-4 h-4', [Component.text(item.icon!)]),
                span([Component.text(item.label)]),
              ],
            ),
            if (item.shortcut != null)
              span(
                classes: 'ml-4 text-xs text-gray-400 dark:text-gray-500',
                [Component.text(item.shortcut!)],
              ),
            if (hasSubmenu)
              span(
                classes: 'ml-2 text-gray-400',
                [Component.text('\u203A')], // Right arrow
              ),
          ],
        ),
        // Submenu
        if (hasSubmenu)
          div(
            classes:
                'absolute left-full top-0 ml-1 hidden group-hover:block min-w-48 bg-white dark:bg-gray-900 rounded-lg shadow-lg ring-1 ring-gray-200 dark:ring-gray-800 py-1',
            [
              for (final subItem in item.submenu!) _buildMenuItem(subItem),
            ],
          ),
      ],
    );
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'relative inline-block',
      [
        // Child with context menu event
        div(
          events: {'contextmenu': _handleContextMenu},
          [component.child],
        ),
        // Context menu overlay
        if (_open) ...[
          // Invisible overlay to catch clicks outside
          div(
            classes: 'fixed inset-0 z-40',
            events: {'click': (_) => _close(), 'contextmenu': (_) => _close()},
            [],
          ),
          // Context menu
          div(
            classes:
                'absolute z-50 min-w-48 bg-white dark:bg-gray-900 rounded-lg shadow-lg ring-1 ring-gray-200 dark:ring-gray-800 py-1',
            styles: Styles(raw: {'left': '${_x}px', 'top': '${_y}px'}),
            [
              for (final item in component.items) _buildMenuItem(item),
            ],
          ),
        ],
      ],
    );
  }
}

/// Controlled context menu that can be triggered programmatically
class UContextMenuControlled extends StatelessComponent {
  final bool open;
  final double x;
  final double y;
  final List<UContextMenuItem> items;
  final VoidCallback? onClose;

  const UContextMenuControlled({
    super.key,
    required this.open,
    required this.x,
    required this.y,
    required this.items,
    this.onClose,
  });

  Component _buildMenuItem(UContextMenuItem item, VoidCallback close) {
    if (item.divider) {
      return div(
        classes: 'border-t border-gray-200 dark:border-gray-700 my-1',
        [],
      );
    }

    return button(
      type: ButtonType.button,
      disabled: item.disabled,
      onClick: item.disabled
          ? null
          : () {
              close();
              item.onClick?.call();
            },
      classes:
          'w-full flex items-center justify-between px-3 py-2 text-sm ${item.disabled ? "text-gray-400 dark:text-gray-600 cursor-not-allowed" : "text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800"}',
      [
        div(
          classes: 'flex items-center gap-2',
          [
            if (item.icon != null)
              span(classes: 'w-4 h-4', [Component.text(item.icon!)]),
            span([Component.text(item.label)]),
          ],
        ),
        if (item.shortcut != null)
          span(
            classes: 'ml-4 text-xs text-gray-400 dark:text-gray-500',
            [Component.text(item.shortcut!)],
          ),
      ],
    );
  }

  @override
  Component build(BuildContext context) {
    if (!open) return div([]);

    return div(
      [
        // Invisible overlay to catch clicks outside
        div(
          classes: 'fixed inset-0 z-40',
          events: onClose != null
              ? {'click': (_) => onClose!(), 'contextmenu': (_) => onClose!()}
              : {},
          [],
        ),
        // Context menu
        div(
          classes:
              'fixed z-50 min-w-48 bg-white dark:bg-gray-900 rounded-lg shadow-lg ring-1 ring-gray-200 dark:ring-gray-800 py-1',
          styles: Styles(raw: {'left': '${x}px', 'top': '${y}px'}),
          [
            for (final item in items)
              _buildMenuItem(item, () => onClose?.call()),
          ],
        ),
      ],
    );
  }
}
