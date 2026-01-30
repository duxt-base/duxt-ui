import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/data/chip.dart';
import 'package:duxt_ui/src/theme/colors.dart';
import 'package:duxt_ui/src/theme/variants.dart';

void main() {
  group('DChip', () {
    group('rendering', () {
      testComponents('renders with required label', (tester) async {
        tester.pumpComponent(DChip(label: 'Tag'));

        expect(find.text('Tag'), findsOneComponent);
        expect(find.tag('span'), findsComponents);
      });

      testComponents('renders label text correctly', (tester) async {
        tester.pumpComponent(DChip(label: 'Category'));

        expect(find.text('Category'), findsOneComponent);
      });
    });

    group('variants', () {
      testComponents('renders solid variant', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Solid', variant: DChipVariant.solid),
        );

        expect(find.text('Solid'), findsOneComponent);
      });

      testComponents('renders soft variant (default)', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Soft', variant: DChipVariant.soft),
        );

        expect(find.text('Soft'), findsOneComponent);
      });

      testComponents('renders outline variant', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Outline', variant: DChipVariant.outline),
        );

        expect(find.text('Outline'), findsOneComponent);
      });

      testComponents('renders subtle variant', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Subtle', variant: DChipVariant.subtle),
        );

        expect(find.text('Subtle'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DChip(label: 'XS', size: DSize.xs),
        );

        expect(find.text('XS'), findsOneComponent);
      });

      testComponents('renders sm size (default)', (tester) async {
        tester.pumpComponent(
          DChip(label: 'SM', size: DSize.sm),
        );

        expect(find.text('SM'), findsOneComponent);
      });

      testComponents('renders md size', (tester) async {
        tester.pumpComponent(
          DChip(label: 'MD', size: DSize.md),
        );

        expect(find.text('MD'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DChip(label: 'LG', size: DSize.lg),
        );

        expect(find.text('LG'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DChip(label: 'XL', size: DSize.xl),
        );

        expect(find.text('XL'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Primary', color: DColor.primary),
        );

        expect(find.text('Primary'), findsOneComponent);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Secondary', color: DColor.secondary),
        );

        expect(find.text('Secondary'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Success', color: DColor.success),
        );

        expect(find.text('Success'), findsOneComponent);
      });

      testComponents('renders info color', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Info', color: DColor.info),
        );

        expect(find.text('Info'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Warning', color: DColor.warning),
        );

        expect(find.text('Warning'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Error', color: DColor.error),
        );

        expect(find.text('Error'), findsOneComponent);
      });

      testComponents('renders neutral color', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Neutral', color: DColor.neutral),
        );

        expect(find.text('Neutral'), findsOneComponent);
      });
    });

    group('icons', () {
      testComponents('renders with leading icon', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Tag', leadingIcon: 'i-lucide-tag'),
        );

        expect(find.text('Tag'), findsOneComponent);
        expect(find.tag('i'), findsComponents);
      });

      testComponents('renders with trailing icon', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Tag', trailingIcon: 'i-lucide-x'),
        );

        expect(find.text('Tag'), findsOneComponent);
        expect(find.tag('button'), findsComponents);
      });

      testComponents('renders with both icons', (tester) async {
        tester.pumpComponent(
          DChip(
            label: 'Tag',
            leadingIcon: 'i-lucide-tag',
            trailingIcon: 'i-lucide-x',
          ),
        );

        expect(find.text('Tag'), findsOneComponent);
      });
    });

    group('dot indicator', () {
      testComponents('renders with dot indicator', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Status', showDot: true),
        );

        expect(find.text('Status'), findsOneComponent);
        expect(find.tag('span'), findsComponents);
      });

      testComponents('renders without dot indicator (default)', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Status', showDot: false),
        );

        expect(find.text('Status'), findsOneComponent);
      });
    });

    group('disabled state', () {
      testComponents('renders disabled chip', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Disabled', disabled: true),
        );

        expect(find.text('Disabled'), findsOneComponent);
      });

      testComponents('renders enabled chip (default)', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Enabled', disabled: false),
        );

        expect(find.text('Enabled'), findsOneComponent);
      });
    });

    group('click handlers', () {
      testComponents('renders as button when onClick provided', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Clickable', onClick: () {}),
        );

        expect(find.text('Clickable'), findsOneComponent);
        expect(find.tag('button'), findsComponents);
      });

      testComponents('renders as span when no onClick', (tester) async {
        tester.pumpComponent(
          DChip(label: 'Static'),
        );

        expect(find.text('Static'), findsOneComponent);
      });

      testComponents('renders trailing icon with click handler',
          (tester) async {
        tester.pumpComponent(
          DChip(
            label: 'Removable',
            trailingIcon: 'i-lucide-x',
            onTrailingClick: () {},
          ),
        );

        expect(find.text('Removable'), findsOneComponent);
      });
    });

    group('variant + color combinations', () {
      testComponents('solid + error', (tester) async {
        tester.pumpComponent(
          DChip(
            label: 'Error',
            variant: DChipVariant.solid,
            color: DColor.error,
          ),
        );

        expect(find.text('Error'), findsOneComponent);
      });

      testComponents('outline + success', (tester) async {
        tester.pumpComponent(
          DChip(
            label: 'Success',
            variant: DChipVariant.outline,
            color: DColor.success,
          ),
        );

        expect(find.text('Success'), findsOneComponent);
      });

      testComponents('soft + warning', (tester) async {
        tester.pumpComponent(
          DChip(
            label: 'Warning',
            variant: DChipVariant.soft,
            color: DColor.warning,
          ),
        );

        expect(find.text('Warning'), findsOneComponent);
      });
    });
  });

  group('DChipGroup', () {
    group('rendering', () {
      testComponents('renders with required chips', (tester) async {
        tester.pumpComponent(DChipGroup(
          chips: [
            DChip(label: 'Chip 1'),
            DChip(label: 'Chip 2'),
            DChip(label: 'Chip 3'),
          ],
        ));

        expect(find.text('Chip 1'), findsOneComponent);
        expect(find.text('Chip 2'), findsOneComponent);
        expect(find.text('Chip 3'), findsOneComponent);
      });

      testComponents('renders empty group', (tester) async {
        tester.pumpComponent(DChipGroup(
          chips: [],
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('gap prop', () {
      testComponents('renders with default gap', (tester) async {
        tester.pumpComponent(DChipGroup(
          chips: [DChip(label: 'A'), DChip(label: 'B')],
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with custom gap', (tester) async {
        tester.pumpComponent(DChipGroup(
          chips: [DChip(label: 'A'), DChip(label: 'B')],
          gap: 'gap-4',
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('wrap prop', () {
      testComponents('renders with wrap enabled (default)', (tester) async {
        tester.pumpComponent(DChipGroup(
          chips: [DChip(label: 'A')],
          wrap: true,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with wrap disabled', (tester) async {
        tester.pumpComponent(DChipGroup(
          chips: [DChip(label: 'A')],
          wrap: false,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });
  });
}
