import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'pricing_plan.dart';

/// Grid column configuration for pricing plans
enum UPricingPlansColumns { two, three, four }

/// DuxtUI PricingPlans component - Grid of pricing plan cards
///
/// Displays a responsive grid of UPricingPlan components.
/// Typically used for side-by-side plan comparison.
class UPricingPlans extends StatelessComponent {
  /// List of pricing plans
  final List<UPricingPlan> plans;

  /// Number of columns at large breakpoint
  final UPricingPlansColumns columns;

  /// Gap between plans
  final String gap;

  /// Additional CSS classes
  final String? classes;

  /// Optional title for the section
  final String? title;

  /// Optional description for the section
  final String? description;

  /// Whether to center the grid when fewer plans than columns
  final bool centerWhenFewer;

  /// Billing toggle component (monthly/yearly)
  final Component? billingToggle;

  const UPricingPlans({
    super.key,
    required this.plans,
    this.columns = UPricingPlansColumns.three,
    this.gap = 'gap-8',
    this.classes,
    this.title,
    this.description,
    this.centerWhenFewer = true,
    this.billingToggle,
  });

  String get _columnClasses {
    switch (columns) {
      case UPricingPlansColumns.two:
        return 'grid-cols-1 md:grid-cols-2';
      case UPricingPlansColumns.three:
        return 'grid-cols-1 md:grid-cols-2 lg:grid-cols-3';
      case UPricingPlansColumns.four:
        return 'grid-cols-1 md:grid-cols-2 lg:grid-cols-4';
    }
  }

  @override
  Component build(BuildContext context) {
    final hasHeader =
        title != null || description != null || billingToggle != null;

    return div(
      classes: classes,
      [
        if (hasHeader) _buildHeader(),
        div(
          classes:
              'grid $_columnClasses $gap items-start ${centerWhenFewer ? "justify-center" : ""}',
          plans,
        ),
      ],
    );
  }

  Component _buildHeader() {
    return div(
      classes: 'text-center mb-12',
      [
        if (title != null)
          h2(
            classes:
                'text-3xl font-bold text-gray-900 dark:text-white sm:text-4xl',
            [Component.text(title!)],
          ),
        if (description != null)
          p(
            classes:
                'mt-4 text-lg text-gray-600 dark:text-gray-400 max-w-2xl mx-auto',
            [Component.text(description!)],
          ),
        if (billingToggle != null) div(classes: 'mt-8', [billingToggle!]),
      ],
    );
  }
}

/// Billing toggle component for switching between monthly/yearly pricing
class UBillingToggle extends StatelessComponent {
  /// Currently selected option (true = yearly, false = monthly)
  final bool isYearly;

  /// Monthly label
  final String monthlyLabel;

  /// Yearly label
  final String yearlyLabel;

  /// Savings badge text for yearly (e.g., "Save 20%")
  final String? yearlySavings;

  /// Change callback
  final void Function(bool isYearly)? onChange;

  const UBillingToggle({
    super.key,
    required this.isYearly,
    this.monthlyLabel = 'Monthly',
    this.yearlyLabel = 'Yearly',
    this.yearlySavings,
    this.onChange,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'inline-flex items-center gap-3 p-1 bg-gray-100 dark:bg-gray-800 rounded-lg',
      [
        // Monthly button
        button(
          type: ButtonType.button,
          classes:
              'px-4 py-2 text-sm font-medium rounded-md transition-colors ${!isYearly ? "bg-white dark:bg-gray-700 text-gray-900 dark:text-white shadow-sm" : "text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white"}',
          events: events(onClick: () => onChange?.call(false)),
          [Component.text(monthlyLabel)],
        ),
        // Yearly button
        button(
          type: ButtonType.button,
          classes:
              'px-4 py-2 text-sm font-medium rounded-md transition-colors flex items-center gap-2 ${isYearly ? "bg-white dark:bg-gray-700 text-gray-900 dark:text-white shadow-sm" : "text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white"}',
          events: events(onClick: () => onChange?.call(true)),
          [
            Component.text(yearlyLabel),
            if (yearlySavings != null)
              span(
                classes:
                    'inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-700 dark:bg-green-900 dark:text-green-300',
                [Component.text(yearlySavings!)],
              ),
          ],
        ),
      ],
    );
  }
}
