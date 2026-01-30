import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/content/skeleton.dart';

void main() {
  group('DSkeleton', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(
          DSkeleton(),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders with custom width', (tester) async {
        tester.pumpComponent(
          DSkeleton(width: '200px'),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders with custom height', (tester) async {
        tester.pumpComponent(
          DSkeleton(height: '100px'),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders with custom width and height', (tester) async {
        tester.pumpComponent(
          DSkeleton(
            width: '150px',
            height: '50px',
          ),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders with custom classes', (tester) async {
        tester.pumpComponent(
          DSkeleton(classes: 'my-custom-class'),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders with animate=false', (tester) async {
        tester.pumpComponent(
          DSkeleton(animate: false),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders with animate=true (default)', (tester) async {
        tester.pumpComponent(
          DSkeleton(animate: true),
        );

        expect(find.tag('div'), findsOneComponent);
      });
    });

    group('variants', () {
      testComponents('renders text variant (default)', (tester) async {
        tester.pumpComponent(
          DSkeleton(variant: DSkeletonVariant.text),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders circular variant', (tester) async {
        tester.pumpComponent(
          DSkeleton(variant: DSkeletonVariant.circular),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('renders rectangular variant', (tester) async {
        tester.pumpComponent(
          DSkeleton(variant: DSkeletonVariant.rectangular),
        );

        expect(find.tag('div'), findsOneComponent);
      });
    });

    group('named constructors', () {
      testComponents('DSkeleton.text renders correctly', (tester) async {
        tester.pumpComponent(
          DSkeleton.text(),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('DSkeleton.text with width', (tester) async {
        tester.pumpComponent(
          DSkeleton.text(width: '80%'),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('DSkeleton.text with animate=false', (tester) async {
        tester.pumpComponent(
          DSkeleton.text(animate: false),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('DSkeleton.circular renders correctly', (tester) async {
        tester.pumpComponent(
          DSkeleton.circular(),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('DSkeleton.circular with custom size', (tester) async {
        tester.pumpComponent(
          DSkeleton.circular(size: '4rem'),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('DSkeleton.rectangular renders correctly', (tester) async {
        tester.pumpComponent(
          DSkeleton.rectangular(),
        );

        expect(find.tag('div'), findsOneComponent);
      });

      testComponents('DSkeleton.rectangular with dimensions', (tester) async {
        tester.pumpComponent(
          DSkeleton.rectangular(
            width: '300px',
            height: '200px',
          ),
        );

        expect(find.tag('div'), findsOneComponent);
      });
    });
  });

  group('DSkeletonGroup', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(
          DSkeletonGroup(),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders default 3 lines', (tester) async {
        tester.pumpComponent(
          DSkeletonGroup(lines: 3),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders custom number of lines', (tester) async {
        tester.pumpComponent(
          DSkeletonGroup(lines: 5),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders single line', (tester) async {
        tester.pumpComponent(
          DSkeletonGroup(lines: 1),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with custom spacing', (tester) async {
        tester.pumpComponent(
          DSkeletonGroup(spacing: '4'),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with animate=false', (tester) async {
        tester.pumpComponent(
          DSkeletonGroup(animate: false),
        );

        expect(find.tag('div'), findsComponents);
      });
    });
  });

  group('DSkeletonCard', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(
          DSkeletonCard(),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with showImage=true (default)', (tester) async {
        tester.pumpComponent(
          DSkeletonCard(showImage: true),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with showImage=false', (tester) async {
        tester.pumpComponent(
          DSkeletonCard(showImage: false),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with showAvatar=true', (tester) async {
        tester.pumpComponent(
          DSkeletonCard(showAvatar: true),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with showAvatar=false (default)', (tester) async {
        tester.pumpComponent(
          DSkeletonCard(showAvatar: false),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with custom textLines', (tester) async {
        tester.pumpComponent(
          DSkeletonCard(textLines: 5),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with animate=false', (tester) async {
        tester.pumpComponent(
          DSkeletonCard(animate: false),
        );

        expect(find.tag('div'), findsComponents);
      });
    });

    group('combinations', () {
      testComponents('renders with image and avatar', (tester) async {
        tester.pumpComponent(
          DSkeletonCard(
            showImage: true,
            showAvatar: true,
          ),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders without image but with avatar', (tester) async {
        tester.pumpComponent(
          DSkeletonCard(
            showImage: false,
            showAvatar: true,
          ),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with all options', (tester) async {
        tester.pumpComponent(
          DSkeletonCard(
            showImage: true,
            showAvatar: true,
            textLines: 4,
            animate: true,
          ),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders minimal card (no image, no avatar, 1 line)', (tester) async {
        tester.pumpComponent(
          DSkeletonCard(
            showImage: false,
            showAvatar: false,
            textLines: 1,
          ),
        );

        expect(find.tag('div'), findsComponents);
      });
    });
  });

  group('skeleton integration', () {
    testComponents('renders multiple skeleton types together', (tester) async {
      tester.pumpComponent(
        div([
          DSkeleton.circular(),
          DSkeletonGroup(lines: 2),
          DSkeleton.rectangular(width: '100%', height: '100px'),
        ]),
      );

      expect(find.tag('div'), findsComponents);
    });

    testComponents('renders skeleton card with nested components', (tester) async {
      tester.pumpComponent(
        div(classes: 'grid grid-cols-2 gap-4', [
          DSkeletonCard(),
          DSkeletonCard(showImage: false, showAvatar: true),
        ]),
      );

      expect(find.tag('div'), findsComponents);
    });
  });
}
