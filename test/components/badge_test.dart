import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/badge.dart';

void main() {
  group('UBadge', () {
    group('rendering', () {
      testComponents('renders with required label', (tester) async {
        tester.pumpComponent(UBadge(label: 'New'));

        expect(find.text('New'), findsOneComponent);
        expect(find.tag('span'), findsComponents);
      });

      testComponents('renders label text correctly', (tester) async {
        tester.pumpComponent(UBadge(label: 'Beta'));

        expect(find.text('Beta'), findsOneComponent);
      });
    });

    group('variants', () {
      testComponents('renders solid variant', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'Solid', variant: UBadgeVariant.solid),
        );

        expect(find.text('Solid'), findsOneComponent);
      });

      testComponents('renders outline variant', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'Outline', variant: UBadgeVariant.outline),
        );

        expect(find.text('Outline'), findsOneComponent);
      });

      testComponents('renders soft variant (default)', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'Soft', variant: UBadgeVariant.soft),
        );

        expect(find.text('Soft'), findsOneComponent);
      });

      testComponents('renders subtle variant', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'Subtle', variant: UBadgeVariant.subtle),
        );

        expect(find.text('Subtle'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'XS', size: UBadgeSize.xs),
        );

        expect(find.text('XS'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'SM', size: UBadgeSize.sm),
        );

        expect(find.text('SM'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'MD', size: UBadgeSize.md),
        );

        expect(find.text('MD'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'LG', size: UBadgeSize.lg),
        );

        expect(find.text('LG'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'XL', size: UBadgeSize.xl),
        );

        expect(find.text('XL'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'Primary', color: UBadgeColor.primary),
        );

        expect(find.text('Primary'), findsOneComponent);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'Secondary', color: UBadgeColor.secondary),
        );

        expect(find.text('Secondary'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'Success', color: UBadgeColor.success),
        );

        expect(find.text('Success'), findsOneComponent);
      });

      testComponents('renders info color', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'Info', color: UBadgeColor.info),
        );

        expect(find.text('Info'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'Warning', color: UBadgeColor.warning),
        );

        expect(find.text('Warning'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'Error', color: UBadgeColor.error),
        );

        expect(find.text('Error'), findsOneComponent);
      });

      testComponents('renders neutral color', (tester) async {
        tester.pumpComponent(
          UBadge(label: 'Neutral', color: UBadgeColor.neutral),
        );

        expect(find.text('Neutral'), findsOneComponent);
      });
    });

    group('icons', () {
      testComponents('renders with leading icon', (tester) async {
        tester.pumpComponent(
          UBadge(
            label: 'Badge',
            leadingIcon: span([Component.text('*')]),
          ),
        );

        expect(find.text('Badge'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders with trailing icon', (tester) async {
        tester.pumpComponent(
          UBadge(
            label: 'Badge',
            trailingIcon: span([Component.text('x')]),
          ),
        );

        expect(find.text('Badge'), findsOneComponent);
        expect(find.text('x'), findsOneComponent);
      });

      testComponents('renders with both icons', (tester) async {
        tester.pumpComponent(
          UBadge(
            label: 'Badge',
            leadingIcon: span([Component.text('<')]),
            trailingIcon: span([Component.text('>')]),
          ),
        );

        expect(find.text('Badge'), findsOneComponent);
        expect(find.text('<'), findsOneComponent);
        expect(find.text('>'), findsOneComponent);
      });
    });

    group('variant + color combinations', () {
      testComponents('solid + error', (tester) async {
        tester.pumpComponent(
          UBadge(
            label: 'Rejected',
            variant: UBadgeVariant.solid,
            color: UBadgeColor.error,
          ),
        );

        expect(find.text('Rejected'), findsOneComponent);
      });

      testComponents('outline + success', (tester) async {
        tester.pumpComponent(
          UBadge(
            label: 'Approved',
            variant: UBadgeVariant.outline,
            color: UBadgeColor.success,
          ),
        );

        expect(find.text('Approved'), findsOneComponent);
      });

      testComponents('soft + warning', (tester) async {
        tester.pumpComponent(
          UBadge(
            label: 'Pending',
            variant: UBadgeVariant.soft,
            color: UBadgeColor.warning,
          ),
        );

        expect(find.text('Pending'), findsOneComponent);
      });

      testComponents('subtle + info', (tester) async {
        tester.pumpComponent(
          UBadge(
            label: 'Draft',
            variant: UBadgeVariant.subtle,
            color: UBadgeColor.info,
          ),
        );

        expect(find.text('Draft'), findsOneComponent);
      });

      testComponents('solid + neutral', (tester) async {
        tester.pumpComponent(
          UBadge(
            label: 'Default',
            variant: UBadgeVariant.solid,
            color: UBadgeColor.neutral,
          ),
        );

        expect(find.text('Default'), findsOneComponent);
      });
    });

    group('size + variant combinations', () {
      testComponents('xs + solid', (tester) async {
        tester.pumpComponent(
          UBadge(
            label: 'XS',
            size: UBadgeSize.xs,
            variant: UBadgeVariant.solid,
          ),
        );

        expect(find.text('XS'), findsOneComponent);
      });

      testComponents('xl + outline', (tester) async {
        tester.pumpComponent(
          UBadge(
            label: 'XL',
            size: UBadgeSize.xl,
            variant: UBadgeVariant.outline,
          ),
        );

        expect(find.text('XL'), findsOneComponent);
      });
    });
  });
}
