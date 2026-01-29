import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../../theme/variants.dart';
import '../../theme/colors.dart';

/// Error severity levels
enum UErrorSeverity { warning, error, fatal }

/// DuxtUI Error component - Error state display
class UError extends StatelessComponent {
  final String? icon;
  final Component? iconComponent;
  final String? title;
  final String? description;
  final String? errorCode;
  final Component? action;
  final List<Component> children;
  final USize size;
  final UErrorSeverity severity;
  final bool padded;
  final VoidCallback? onRetry;

  const UError({
    super.key,
    this.icon,
    this.iconComponent,
    this.title,
    this.description,
    this.errorCode,
    this.action,
    this.children = const [],
    this.size = USize.md,
    this.severity = UErrorSeverity.error,
    this.padded = true,
    this.onRetry,
  });

  String get _severityColorClasses {
    switch (severity) {
      case UErrorSeverity.warning:
        return 'text-yellow-500 dark:text-yellow-400';
      case UErrorSeverity.error:
        return 'text-red-500 dark:text-red-400';
      case UErrorSeverity.fatal:
        return 'text-red-600 dark:text-red-500';
    }
  }

  String get _iconSizeClasses {
    switch (size) {
      case USize.xs:
        return 'text-3xl';
      case USize.sm:
        return 'text-4xl';
      case USize.md:
        return 'text-5xl';
      case USize.lg:
        return 'text-6xl';
      case USize.xl:
        return 'text-7xl';
    }
  }

  String get _titleSizeClasses {
    switch (size) {
      case USize.xs:
        return 'text-sm';
      case USize.sm:
        return 'text-base';
      case USize.md:
        return 'text-lg';
      case USize.lg:
        return 'text-xl';
      case USize.xl:
        return 'text-2xl';
    }
  }

  String get _descriptionSizeClasses {
    switch (size) {
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
    if (!padded) return '';
    switch (size) {
      case USize.xs:
        return 'py-6';
      case USize.sm:
        return 'py-8';
      case USize.md:
        return 'py-12';
      case USize.lg:
        return 'py-16';
      case USize.xl:
        return 'py-20';
    }
  }

  String get _defaultIcon {
    switch (severity) {
      case UErrorSeverity.warning:
        return '\u26A0\uFE0F'; // Warning sign
      case UErrorSeverity.error:
        return '\u274C'; // Cross mark
      case UErrorSeverity.fatal:
        return '\u{1F6A8}'; // Emergency light
    }
  }

  String get _defaultTitle {
    switch (severity) {
      case UErrorSeverity.warning:
        return 'Warning';
      case UErrorSeverity.error:
        return 'Something went wrong';
      case UErrorSeverity.fatal:
        return 'Critical error';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: cx([
        'flex flex-col items-center justify-center text-center',
        _paddingClasses,
      ]),
      [
        // Icon
        if (iconComponent != null)
          div(
            classes: cx(['mb-4', _severityColorClasses]),
            [iconComponent!],
          )
        else
          div(
            classes: cx([
              'mb-4',
              _iconSizeClasses,
              _severityColorClasses,
            ]),
            [Component.text(icon ?? _defaultIcon)],
          ),
        // Title
        h3(
          classes: cx([
            'font-semibold',
            _titleSizeClasses,
            UTextColors.highlighted,
            'mb-2',
          ]),
          [Component.text(title ?? _defaultTitle)],
        ),
        // Description
        if (description != null)
          p(
            classes: cx([
              _descriptionSizeClasses,
              UTextColors.muted,
              'max-w-sm',
              'mb-2',
            ]),
            [Component.text(description!)],
          ),
        // Error code
        if (errorCode != null)
          p(
            classes: cx([
              'text-xs',
              'font-mono',
              UTextColors.dimmed,
              'mb-4',
            ]),
            [Component.text('Error code: $errorCode')],
          ),
        // Custom children
        if (children.isNotEmpty) div(classes: 'mt-2', children),
        // Actions
        div(
          classes: 'flex items-center gap-3 mt-4',
          [
            // Retry button
            if (onRetry != null)
              button(
                type: ButtonType.button,
                onClick: onRetry,
                classes: cx([
                  'px-4 py-2',
                  'text-sm font-medium',
                  'text-white',
                  'bg-gray-900 dark:bg-white dark:text-gray-900',
                  'rounded-lg',
                  'hover:bg-gray-800 dark:hover:bg-gray-100',
                  'transition-colors',
                ]),
                [Component.text('Try again')],
              ),
            // Custom action
            if (action != null) action!,
          ],
        ),
      ],
    );
  }
}

/// Preset 404 error state
class UError404 extends StatelessComponent {
  final Component? action;

  const UError404({super.key, this.action});

  @override
  Component build(BuildContext context) {
    return UError(
      icon: '\u{1F50D}', // Magnifying glass
      title: 'Page not found',
      description:
          'The page you are looking for does not exist or has been moved.',
      errorCode: '404',
      action: action,
    );
  }
}

/// Preset 500 error state
class UError500 extends StatelessComponent {
  final VoidCallback? onRetry;
  final Component? action;

  const UError500({super.key, this.onRetry, this.action});

  @override
  Component build(BuildContext context) {
    return UError(
      icon: '\u{1F6A7}', // Construction
      title: 'Server error',
      description: 'An unexpected error occurred. Please try again later.',
      errorCode: '500',
      severity: UErrorSeverity.fatal,
      onRetry: onRetry,
      action: action,
    );
  }
}

/// Preset network error state
class UErrorNetwork extends StatelessComponent {
  final VoidCallback? onRetry;

  const UErrorNetwork({super.key, this.onRetry});

  @override
  Component build(BuildContext context) {
    return UError(
      icon: '\u{1F4F6}', // Signal bars
      title: 'Network error',
      description:
          'Unable to connect. Please check your internet connection and try again.',
      onRetry: onRetry,
    );
  }
}
