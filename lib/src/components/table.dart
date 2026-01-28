import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Table column definition
class UTableColumn<T> {
  final String key;
  final String label;
  final Component Function(T item)? render;
  final String? classes;

  const UTableColumn({
    required this.key,
    required this.label,
    this.render,
    this.classes,
  });
}

/// DuxtUI Table component
class UTable<T> extends StatelessComponent {
  final List<UTableColumn<T>> columns;
  final List<T> data;
  final String Function(T item)? rowKey;
  final bool striped;
  final bool hoverable;
  final bool bordered;
  final Component? emptyState;

  const UTable({
    super.key,
    required this.columns,
    required this.data,
    this.rowKey,
    this.striped = false,
    this.hoverable = true,
    this.bordered = false,
    this.emptyState,
  });

  @override
  Component build(BuildContext context) {
    return div(classes: 'overflow-x-auto', [
      table(
        classes: 'min-w-full divide-y divide-gray-200 ${bordered ? "border border-gray-200" : ""}',
        [
          // Header
          thead(classes: 'bg-gray-50', [
            tr([
              for (final col in columns)
                th(
                  classes: 'px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider ${col.classes ?? ""}',
                  [text(col.label)],
                ),
            ]),
          ]),
          // Body
          tbody(
            classes: 'bg-white divide-y divide-gray-200',
            data.isEmpty && emptyState != null
                ? [
                    tr([
                      td(
                        attributes: {'colspan': columns.length.toString()},
                        classes: 'px-4 py-8 text-center',
                        [emptyState!],
                      ),
                    ]),
                  ]
                : [
                    for (var i = 0; i < data.length; i++)
                      tr(
                        classes: '${striped && i.isOdd ? "bg-gray-50" : ""} ${hoverable ? "hover:bg-gray-50" : ""}',
                        [
                          for (final col in columns)
                            td(
                              classes: 'px-4 py-3 text-sm text-gray-900 ${col.classes ?? ""}',
                              [
                                if (col.render != null)
                                  col.render!(data[i])
                                else
                                  text(_getValue(data[i], col.key)),
                              ],
                            ),
                        ],
                      ),
                  ],
          ),
        ],
      ),
    ]);
  }

  String _getValue(T item, String key) {
    if (item is Map) {
      return item[key]?.toString() ?? '';
    }
    return '';
  }
}
