import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// DuxtUI Collapsible component using native HTML details/summary
///
/// Uses native `<details>` and `<summary>` elements for accessibility
/// and interactivity without JavaScript.
class DCollapsible extends StatelessComponent {
  final Component trigger;
  final List<Component> children;
  final bool defaultOpen;
  final bool disabled;

  const DCollapsible({
    super.key,
    required this.trigger,
    required this.children,
    this.defaultOpen = false,
    this.disabled = false,
  });

  @override
  Component build(BuildContext context) {
    return details(
      classes: cx([
        'w-full group',
        disabled ? 'pointer-events-none opacity-50' : null,
      ]),
      attributes: {
        if (defaultOpen) 'open': 'true',
      },
      [
        // Trigger wrapped in summary
        summary(
          classes: cx([
            'list-none',
            '[&::-webkit-details-marker]:hidden',
            disabled ? 'cursor-not-allowed' : 'cursor-pointer',
          ]),
          [trigger],
        ),
        // Content
        div(
          classes: 'overflow-hidden',
          children,
        ),
      ],
    );
  }
}

/// Collapsible trigger helper component with chevron
///
/// Use inside DCollapsible's trigger parameter. The chevron automatically
/// rotates when the parent details element is open via CSS group-open.
class DCollapsibleTrigger extends StatelessComponent {
  final String label;
  final Component? icon;

  const DCollapsibleTrigger({
    super.key,
    required this.label,
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
            'group-open:rotate-180', // Rotates when details is open
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
