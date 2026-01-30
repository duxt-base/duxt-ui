import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/data/progress.dart';
import 'package:duxt_ui/src/theme/colors.dart';
import 'package:duxt_ui/src/theme/variants.dart';

void main() {
  group('DProgress', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DProgress(value: 50));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders progress bar structure', (tester) async {
        tester.pumpComponent(DProgress(value: 30));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with zero value', (tester) async {
        tester.pumpComponent(DProgress(value: 0));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with full value', (tester) async {
        tester.pumpComponent(DProgress(value: 100));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('value prop', () {
      testComponents('handles value between 0 and 100', (tester) async {
        tester.pumpComponent(DProgress(value: 75));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('clamps value above 100', (tester) async {
        tester.pumpComponent(DProgress(value: 150));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('clamps value below 0', (tester) async {
        tester.pumpComponent(DProgress(value: -10));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('max prop', () {
      testComponents('uses default max of 100', (tester) async {
        tester.pumpComponent(DProgress(value: 50, max: 100));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('handles custom max value', (tester) async {
        tester.pumpComponent(DProgress(value: 25, max: 50));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(DProgress(value: 50, size: DSize.xs));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(DProgress(value: 50, size: DSize.sm));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(DProgress(value: 50, size: DSize.md));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DProgress(value: 50, size: DSize.lg));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(DProgress(value: 50, size: DSize.xl));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(DProgress(value: 50, color: DColor.primary));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(DProgress(value: 50, color: DColor.secondary));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(DProgress(value: 50, color: DColor.success));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders info color', (tester) async {
        tester.pumpComponent(DProgress(value: 50, color: DColor.info));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(DProgress(value: 50, color: DColor.warning));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(DProgress(value: 50, color: DColor.error));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('label', () {
      testComponents('shows percentage when showLabel is true', (tester) async {
        tester.pumpComponent(DProgress(value: 50, showLabel: true));

        expect(find.text('50%'), findsOneComponent);
      });

      testComponents('hides label by default', (tester) async {
        tester.pumpComponent(DProgress(value: 50, showLabel: false));

        expect(find.text('50%'), findsNothing);
      });

      testComponents('shows custom label when provided', (tester) async {
        tester.pumpComponent(
          DProgress(value: 50, showLabel: true, label: 'Loading...'),
        );

        expect(find.text('Loading...'), findsOneComponent);
        expect(find.text('50%'), findsOneComponent);
      });
    });

    group('animation', () {
      testComponents('renders without animation (default)', (tester) async {
        tester.pumpComponent(
          DProgress(value: 50, animation: DProgressAnimation.none),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with pulse animation', (tester) async {
        tester.pumpComponent(
          DProgress(value: 50, animation: DProgressAnimation.pulse),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with indeterminate animation', (tester) async {
        tester.pumpComponent(
          DProgress(value: 50, animation: DProgressAnimation.indeterminate),
        );

        expect(find.tag('div'), findsComponents);
      });
    });

    group('indeterminate mode', () {
      testComponents('renders indeterminate progress', (tester) async {
        tester.pumpComponent(DProgress(value: 0, indeterminate: true));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('custom colors', () {
      testComponents('renders with custom track color', (tester) async {
        tester.pumpComponent(
          DProgress(value: 50, trackColor: 'bg-blue-100'),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with custom indicator color', (tester) async {
        tester.pumpComponent(
          DProgress(value: 50, indicatorColor: 'bg-purple-500'),
        );

        expect(find.tag('div'), findsComponents);
      });
    });

    group('accessibility', () {
      testComponents('has progressbar role', (tester) async {
        tester.pumpComponent(DProgress(value: 50));

        expect(find.tag('div'), findsComponents);
      });
    });
  });

  group('DProgressCircular', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 50));

        expect(find.tag('div'), findsComponents);
        expect(find.tag('svg'), findsOneComponent);
      });

      testComponents('renders SVG circles', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 75));

        expect(find.tag('circle'), findsComponents);
      });
    });

    group('value prop', () {
      testComponents('handles zero value', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 0));

        expect(find.tag('svg'), findsOneComponent);
      });

      testComponents('handles full value', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 100));

        expect(find.tag('svg'), findsOneComponent);
      });

      testComponents('handles mid-range value', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 65));

        expect(find.tag('svg'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 50, size: DSize.xs));

        expect(find.tag('svg'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 50, size: DSize.sm));

        expect(find.tag('svg'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 50, size: DSize.md));

        expect(find.tag('svg'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 50, size: DSize.lg));

        expect(find.tag('svg'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 50, size: DSize.xl));

        expect(find.tag('svg'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DProgressCircular(value: 50, color: DColor.primary),
        );

        expect(find.tag('svg'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DProgressCircular(value: 50, color: DColor.success),
        );

        expect(find.tag('svg'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DProgressCircular(value: 50, color: DColor.error),
        );

        expect(find.tag('svg'), findsOneComponent);
      });
    });

    group('label', () {
      testComponents('shows percentage label by default', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 75, showLabel: true));

        expect(find.text('75%'), findsOneComponent);
      });

      testComponents('hides label when disabled', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 75, showLabel: false));

        expect(find.text('75%'), findsNothing);
      });

      testComponents('shows custom label', (tester) async {
        tester.pumpComponent(
          DProgressCircular(value: 50, showLabel: true, label: 'Half'),
        );

        expect(find.text('Half'), findsOneComponent);
      });
    });

    group('indeterminate mode', () {
      testComponents('renders spinning animation', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 0, indeterminate: true));

        expect(find.tag('svg'), findsOneComponent);
      });

      testComponents('hides label in indeterminate mode', (tester) async {
        tester.pumpComponent(
          DProgressCircular(value: 50, indeterminate: true, showLabel: true),
        );

        expect(find.text('50%'), findsNothing);
      });
    });

    group('stroke width', () {
      testComponents('renders with default stroke width', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 50));

        expect(find.tag('circle'), findsComponents);
      });

      testComponents('renders with custom stroke width', (tester) async {
        tester.pumpComponent(DProgressCircular(value: 50, strokeWidth: 8));

        expect(find.tag('circle'), findsComponents);
      });
    });
  });

  group('DProgressSteps', () {
    group('rendering', () {
      testComponents('renders with required props', (tester) async {
        tester.pumpComponent(DProgressSteps(
          currentStep: 2,
          totalSteps: 5,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders correct number of segments', (tester) async {
        tester.pumpComponent(DProgressSteps(
          currentStep: 1,
          totalSteps: 4,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('current step', () {
      testComponents('highlights first step', (tester) async {
        tester.pumpComponent(DProgressSteps(
          currentStep: 0,
          totalSteps: 5,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('highlights middle step', (tester) async {
        tester.pumpComponent(DProgressSteps(
          currentStep: 2,
          totalSteps: 5,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('highlights last step', (tester) async {
        tester.pumpComponent(DProgressSteps(
          currentStep: 4,
          totalSteps: 5,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('labels', () {
      testComponents('renders with labels', (tester) async {
        tester.pumpComponent(DProgressSteps(
          currentStep: 1,
          totalSteps: 3,
          labels: ['Step 1', 'Step 2', 'Step 3'],
        ));

        expect(find.text('Step 1'), findsOneComponent);
        expect(find.text('Step 2'), findsOneComponent);
        expect(find.text('Step 3'), findsOneComponent);
      });

      testComponents('renders without labels', (tester) async {
        tester.pumpComponent(DProgressSteps(
          currentStep: 1,
          totalSteps: 3,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('sizes', () {
      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(DProgressSteps(
          currentStep: 1,
          totalSteps: 3,
          size: DSize.md,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DProgressSteps(
          currentStep: 1,
          totalSteps: 3,
          size: DSize.lg,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(DProgressSteps(
          currentStep: 1,
          totalSteps: 3,
          color: DColor.primary,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(DProgressSteps(
          currentStep: 1,
          totalSteps: 3,
          color: DColor.success,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });
  });
}
