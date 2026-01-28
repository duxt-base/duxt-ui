import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Tab item
class UTabItem {
  final String label;
  final String value;
  final Component? icon;
  final bool disabled;

  const UTabItem({
    required this.label,
    required this.value,
    this.icon,
    this.disabled = false,
  });
}

/// DuxtUI Tabs component
class UTabs extends StatelessComponent {
  final List<UTabItem> items;
  final String? selected;
  final ValueChanged<String>? onSelect;

  const UTabs({
    super.key,
    required this.items,
    this.selected,
    this.onSelect,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'border-b border-gray-200',
      [
        nav(classes: 'flex gap-4', [
          for (final item in items)
            button(
              type: ButtonType.button,
              disabled: item.disabled,
              onClick: item.disabled ? null : () => onSelect?.call(item.value),
              classes: 'px-1 py-3 text-sm font-medium border-b-2 -mb-px transition-colors ${item.value == selected ? "border-indigo-600 text-indigo-600" : "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300"} ${item.disabled ? "opacity-50 cursor-not-allowed" : ""}',
              [
                if (item.icon != null) item.icon!,
                text(item.label),
              ],
            ),
        ]),
      ],
    );
  }
}
