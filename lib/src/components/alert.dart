import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Alert colors
enum UAlertColor { info, success, warning, error }

/// DuxtUI Alert component
class UAlert extends StatelessComponent {
  final String? title;
  final String? description;
  final UAlertColor color;
  final Component? icon;
  final VoidCallback? onClose;
  final List<Component> children;

  const UAlert({
    super.key,
    this.title,
    this.description,
    this.color = UAlertColor.info,
    this.icon,
    this.onClose,
    this.children = const [],
  });

  String get _colorClasses {
    switch (color) {
      case UAlertColor.info:
        return 'bg-blue-50 border-blue-200 text-blue-800';
      case UAlertColor.success:
        return 'bg-green-50 border-green-200 text-green-800';
      case UAlertColor.warning:
        return 'bg-yellow-50 border-yellow-200 text-yellow-800';
      case UAlertColor.error:
        return 'bg-red-50 border-red-200 text-red-800';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'p-4 rounded-lg border $_colorClasses',
      [
        div(classes: 'flex', [
          if (icon != null)
            div(classes: 'flex-shrink-0 mr-3', [icon!]),
          div(classes: 'flex-1', [
            if (title != null)
              h3(classes: 'text-sm font-medium', [text(title!)]),
            if (description != null)
              p(classes: 'text-sm mt-1 opacity-90', [text(description!)]),
            ...children,
          ]),
          if (onClose != null)
            button(
              type: ButtonType.button,
              onClick: onClose,
              classes: 'ml-3 -mr-1 -mt-1 p-1 rounded hover:bg-black/5',
              [span(classes: 'text-lg', [text('×')])],
            ),
        ]),
      ],
    );
  }
}
