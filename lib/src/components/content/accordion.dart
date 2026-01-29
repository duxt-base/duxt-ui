import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// Accordion item configuration
class UAccordionItem {
  final String label;
  final String? description;
  final Component? icon;
  final bool disabled;
  final Component content;
  final String? value;

  const UAccordionItem({
    required this.label,
    required this.content,
    this.description,
    this.icon,
    this.disabled = false,
    this.value,
  });
}

/// Accordion variants
enum UAccordionVariant { soft, ghost }

/// DuxtUI Accordion component - Collapsible panels
class UAccordion extends StatefulComponent {
  final List<UAccordionItem> items;
  final String? defaultValue;
  final bool multiple;
  final UColor color;
  final UAccordionVariant variant;
  final USize size;
  final ValueChanged<List<String>>? onValueChange;

  const UAccordion({
    super.key,
    required this.items,
    this.defaultValue,
    this.multiple = false,
    this.color = UColor.primary,
    this.variant = UAccordionVariant.soft,
    this.size = USize.md,
    this.onValueChange,
  });

  @override
  State<UAccordion> createState() => _UAccordionState();
}

class _UAccordionState extends State<UAccordion> {
  late Set<String> _openItems;

  @override
  void initState() {
    super.initState();
    _openItems = {};
    if (component.defaultValue != null) {
      _openItems.add(component.defaultValue!);
    }
  }

  void _toggle(String value) {
    setState(() {
      if (_openItems.contains(value)) {
        _openItems.remove(value);
      } else {
        if (!component.multiple) {
          _openItems.clear();
        }
        _openItems.add(value);
      }
      component.onValueChange?.call(_openItems.toList());
    });
  }

  String _getItemValue(UAccordionItem item, int index) {
    return item.value ?? 'item-$index';
  }

  String get _sizeClasses {
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

  String get _paddingClasses {
    switch (component.size) {
      case USize.xs:
        return 'px-2.5 py-1.5';
      case USize.sm:
        return 'px-3 py-2';
      case USize.md:
        return 'px-4 py-3';
      case USize.lg:
        return 'px-4 py-3.5';
      case USize.xl:
        return 'px-5 py-4';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: cx([
        'divide-y',
        UDivideColors.defaultDivide,
        'rounded-lg',
        'ring-1',
        URingColors.defaultRing,
      ]),
      [
        for (int i = 0; i < component.items.length; i++)
          _buildItem(component.items[i], i),
      ],
    );
  }

  Component _buildItem(UAccordionItem item, int index) {
    final value = _getItemValue(item, index);
    final isOpen = _openItems.contains(value);
    final isFirst = index == 0;
    final isLast = index == component.items.length - 1;

    return div(
      classes: cx([
        isFirst ? 'rounded-t-lg' : null,
        isLast ? 'rounded-b-lg' : null,
      ]),
      [
        // Header button
        button(
          type: ButtonType.button,
          disabled: item.disabled,
          onClick: item.disabled ? null : () => _toggle(value),
          classes: cx([
            'w-full flex items-center justify-between',
            _paddingClasses,
            _sizeClasses,
            'font-medium',
            UTextColors.highlighted,
            'hover:bg-gray-50 dark:hover:bg-gray-800/50',
            'transition-colors',
            item.disabled ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer',
            isFirst ? 'rounded-t-lg' : null,
            isLast && !isOpen ? 'rounded-b-lg' : null,
          ]),
          [
            div(classes: 'flex items-center gap-2', [
              if (item.icon != null) item.icon!,
              div([
                span([Component.text(item.label)]),
                if (item.description != null)
                  p(
                      classes: cx(
                          ['font-normal', UTextColors.muted, 'text-xs mt-0.5']),
                      [
                        Component.text(item.description!),
                      ]),
              ]),
            ]),
            // Chevron icon
            span(
              classes: cx([
                'transform transition-transform duration-200',
                isOpen ? 'rotate-180' : null,
              ]),
              [Component.text('\u25BC')], // Down arrow
            ),
          ],
        ),
        // Content
        if (isOpen)
          div(
            classes: cx([
              _paddingClasses,
              'pt-0',
              UTextColors.defaultText,
              _sizeClasses,
              isLast ? 'rounded-b-lg' : null,
            ]),
            [item.content],
          ),
      ],
    );
  }
}
