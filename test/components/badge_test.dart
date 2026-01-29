import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/badge.dart';

void main() {
  group('DBadge', () {
    group('rendering', () {
      testComponents('renders with required label', (tester) async {
        tester.pumpComponent(DBadge(label: 'New'));

        expect(find.text('New'), findsOneComponent);
        expect(find.tag('span'), findsComponents);
      });

      testComponents('renders label text correctly', (tester) async {
        tester.pumpComponent(DBadge(label: 'Beta'));

        expect(find.text('Beta'), findsOneComponent);
      });
    });

    group('variants', () {
      testComponents('renders solid variant', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'Solid', variant: DBadgeVariant.solid),
        );

        expect(find.text('Solid'), findsOneComponent);
      });

      testComponents('renders outline variant', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'Outline', variant: DBadgeVariant.outline),
        );

        expect(find.text('Outline'), findsOneComponent);
      });

      testComponents('renders soft variant (default)', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'Soft', variant: DBadgeVariant.soft),
        );

        expect(find.text('Soft'), findsOneComponent);
      });

      testComponents('renders subtle variant', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'Subtle', variant: DBadgeVariant.subtle),
        );

        expect(find.text('Subtle'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'XS', size: DBadgeSize.xs),
        );

        expect(find.text('XS'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'SM', size: DBadgeSize.sm),
        );

        expect(find.text('SM'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'MD', size: DBadgeSize.md),
        );

        expect(find.text('MD'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'LG', size: DBadgeSize.lg),
        );

        expect(find.text('LG'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'XL', size: DBadgeSize.xl),
        );

        expect(find.text('XL'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'Primary', color: DBadgeColor.primary),
        );

        expect(find.text('Primary'), findsOneComponent);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'Secondary', color: DBadgeColor.secondary),
        );

        expect(find.text('Secondary'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'Success', color: DBadgeColor.success),
        );

        expect(find.text('Success'), findsOneComponent);
      });

      testComponents('renders info color', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'Info', color: DBadgeColor.info),
        );

        expect(find.text('Info'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'Warning', color: DBadgeColor.warning),
        );

        expect(find.text('Warning'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'Error', color: DBadgeColor.error),
        );

        expect(find.text('Error'), findsOneComponent);
      });

      testComponents('renders neutral color', (tester) async {
        tester.pumpComponent(
          DBadge(label: 'Neutral', color: DBadgeColor.neutral),
        );

        expect(find.text('Neutral'), findsOneComponent);
      });
    });

    group('icons', () {
      testComponents('renders with leading icon', (tester) async {
        tester.pumpComponent(
          DBadge(
            label: 'Badge',
            leadingIcon: span([Component.text('*')]),
          ),
        );

        expect(find.text('Badge'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders with trailing icon', (tester) async {
        tester.pumpComponent(
          DBadge(
            label: 'Badge',
            trailingIcon: span([Component.text('x')]),
          ),
        );

        expect(find.text('Badge'), findsOneComponent);
        expect(find.text('x'), findsOneComponent);
      });

      testComponents('renders with both icons', (tester) async {
        tester.pumpComponent(
          DBadge(
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
          DBadge(
            label: 'Rejected',
            variant: DBadgeVariant.solid,
            color: DBadgeColor.error,
          ),
        );

        expect(find.text('Rejected'), findsOneComponent);
      });

      testComponents('outline + success', (tester) async {
        tester.pumpComponent(
          DBadge(
            label: 'Approved',
            variant: DBadgeVariant.outline,
            color: DBadgeColor.success,
          ),
        );

        expect(find.text('Approved'), findsOneComponent);
      });

      testComponents('soft + warning', (tester) async {
        tester.pumpComponent(
          DBadge(
            label: 'Pending',
            variant: DBadgeVariant.soft,
            color: DBadgeColor.warning,
          ),
        );

        expect(find.text('Pending'), findsOneComponent);
      });

      testComponents('subtle + info', (tester) async {
        tester.pumpComponent(
          DBadge(
            label: 'Draft',
            variant: DBadgeVariant.subtle,
            color: DBadgeColor.info,
          ),
        );

        expect(find.text('Draft'), findsOneComponent);
      });

      testComponents('solid + neutral', (tester) async {
        tester.pumpComponent(
          DBadge(
            label: 'Default',
            variant: DBadgeVariant.solid,
            color: DBadgeColor.neutral,
          ),
        );

        expect(find.text('Default'), findsOneComponent);
      });
    });

    group('size + variant combinations', () {
      testComponents('xs + solid', (tester) async {
        tester.pumpComponent(
          DBadge(
            label: 'XS',
            size: DBadgeSize.xs,
            variant: DBadgeVariant.solid,
          ),
        );

        expect(find.text('XS'), findsOneComponent);
      });

      testComponents('xl + outline', (tester) async {
        tester.pumpComponent(
          DBadge(
            label: 'XL',
            size: DBadgeSize.xl,
            variant: DBadgeVariant.outline,
          ),
        );

        expect(find.text('XL'), findsOneComponent);
      });
    });
  });
}
