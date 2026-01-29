import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// DuxtUI Collapsible component - Single collapse panel
class UCollapsible extends StatefulComponent {
  final Component trigger;
  final List<Component> children;
  final bool defaultOpen;
  final bool disabled;
  final VoidCallback? onOpenChange;

  const UCollapsible({
    super.key,
    required this.trigger,
    required this.children,
    this.defaultOpen = false,
    this.disabled = false,
    this.onOpenChange,
  });

  @override
  State<UCollapsible> createState() => _UCollapsibleState();
}

class _UCollapsibleState extends State<UCollapsible> {
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
class UCollapsibleTrigger extends StatelessComponent {
  final String label;
  final bool open;
  final Component? icon;

  const UCollapsibleTrigger({
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
        UTextColors.highlighted,
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
class UCollapsibleContent extends StatelessComponent {
  final List<Component> children;

  const UCollapsibleContent({
    super.key,
    required this.children,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: cx([
        'px-4 py-3',
        UTextColors.defaultText,
      ]),
      children,
    );
  }
}
