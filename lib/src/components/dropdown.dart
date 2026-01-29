import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Dropdown item
class UDropdownItem {
  final String label;
  final String? icon;
  final bool disabled;
  final bool divider;
  final VoidCallback? onClick;

  const UDropdownItem({
    required this.label,
    this.icon,
    this.disabled = false,
    this.divider = false,
    this.onClick,
  });

  const UDropdownItem.divider()
      : label = '',
        icon = null,
        disabled = false,
        divider = true,
        onClick = null;
}

/// DuxtUI Dropdown component
class UDropdown extends StatefulComponent {
  final Component trigger;
  final List<UDropdownItem> items;

  const UDropdown({
    super.key,
    required this.trigger,
    required this.items,
  });

  @override
  State<UDropdown> createState() => _UDropdownState();
}

class _UDropdownState extends State<UDropdown> {
  bool _open = false;

  void _toggle() {
    setState(() => _open = !_open);
  }

  void _close() {
    setState(() => _open = false);
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'relative inline-block', [
      // Trigger
      div(
        events: {'click': (_) => _toggle()},
        [component.trigger],
      ),
      // Menu
      if (_open)
        div(
          classes:
              'absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-gray-200 py-1 z-50',
          [
            for (final item in component.items)
              if (item.divider)
                div(classes: 'border-t border-gray-100 my-1', [])
              else
                button(
                  type: ButtonType.button,
                  disabled: item.disabled,
                  onClick: item.disabled
                      ? null
                      : () {
                          _close();
                          item.onClick?.call();
                        },
                  classes:
                      'w-full px-4 py-2 text-left text-sm ${item.disabled ? "text-gray-400 cursor-not-allowed" : "text-gray-700 hover:bg-gray-100"}',
                  [Component.text(item.label)],
                ),
          ],
        ),
    ]);
  }
}
