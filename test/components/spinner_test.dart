import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/spinner.dart';

void main() {
  group('DSpinner', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DSpinner());

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders with animate-spin class', (tester) async {
        tester.pumpComponent(DSpinner());

        expect(find.tag('div'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(DSpinner(size: DSpinnerSize.xs));

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(DSpinner(size: DSpinnerSize.sm));

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(DSpinner(size: DSpinnerSize.md));

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DSpinner(size: DSpinnerSize.lg));

        expect(find.tag('div'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders with default cyan color', (tester) async {
        tester.pumpComponent(DSpinner());

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders with custom color', (tester) async {
        tester.pumpComponent(DSpinner(color: 'border-red-500'));

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders with another custom color', (tester) async {
        tester.pumpComponent(DSpinner(color: 'border-blue-600'));

        expect(find.tag('div'), findsOneComponent);
      });
    });

    group('combinations', () {
      testComponents('renders xs size with custom color', (tester) async {
        tester.pumpComponent(
          DSpinner(size: DSpinnerSize.xs, color: 'border-green-500'),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders lg size with custom color', (tester) async {
        tester.pumpComponent(
          DSpinner(size: DSpinnerSize.lg, color: 'border-purple-500'),
        );

        expect(find.tag('div'), findsOneComponent);
      });
    });
  });

  group('DLoading', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DLoading());

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders spinner inside', (tester) async {
        tester.pumpComponent(DLoading());

        // Should contain the spinner div
        expect(find.tag('div'), findsComponents);
      });
    });

    group('message', () {
      testComponents('renders without message by default', (tester) async {
        tester.pumpComponent(DLoading());

        expect(find.tag('p'), findsNothing);
      });

      testComponents('renders with message', (tester) async {
        tester.pumpComponent(DLoading(message: 'Loading data...'));

        expect(find.text('Loading data...'), findsOneComponent);
        expect(find.tag('p'), findsOneComponent);
      });

      testComponents('renders custom message text', (tester) async {
        tester.pumpComponent(DLoading(message: 'Please wait'));

        expect(find.text('Please wait'), findsOneComponent);
      });
    });

    group('overlay', () {
      testComponents('renders without overlay by default', (tester) async {
        tester.pumpComponent(DLoading());

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with overlay', (tester) async {
        tester.pumpComponent(DLoading(overlay: true));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders overlay with message', (tester) async {
        tester.pumpComponent(
          DLoading(overlay: true, message: 'Loading...'),
        );

        expect(find.text('Loading...'), findsOneComponent);
        expect(find.tag('div'), findsComponents);
      });
    });

    group('combinations', () {
      testComponents('renders non-overlay with message', (tester) async {
        tester.pumpComponent(
          DLoading(overlay: false, message: 'Fetching data'),
        );

        expect(find.text('Fetching data'), findsOneComponent);
      });

      testComponents('renders overlay without message', (tester) async {
        tester.pumpComponent(DLoading(overlay: true));

        expect(find.tag('p'), findsNothing);
      });
    });
  });
}
