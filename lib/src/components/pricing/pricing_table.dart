import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// A plan column in the pricing table
class UPricingTablePlan {
  /// Plan name
  final String name;

  /// Price display
  final String price;

  /// Price period
  final String? period;

  /// Badge text
  final String? badge;

  /// Whether this plan is highlighted
  final bool highlighted;

  /// CTA button text
  final String buttonText;

  /// Button href
  final String? buttonHref;

  /// Button click handler
  final VoidCallback? onButtonClick;

  const UPricingTablePlan({
    required this.name,
    required this.price,
    this.period,
    this.badge,
    this.highlighted = false,
    this.buttonText = 'Choose plan',
    this.buttonHref,
    this.onButtonClick,
  });
}

/// A feature row in the pricing table
class UPricingTableFeature {
  /// Feature name
  final String name;

  /// Feature description/tooltip
  final String? description;

  /// Values for each plan (can be bool, String, or Component)
  final List<dynamic> values;

  const UPricingTableFeature({
    required this.name,
    this.description,
    required this.values,
  });
}

/// Feature category/group
class UPricingTableCategory {
  /// Category name
  final String name;

  /// Features in this category
  final List<UPricingTableFeature> features;

  const UPricingTableCategory({
    required this.name,
    required this.features,
  });
}

/// DuxtUI PricingTable component - Feature comparison table
///
/// Displays a detailed feature comparison table with plans as columns
/// and features as rows. Supports categories, checkmarks, and custom values.
class UPricingTable extends StatelessComponent {
  /// List of plans (columns)
  final List<UPricingTablePlan> plans;

  /// List of feature categories
  final List<UPricingTableCategory> categories;

  /// Optional ungrouped features (shown at top if no categories)
  final List<UPricingTableFeature> features;

  /// Additional CSS classes
  final String? classes;

  /// Whether to show plan headers as sticky
  final bool stickyHeaders;

  /// Whether to make table horizontally scrollable on mobile
  final bool scrollable;

  const UPricingTable({
    super.key,
    required this.plans,
    this.categories = const [],
    this.features = const [],
    this.classes,
    this.stickyHeaders = true,
    this.scrollable = true,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: '${scrollable ? "overflow-x-auto" : ""} ${classes ?? ""}',
      [
        table(
          classes: 'w-full border-collapse',
          [
            // Table header with plans
            thead([
              tr(
                classes: stickyHeaders ? 'sticky top-0 z-10' : '',
                [
                  // Empty cell for feature column
                  th(
                    classes: 'bg-white dark:bg-gray-900 px-6 py-4 text-left',
                    [],
                  ),
                  // Plan columns
                  for (final plan in plans) _buildPlanHeader(plan),
                ],
              ),
            ]),
            // Table body with features
            tbody([
              // Ungrouped features
              if (features.isNotEmpty)
                for (final feature in features) _buildFeatureRow(feature),
              // Categorized features
              for (final category in categories) ...[
                _buildCategoryRow(category),
                for (final feature in category.features)
                  _buildFeatureRow(feature),
              ],
            ]),
            // Table footer with CTA buttons
            tfoot([
              tr([
                td(classes: 'px-6 py-6', []),
                for (final plan in plans) _buildPlanFooter(plan),
              ]),
            ]),
          ],
        ),
      ],
    );
  }

  Component _buildPlanHeader(UPricingTablePlan plan) {
    final bgClass = plan.highlighted
        ? 'bg-primary-50 dark:bg-primary-900/20'
        : 'bg-gray-50 dark:bg-gray-800';

    return th(
      classes: 'px-6 py-6 text-center $bgClass relative',
      [
        // Badge
        if (plan.badge != null)
          div(
            classes: 'absolute -top-3 left-1/2 -translate-x-1/2',
            [
              span(
                classes:
                    'inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-primary-500 text-white',
                [Component.text(plan.badge!)],
              ),
            ],
          ),
        // Plan name
        div(
          classes: 'text-lg font-semibold text-gray-900 dark:text-white',
          [Component.text(plan.name)],
        ),
        // Price
        div(
          classes: 'mt-2 flex items-baseline justify-center gap-1',
          [
            span(
              classes: 'text-3xl font-bold text-gray-900 dark:text-white',
              [Component.text(plan.price)],
            ),
            if (plan.period != null)
              span(
                classes: 'text-sm text-gray-500 dark:text-gray-400',
                [Component.text(plan.period!)],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildCategoryRow(UPricingTableCategory category) {
    return tr(
      classes: 'border-t border-gray-200 dark:border-gray-700',
      [
        td(
          attributes: {'colspan': (plans.length + 1).toString()},
          classes: 'px-6 py-4 bg-gray-50 dark:bg-gray-800/50',
          [
            span(
              classes:
                  'text-sm font-semibold text-gray-900 dark:text-white uppercase tracking-wider',
              [Component.text(category.name)],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildFeatureRow(UPricingTableFeature feature) {
    return tr(
      classes:
          'border-t border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-800/50',
      [
        // Feature name
        td(
          classes: 'px-6 py-4',
          [
            div(
              classes: 'text-sm font-medium text-gray-900 dark:text-white',
              [Component.text(feature.name)],
            ),
            if (feature.description != null)
              div(
                classes: 'text-xs text-gray-500 dark:text-gray-400 mt-0.5',
                [Component.text(feature.description!)],
              ),
          ],
        ),
        // Values for each plan
        for (var i = 0; i < plans.length; i++)
          _buildFeatureValue(
            i < feature.values.length ? feature.values[i] : null,
            plans[i].highlighted,
          ),
      ],
    );
  }

  Component _buildFeatureValue(dynamic value, bool highlighted) {
    final bgClass =
        highlighted ? 'bg-primary-50/50 dark:bg-primary-900/10' : '';

    if (value == null) {
      return td(
        classes: 'px-6 py-4 text-center $bgClass',
        [
          span(
            classes: 'text-gray-300 dark:text-gray-600',
            [Component.text('-')],
          ),
        ],
      );
    }

    if (value is bool) {
      return td(
        classes: 'px-6 py-4 text-center $bgClass',
        [
          if (value)
            span(
              classes: 'text-primary-500',
              [
                RawText('''
                  <svg class="h-5 w-5 mx-auto" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                  </svg>
                '''),
              ],
            )
          else
            span(
              classes: 'text-gray-300 dark:text-gray-600',
              [
                RawText('''
                  <svg class="h-5 w-5 mx-auto" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
                  </svg>
                '''),
              ],
            ),
        ],
      );
    }

    if (value is String) {
      return td(
        classes: 'px-6 py-4 text-center $bgClass',
        [
          span(
            classes: 'text-sm text-gray-900 dark:text-white',
            [Component.text(value)],
          ),
        ],
      );
    }

    if (value is Component) {
      return td(
        classes: 'px-6 py-4 text-center $bgClass',
        [value],
      );
    }

    return td(
      classes: 'px-6 py-4 text-center $bgClass',
      [Component.text(value.toString())],
    );
  }

  Component _buildPlanFooter(UPricingTablePlan plan) {
    final bgClass =
        plan.highlighted ? 'bg-primary-50/50 dark:bg-primary-900/10' : '';

    final buttonClasses = plan.highlighted
        ? 'w-full py-2.5 px-4 rounded-lg font-semibold text-sm text-center transition-colors bg-primary-600 text-white hover:bg-primary-700'
        : 'w-full py-2.5 px-4 rounded-lg font-semibold text-sm text-center transition-colors bg-gray-100 text-gray-900 hover:bg-gray-200 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600';

    return td(
      classes: 'px-6 py-6 $bgClass',
      [
        if (plan.buttonHref != null)
          a(
            href: plan.buttonHref!,
            classes: buttonClasses,
            [Component.text(plan.buttonText)],
          )
        else
          button(
            type: ButtonType.button,
            classes: buttonClasses,
            events: plan.onButtonClick != null
                ? events(onClick: () => plan.onButtonClick!())
                : null,
            [Component.text(plan.buttonText)],
          ),
      ],
    );
  }
}
