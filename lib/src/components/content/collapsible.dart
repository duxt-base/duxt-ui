import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// DuxtUI Collapsible component - Single collapse panel
class DCollapsible extends StatefulComponent {
  final Component trigger;
  final List<Component> children;
  final bool defaultOpen;
  final bool disabled;
  final VoidCallback? onOpenChange;

  const DCollapsible({
    super.key,
    required this.trigger,
    required this.children,
    this.defaultOpen = false,
    this.disabled = false,
    this.onOpenChange,
  });

  @override
  State<DCollapsible> createState() => _UCollapsibleState();
}

class _UCollapsibleState extends State<DCollapsible> {
  late bool _open;

  @override
  void initState() {
    super.initState();
    _open = component.defaultOpen;
  }

  void _toggle() {
    if (component.disabled) return;
    setState(() {
      _open = !_open;
    });
    component.onOpenChange?.call();
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'w-full',
      [
        // Trigger
        div(
          events: component.disabled ? {} : {'click': (_) => _toggle()},
          classes: cx([
            component.disabled
                ? 'opacity-50 cursor-not-allowed'
                : 'cursor-pointer',
          ]),
          [component.trigger],
        ),
        // Content
        if (_open)
          div(
            classes: 'overflow-hidden',
            component.children,
          ),
      ],
    );
  }
}

/// Collapsible trigger helper component with chevron
class DCollapsibleTrigger extends StatelessComponent {
  final String label;
  final bool open;
  final Component? icon;

  const DCollapsibleTrigger({
    super.key,
    required this.label,
    this.open = false,
    this.icon,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: cx([
        'flex items-center justify-between',
        'px-4 py-3',
        'font-medium',
        DTextColors.highlighted,
        'hover:bg-gray-50 dark:hover:bg-gray-800/50',
        'transition-colors',
        'rounded-lg',
        'select-none',
      ]),
      [
        div(classes: 'flex items-center gap-2', [
          if (icon != null) icon!,
          span([Component.text(label)]),
        ]),
        span(
          classes: cx([
            'transform transition-transform duration-200',
            open ? 'rotate-180' : null,
          ]),
          [Component.text('\u25BC')],
        ),
      ],
    );
  }
}

/// Collapsible content wrapper with padding
class DCollapsibleContent extends StatelessComponent {
  final List<Component> children;

  const DCollapsibleContent({
    super.key,
    required this.children,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: cx([
        'px-4 py-3',
        DTextColors.defaultText,
      ]),
      children,
    );
  }
}
