import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Container max-width variants
enum UContainerSize { xs, sm, md, lg, xl, xxl, full }

/// DuxtUI Container component - max-width wrapper with responsive padding
class UContainer extends StatelessComponent {
  final List<Component> children;
  final UContainerSize size;
  final bool padded;
  final String? classes;

  const UContainer({
    super.key,
    this.children = const [],
    this.size = UContainerSize.xl,
    this.padded = true,
    this.classes,
  });

  String get _maxWidthClasses {
    switch (size) {
      case UContainerSize.xs:
        return 'max-w-xs';
      case UContainerSize.sm:
        return 'max-w-sm';
      case UContainerSize.md:
        return 'max-w-md';
      case UContainerSize.lg:
        return 'max-w-4xl';
      case UContainerSize.xl:
        return 'max-w-6xl';
      case UContainerSize.xxl:
        return 'max-w-7xl';
      case UContainerSize.full:
        return 'max-w-full';
    }
  }

  String get _paddingClasses {
    return padded ? 'px-4 sm:px-6 lg:px-8' : '';
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'mx-auto $_maxWidthClasses $_paddingClasses ${classes ?? ""}'.trim(),
      children,
    );
  }
}
