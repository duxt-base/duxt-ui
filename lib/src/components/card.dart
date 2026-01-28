import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI Card component
class UCard extends StatelessComponent {
  final Component? header;
  final Component? footer;
  final List<Component> children;
  final String? classes;
  final bool noPadding;

  const UCard({
    super.key,
    this.header,
    this.footer,
    this.children = const [],
    this.classes,
    this.noPadding = false,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'bg-white rounded-lg border border-gray-200 shadow-sm ${classes ?? ""}',
      [
        if (header != null)
          div(classes: 'px-4 py-3 border-b border-gray-200', [header!]),
        div(classes: noPadding ? '' : 'p-4', children),
        if (footer != null)
          div(classes: 'px-4 py-3 border-t border-gray-100 bg-gray-50 rounded-b-lg', [footer!]),
      ],
    );
  }
}

/// DuxtUI Card Header
class UCardHeader extends StatelessComponent {
  final String? title;
  final String? description;
  final Component? trailing;
  final List<Component> children;

  const UCardHeader({
    super.key,
    this.title,
    this.description,
    this.trailing,
    this.children = const [],
  });

  @override
  Component build(BuildContext context) {
    return div(classes: 'flex items-start justify-between', [
      div([
        if (title != null)
          h3(classes: 'text-lg font-semibold text-gray-900', [text(title!)]),
        if (description != null)
          p(classes: 'text-sm text-gray-500 mt-1', [text(description!)]),
        ...children,
      ]),
      if (trailing != null) trailing!,
    ]);
  }
}
