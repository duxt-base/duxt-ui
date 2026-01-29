import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../../theme/variants.dart';

/// Banner color variants
enum UBannerColor { primary, secondary, success, info, warning, error }

/// Banner variant styles
enum UBannerVariant { solid, outline, soft, subtle }

/// Banner position
enum UBannerPosition { top, bottom }

/// DuxtUI Banner component - Top/bottom banner message
class UBanner extends StatelessComponent {
  final String? title;
  final String? description;
  final UBannerColor color;
  final UBannerVariant variant;
  final UBannerPosition position;
  final Component? icon;
  final List<Component> actions;
  final bool closable;
  final VoidCallback? onClose;
  final bool sticky;

  const UBanner({
    super.key,
    this.title,
    this.description,
    this.color = UBannerColor.primary,
    this.variant = UBannerVariant.solid,
    this.position = UBannerPosition.top,
    this.icon,
    this.actions = const [],
    this.closable = true,
    this.onClose,
    this.sticky = false,
  });

  String get _colorName {
    switch (color) {
      case UBannerColor.primary:
        return 'green';
      case UBannerColor.secondary:
        return 'blue';
      case UBannerColor.success:
        return 'green';
      case UBannerColor.info:
        return 'blue';
      case UBannerColor.warning:
        return 'yellow';
      case UBannerColor.error:
        return 'red';
    }
  }

  String get _variantClasses {
    final c = _colorName;
    switch (variant) {
      case UBannerVariant.solid:
        return 'bg-$c-500 text-white';
      case UBannerVariant.outline:
        return 'bg-white dark:bg-gray-900 border-b border-$c-500 text-$c-600 dark:text-$c-400';
      case UBannerVariant.soft:
        return 'bg-$c-50 dark:bg-$c-950 text-$c-700 dark:text-$c-300';
      case UBannerVariant.subtle:
        return 'bg-$c-50 dark:bg-$c-950 border-b border-$c-200 dark:border-$c-800 text-$c-700 dark:text-$c-300';
    }
  }

  String get _positionClasses {
    final stickyClass = sticky ? 'sticky z-40' : '';
    switch (position) {
      case UBannerPosition.top:
        return '$stickyClass ${sticky ? "top-0" : ""}';
      case UBannerPosition.bottom:
        return '$stickyClass ${sticky ? "bottom-0" : ""}';
    }
  }

  String get _closeButtonClasses {
    switch (variant) {
      case UBannerVariant.solid:
        return 'text-white/80 hover:text-white hover:bg-white/10';
      case UBannerVariant.outline:
      case UBannerVariant.soft:
      case UBannerVariant.subtle:
        return 'text-gray-500 hover:text-gray-700 dark:hover:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800';
    }
  }

  String get _actionButtonClasses {
    switch (variant) {
      case UBannerVariant.solid:
        return 'text-white underline-offset-2 hover:underline';
      case UBannerVariant.outline:
      case UBannerVariant.soft:
      case UBannerVariant.subtle:
        return 'font-medium hover:underline';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: cx([
        'w-full',
        'px-4 py-3',
        _variantClasses,
        _positionClasses,
      ]),
      [
        div(
          classes: 'flex items-center justify-center gap-4 max-w-7xl mx-auto',
          [
            // Icon
            if (icon != null) div(classes: 'flex-shrink-0', [icon!]),
            // Content
            div(
              classes:
                  'flex-1 flex items-center justify-center gap-x-4 gap-y-2 flex-wrap text-center sm:text-left',
              [
                // Message
                div(
                  classes: 'text-sm',
                  [
                    if (title != null)
                      span(classes: 'font-semibold', [Component.text(title!)]),
                    if (title != null && description != null)
                      Component.text(' \u2013 '), // En dash separator
                    if (description != null)
                      span([Component.text(description!)]),
                  ],
                ),
                // Actions
                if (actions.isNotEmpty)
                  div(
                    classes: cx([
                      'flex items-center gap-3',
                      'text-sm',
                      _actionButtonClasses,
                    ]),
                    actions,
                  ),
              ],
            ),
            // Close button
            if (closable && onClose != null)
              button(
                type: ButtonType.button,
                onClick: onClose,
                classes: cx([
                  'flex-shrink-0',
                  'p-1',
                  'rounded',
                  'transition-colors',
                  _closeButtonClasses,
                ]),
                [
                  span(
                      classes: 'text-lg leading-none',
                      [Component.text('\u00D7')])
                ],
              ),
          ],
        ),
      ],
    );
  }
}

/// Banner link action
class UBannerAction extends StatelessComponent {
  final String label;
  final VoidCallback? onClick;
  final String? href;

  const UBannerAction({
    super.key,
    required this.label,
    this.onClick,
    this.href,
  });

  @override
  Component build(BuildContext context) {
    if (href != null) {
      return a(
        href: href!,
        classes: 'whitespace-nowrap',
        [Component.text(label)],
      );
    }
    return button(
      type: ButtonType.button,
      onClick: onClick,
      classes: 'whitespace-nowrap',
      [Component.text(label)],
    );
  }
}

/// Preset announcement banner
class UBannerAnnouncement extends StatelessComponent {
  final String message;
  final String? linkText;
  final String? linkHref;
  final VoidCallback? onClose;

  const UBannerAnnouncement({
    super.key,
    required this.message,
    this.linkText,
    this.linkHref,
    this.onClose,
  });

  @override
  Component build(BuildContext context) {
    return UBanner(
      description: message,
      color: UBannerColor.primary,
      variant: UBannerVariant.solid,
      closable: onClose != null,
      onClose: onClose,
      actions: linkText != null
          ? [UBannerAction(label: linkText!, href: linkHref)]
          : [],
    );
  }
}

/// Preset maintenance banner
class UBannerMaintenance extends StatelessComponent {
  final String? message;
  final VoidCallback? onClose;

  const UBannerMaintenance({
    super.key,
    this.message,
    this.onClose,
  });

  @override
  Component build(BuildContext context) {
    return UBanner(
      icon: div([Component.text('\u{1F6A7}')]), // Construction emoji
      title: 'Maintenance',
      description: message ??
          'We are currently performing maintenance. Some features may be unavailable.',
      color: UBannerColor.warning,
      variant: UBannerVariant.soft,
      closable: onClose != null,
      onClose: onClose,
    );
  }
}

/// Preset cookie consent banner
class UBannerCookieConsent extends StatelessComponent {
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final String? privacyPolicyHref;

  const UBannerCookieConsent({
    super.key,
    this.onAccept,
    this.onDecline,
    this.privacyPolicyHref,
  });

  @override
  Component build(BuildContext context) {
    return UBanner(
      description: 'We use cookies to enhance your browsing experience.',
      color: UBannerColor.info,
      variant: UBannerVariant.subtle,
      position: UBannerPosition.bottom,
      sticky: true,
      closable: false,
      actions: [
        if (privacyPolicyHref != null)
          UBannerAction(label: 'Learn more', href: privacyPolicyHref),
        button(
          type: ButtonType.button,
          onClick: onDecline,
          classes:
              'px-3 py-1 text-sm rounded bg-gray-200 dark:bg-gray-700 hover:bg-gray-300 dark:hover:bg-gray-600',
          [Component.text('Decline')],
        ),
        button(
          type: ButtonType.button,
          onClick: onAccept,
          classes:
              'px-3 py-1 text-sm rounded bg-blue-500 text-white hover:bg-blue-600',
          [Component.text('Accept')],
        ),
      ],
    );
  }
}
