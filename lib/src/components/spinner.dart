import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Spinner sizes
enum USpinnerSize { xs, sm, md, lg }

/// DuxtUI Spinner component
class USpinner extends StatelessComponent {
  final USpinnerSize size;
  final String? color;

  const USpinner({
    super.key,
    this.size = USpinnerSize.md,
    this.color,
  });

  String get _sizeClasses {
    switch (size) {
      case USpinnerSize.xs:
        return 'h-3 w-3 border';
      case USpinnerSize.sm:
        return 'h-4 w-4 border-2';
      case USpinnerSize.md:
        return 'h-6 w-6 border-2';
      case USpinnerSize.lg:
        return 'h-8 w-8 border-2';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'animate-spin $_sizeClasses ${color ?? "border-indigo-600"} border-t-transparent rounded-full',
      [],
    );
  }
}

/// DuxtUI Loading overlay
class ULoading extends StatelessComponent {
  final String? message;
  final bool overlay;

  const ULoading({
    super.key,
    this.message,
    this.overlay = false,
  });

  @override
  Component build(BuildContext context) {
    final content = div(
      classes: 'flex flex-col items-center justify-center gap-3',
      [
        USpinner(size: USpinnerSize.lg),
        if (message != null)
          p(classes: 'text-sm text-gray-600', [text(message!)]),
      ],
    );

    if (overlay) {
      return div(
        classes: 'fixed inset-0 bg-white/80 flex items-center justify-center z-50',
        [content],
      );
    }

    return div(classes: 'py-12', [content]);
  }
}
