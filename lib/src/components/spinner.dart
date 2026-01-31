import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Spinner sizes
enum DSpinnerSize { xs, sm, md, lg }

/// DuxtUI Spinner component
class DSpinner extends StatelessComponent {
  final DSpinnerSize size;
  final String? color;

  const DSpinner({
    super.key,
    this.size = DSpinnerSize.md,
    this.color,
  });

  String get _sizeClasses {
    switch (size) {
      case DSpinnerSize.xs:
        return 'h-3 w-3 border';
      case DSpinnerSize.sm:
        return 'h-4 w-4 border-2';
      case DSpinnerSize.md:
        return 'h-6 w-6 border-2';
      case DSpinnerSize.lg:
        return 'h-8 w-8 border-2';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'animate-spin $_sizeClasses ${color ?? "border-cyan-600"} border-t-transparent rounded-full',
      [],
    );
  }
}

/// DuxtUI Loading overlay
class DLoading extends StatelessComponent {
  final String? message;
  final bool overlay;

  const DLoading({
    super.key,
    this.message,
    this.overlay = false,
  });

  @override
  Component build(BuildContext context) {
    final content = div(
      classes: 'flex flex-col items-center justify-center gap-3',
      [
        DSpinner(size: DSpinnerSize.lg),
        if (message != null)
          p(classes: 'text-sm text-gray-600', [Component.text(message!)]),
      ],
    );

    if (overlay) {
      return div(
        classes:
            'fixed inset-0 bg-white/80 flex items-center justify-center z-50',
        [content],
      );
    }

    return div(classes: 'py-12', [content]);
  }
}
