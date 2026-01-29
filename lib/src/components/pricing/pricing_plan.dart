import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Feature item for pricing plan
class UPricingFeature {
  final String text;
  final bool included;
  final String? tooltip;

  const UPricingFeature({
    required this.text,
    this.included = true,
    this.tooltip,
  });
}

/// DuxtUI PricingPlan component - Single pricing plan card
///
/// Displays a pricing plan with name, description, price, features, and CTA.
/// Supports highlighting for popular/recommended plans.
class UPricingPlan extends StatelessComponent {
  /// Plan name
  final String name;

  /// Plan description
  final String? description;

  /// Price amount (e.g., "29", "99")
  final String price;

  /// Price currency symbol
  final String currency;

  /// Billing period (e.g., "/month", "/year")
  final String? period;

  /// Original price for showing discounts
  final String? originalPrice;

  /// Badge text (e.g., "Popular", "Best Value")
  final String? badge;

  /// Badge color classes
  final String? badgeColor;

  /// List of features
  final List<UPricingFeature> features;

  /// CTA button text
  final String buttonText;

  /// CTA button variant
  final String? buttonVariant;

  /// Button click handler
  final VoidCallback? onButtonClick;

  /// Button href for link
  final String? buttonHref;

  /// Whether this plan is highlighted
  final bool highlighted;

  /// Whether this plan is disabled
  final bool disabled;

  /// Additional CSS classes
  final String? classes;

  /// Custom header content
  final Component? header;

  /// Custom footer content
  final Component? footer;

  const UPricingPlan({
    super.key,
    required this.name,
    this.description,
    required this.price,
    this.currency = '\$',
    this.period,
    this.originalPrice,
    this.badge,
    this.badgeColor,
    required this.features,
    this.buttonText = 'Get started',
    this.buttonVariant,
    this.onButtonClick,
    this.buttonHref,
    this.highlighted = false,
    this.disabled = false,
    this.classes,
    this.header,
    this.footer,
  });

  @override
  Component build(BuildContext context) {
    final baseClasses = [
      'relative',
      'flex',
      'flex-col',
      'p-6',
      'lg:p-8',
      'rounded-2xl',
      'bg-white',
      'dark:bg-gray-800',
      'border',
      highlighted
          ? 'ring-2 ring-primary-500 border-primary-500 scale-105 shadow-xl z-10'
          : 'border-gray-200 dark:border-gray-700 shadow-sm',
      'transition-all',
      'duration-200',
      disabled ? 'opacity-60' : 'hover:shadow-lg',
      classes ?? '',
    ].where((c) => c.isNotEmpty).join(' ');

    return div(
      classes: baseClasses,
      [
        // Badge
        if (badge != null)
          div(
            classes: 'absolute -top-3 left-1/2 -translate-x-1/2',
            [
              span(
                classes:
                    'inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold ${badgeColor ?? "bg-primary-500 text-white"}',
                [Component.text(badge!)],
              ),
            ],
          ),

        // Custom header or default header
        if (header != null) header! else _buildDefaultHeader(),

        // Features list
        div(
          classes: 'flex-1 mt-6',
          [
            ul(
              classes: 'space-y-3',
              [
                for (final feature in features) _buildFeatureItem(feature),
              ],
            ),
          ],
        ),

        // CTA Button
        div(
          classes: 'mt-8',
          [
            _buildButton(),
          ],
        ),

        // Custom footer
        if (footer != null) div(classes: 'mt-4', [footer!]),
      ],
    );
  }

  Component _buildDefaultHeader() {
    return div([
      // Plan name
      h3(
        classes: 'text-lg font-semibold text-gray-900 dark:text-white',
        [Component.text(name)],
      ),

      // Description
      if (description != null)
        p(
          classes: 'mt-2 text-sm text-gray-500 dark:text-gray-400',
          [Component.text(description!)],
        ),

      // Price
      div(
        classes: 'mt-4 flex items-baseline gap-1',
        [
          // Original price (strikethrough)
          if (originalPrice != null)
            span(
              classes: 'text-lg text-gray-400 line-through mr-2',
              [Component.text('$currency$originalPrice')],
            ),
          // Currency
          span(
            classes: 'text-2xl font-semibold text-gray-900 dark:text-white',
            [Component.text(currency)],
          ),
          // Price amount
          span(
            classes:
                'text-4xl font-bold tracking-tight text-gray-900 dark:text-white',
            [Component.text(price)],
          ),
          // Period
          if (period != null)
            span(
              classes: 'text-sm text-gray-500 dark:text-gray-400',
              [Component.text(period!)],
            ),
        ],
      ),
    ]);
  }

  Component _buildFeatureItem(UPricingFeature feature) {
    final iconClasses = feature.included
        ? 'text-primary-500'
        : 'text-gray-300 dark:text-gray-600';

    final textClasses = feature.included
        ? 'text-gray-700 dark:text-gray-300'
        : 'text-gray-400 dark:text-gray-500 line-through';

    return li(
      classes: 'flex items-start gap-3',
      [
        // Checkmark or X icon
        span(
          classes: 'flex-shrink-0 mt-0.5 $iconClasses',
          [
            if (feature.included) RawText('''
                <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                </svg>
              ''') else RawText('''
                <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg>
              '''),
          ],
        ),
        // Feature text
        span(
          classes: 'text-sm $textClasses',
          [Component.text(feature.text)],
        ),
      ],
    );
  }

  Component _buildButton() {
    final buttonClasses = highlighted
        ? 'w-full py-3 px-4 rounded-lg font-semibold text-center transition-colors bg-primary-600 text-white hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2'
        : 'w-full py-3 px-4 rounded-lg font-semibold text-center transition-colors bg-gray-100 text-gray-900 hover:bg-gray-200 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2';

    final disabledClasses = disabled ? ' opacity-50 cursor-not-allowed' : '';

    if (buttonHref != null && !disabled) {
      return a(
        href: buttonHref!,
        classes: buttonClasses,
        [Component.text(buttonText)],
      );
    }

    return button(
      type: ButtonType.button,
      disabled: disabled,
      classes: '$buttonClasses$disabledClasses',
      events: !disabled && onButtonClick != null
          ? events(onClick: () => onButtonClick!())
          : null,
      [Component.text(buttonText)],
    );
  }
}
