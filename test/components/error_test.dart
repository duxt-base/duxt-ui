import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/content/error.dart';
import 'package:duxt_ui/src/theme/variants.dart';

void main() {
  group('DError', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(
          DError(),
        );

        // Default title for error severity
        expect(find.text('Something went wrong'), findsOneComponent);
        expect(find.tag('div'), findsComponents);
        expect(find.tag('h3'), findsOneComponent);
      });

      testComponents('renders with custom title', (tester) async {
        tester.pumpComponent(
          DError(title: 'Custom Error Title'),
        );

        expect(find.text('Custom Error Title'), findsOneComponent);
      });

      testComponents('renders with description', (tester) async {
        tester.pumpComponent(
          DError(
            title: 'Error',
            description: 'Something unexpected happened',
          ),
        );

        expect(find.text('Error'), findsOneComponent);
        expect(find.text('Something unexpected happened'), findsOneComponent);
      });

      testComponents('renders with custom icon string', (tester) async {
        tester.pumpComponent(
          DError(
            icon: '🔥',
            title: 'Fire Error',
          ),
        );

        expect(find.text('🔥'), findsOneComponent);
        expect(find.text('Fire Error'), findsOneComponent);
      });

      testComponents('renders with icon component', (tester) async {
        tester.pumpComponent(
          DError(
            iconComponent: span([Component.text('Custom Error Icon')]),
            title: 'With Icon Component',
          ),
        );

        expect(find.text('Custom Error Icon'), findsOneComponent);
        expect(find.text('With Icon Component'), findsOneComponent);
      });

      testComponents('renders with error code', (tester) async {
        tester.pumpComponent(
          DError(
            title: 'Error',
            errorCode: 'ERR_001',
          ),
        );

        expect(find.text('Error'), findsOneComponent);
        expect(find.text('Error code: ERR_001'), findsOneComponent);
      });

      testComponents('renders with action', (tester) async {
        tester.pumpComponent(
          DError(
            title: 'Error',
            action: button([Component.text('Go Back')]),
          ),
        );

        expect(find.text('Error'), findsOneComponent);
        expect(find.text('Go Back'), findsOneComponent);
      });

      testComponents('renders with onRetry callback', (tester) async {
        tester.pumpComponent(
          DError(
            title: 'Error',
            onRetry: () {},
          ),
        );

        expect(find.text('Error'), findsOneComponent);
        expect(find.text('Try again'), findsOneComponent);
      });

      testComponents('renders with children', (tester) async {
        tester.pumpComponent(
          DError(
            title: 'Error',
            children: [
              p([Component.text('Additional error details')]),
            ],
          ),
        );

        expect(find.text('Error'), findsOneComponent);
        expect(find.text('Additional error details'), findsOneComponent);
      });

      testComponents('renders with padded=false', (tester) async {
        tester.pumpComponent(
          DError(
            title: 'No padding',
            padded: false,
          ),
        );

        expect(find.text('No padding'), findsOneComponent);
      });
    });

    group('severity levels', () {
      testComponents('renders warning severity', (tester) async {
        tester.pumpComponent(
          DError(severity: DErrorSeverity.warning),
        );

        // Default title for warning severity
        expect(find.text('Warning'), findsOneComponent);
      });

      testComponents('renders error severity (default)', (tester) async {
        tester.pumpComponent(
          DError(severity: DErrorSeverity.error),
        );

        // Default title for error severity
        expect(find.text('Something went wrong'), findsOneComponent);
      });

      testComponents('renders fatal severity', (tester) async {
        tester.pumpComponent(
          DError(severity: DErrorSeverity.fatal),
        );

        // Default title for fatal severity
        expect(find.text('Critical error'), findsOneComponent);
      });

      testComponents('custom title overrides default for warning', (tester) async {
        tester.pumpComponent(
          DError(
            severity: DErrorSeverity.warning,
            title: 'Custom Warning',
          ),
        );

        expect(find.text('Custom Warning'), findsOneComponent);
      });

      testComponents('custom title overrides default for fatal', (tester) async {
        tester.pumpComponent(
          DError(
            severity: DErrorSeverity.fatal,
            title: 'Custom Fatal',
          ),
        );

        expect(find.text('Custom Fatal'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          DError(
            size: DSize.xs,
            title: 'XS Error',
          ),
        );

        expect(find.text('XS Error'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DError(
            size: DSize.sm,
            title: 'SM Error',
          ),
        );

        expect(find.text('SM Error'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DError(
            size: DSize.md,
            title: 'MD Error',
          ),
        );

        expect(find.text('MD Error'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DError(
            size: DSize.lg,
            title: 'LG Error',
          ),
        );

        expect(find.text('LG Error'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          DError(
            size: DSize.xl,
            title: 'XL Error',
          ),
        );

        expect(find.text('XL Error'), findsOneComponent);
      });
    });

    group('integration', () {
      testComponents('renders complete error state', (tester) async {
        tester.pumpComponent(
          DError(
            icon: '⚠️',
            title: 'Payment Failed',
            description: 'Your payment could not be processed',
            errorCode: 'PAY_001',
            severity: DErrorSeverity.error,
            size: DSize.lg,
            onRetry: () {},
            action: button([Component.text('Contact Support')]),
          ),
        );

        expect(find.text('⚠️'), findsOneComponent);
        expect(find.text('Payment Failed'), findsOneComponent);
        expect(find.text('Your payment could not be processed'), findsOneComponent);
        expect(find.text('Error code: PAY_001'), findsOneComponent);
        expect(find.text('Try again'), findsOneComponent);
        expect(find.text('Contact Support'), findsOneComponent);
      });
    });
  });

  group('DError404', () {
    testComponents('renders default 404 state', (tester) async {
      tester.pumpComponent(
        DError404(),
      );

      expect(find.text('Page not found'), findsOneComponent);
      expect(find.text('The page you are looking for does not exist or has been moved.'), findsOneComponent);
      expect(find.text('Error code: 404'), findsOneComponent);
    });

    testComponents('renders with action', (tester) async {
      tester.pumpComponent(
        DError404(
          action: button([Component.text('Go Home')]),
        ),
      );

      expect(find.text('Page not found'), findsOneComponent);
      expect(find.text('Go Home'), findsOneComponent);
    });
  });

  group('DError500', () {
    testComponents('renders default 500 state', (tester) async {
      tester.pumpComponent(
        DError500(),
      );

      expect(find.text('Server error'), findsOneComponent);
      expect(find.text('An unexpected error occurred. Please try again later.'), findsOneComponent);
      expect(find.text('Error code: 500'), findsOneComponent);
    });

    testComponents('renders with retry callback', (tester) async {
      tester.pumpComponent(
        DError500(onRetry: () {}),
      );

      expect(find.text('Server error'), findsOneComponent);
      expect(find.text('Try again'), findsOneComponent);
    });

    testComponents('renders with action', (tester) async {
      tester.pumpComponent(
        DError500(
          action: button([Component.text('Report Issue')]),
        ),
      );

      expect(find.text('Server error'), findsOneComponent);
      expect(find.text('Report Issue'), findsOneComponent);
    });

    testComponents('renders with retry and action', (tester) async {
      tester.pumpComponent(
        DError500(
          onRetry: () {},
          action: button([Component.text('Home')]),
        ),
      );

      expect(find.text('Server error'), findsOneComponent);
      expect(find.text('Try again'), findsOneComponent);
      expect(find.text('Home'), findsOneComponent);
    });
  });

  group('DErrorNetwork', () {
    testComponents('renders default network error state', (tester) async {
      tester.pumpComponent(
        DErrorNetwork(),
      );

      expect(find.text('Network error'), findsOneComponent);
      expect(find.text('Unable to connect. Please check your internet connection and try again.'), findsOneComponent);
    });

    testComponents('renders with retry callback', (tester) async {
      tester.pumpComponent(
        DErrorNetwork(onRetry: () {}),
      );

      expect(find.text('Network error'), findsOneComponent);
      expect(find.text('Try again'), findsOneComponent);
    });
  });
}
