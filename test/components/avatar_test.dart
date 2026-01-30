import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/avatar.dart';

void main() {
  group('DAvatar', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DAvatar());

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with image src', (tester) async {
        tester.pumpComponent(
          DAvatar(src: 'https://example.com/avatar.jpg', alt: 'User Avatar'),
        );

        expect(find.tag('img'), findsOneComponent);
      });

      testComponents('renders with text initials', (tester) async {
        tester.pumpComponent(DAvatar(text: 'John Doe'));

        expect(find.text('JO'), findsOneComponent);
      });

      testComponents('truncates text to 2 characters', (tester) async {
        tester.pumpComponent(DAvatar(text: 'ABC'));

        expect(find.text('AB'), findsOneComponent);
      });

      testComponents('handles single character text', (tester) async {
        tester.pumpComponent(DAvatar(text: 'A'));

        expect(find.text('A'), findsOneComponent);
      });

      testComponents('uppercases text', (tester) async {
        tester.pumpComponent(DAvatar(text: 'ab'));

        expect(find.text('AB'), findsOneComponent);
      });

      testComponents('renders with icon', (tester) async {
        tester.pumpComponent(
          DAvatar(icon: span([Component.text('*')])),
        );

        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders default placeholder when no content', (tester) async {
        tester.pumpComponent(DAvatar());

        expect(find.text('?'), findsOneComponent);
      });

      testComponents('prioritizes src over text and icon', (tester) async {
        tester.pumpComponent(
          DAvatar(
            src: 'https://example.com/avatar.jpg',
            text: 'JD',
            icon: span([Component.text('*')]),
          ),
        );

        expect(find.tag('img'), findsOneComponent);
        expect(find.text('JD'), findsNothing);
        expect(find.text('*'), findsNothing);
      });

      testComponents('prioritizes icon over text when no src', (tester) async {
        tester.pumpComponent(
          DAvatar(
            text: 'JD',
            icon: span([Component.text('*')]),
          ),
        );

        expect(find.text('*'), findsOneComponent);
        expect(find.text('JD'), findsNothing);
      });
    });

    group('sizes', () {
      testComponents('renders xxxs size', (tester) async {
        tester.pumpComponent(DAvatar(size: DAvatarSize.xxxs, text: 'A'));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders xxs size', (tester) async {
        tester.pumpComponent(DAvatar(size: DAvatarSize.xxs, text: 'A'));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(DAvatar(size: DAvatarSize.xs, text: 'A'));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(DAvatar(size: DAvatarSize.sm, text: 'A'));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(DAvatar(size: DAvatarSize.md, text: 'A'));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DAvatar(size: DAvatarSize.lg, text: 'A'));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(DAvatar(size: DAvatarSize.xl, text: 'A'));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders xxl size', (tester) async {
        tester.pumpComponent(DAvatar(size: DAvatarSize.xxl, text: 'A'));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders xxxl size', (tester) async {
        tester.pumpComponent(DAvatar(size: DAvatarSize.xxxl, text: 'A'));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('chip', () {
      testComponents('renders chip when chipColor is set', (tester) async {
        tester.pumpComponent(DAvatar(text: 'JD', chipColor: true));

        expect(find.tag('span'), findsComponents);
      });

      testComponents('renders chip with text', (tester) async {
        tester.pumpComponent(DAvatar(text: 'JD', chipText: '5'));

        expect(find.text('5'), findsOneComponent);
      });

      testComponents('does not render chip when neither chipColor nor chipText set', (tester) async {
        tester.pumpComponent(DAvatar(text: 'JD'));

        // Only text should be present, no chip span
        expect(find.text('JD'), findsOneComponent);
      });

      testComponents('renders chip at topRight position (default)', (tester) async {
        tester.pumpComponent(
          DAvatar(text: 'JD', chipColor: true, chipPosition: DAvatarChipPosition.topRight),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders chip at bottomRight position', (tester) async {
        tester.pumpComponent(
          DAvatar(text: 'JD', chipColor: true, chipPosition: DAvatarChipPosition.bottomRight),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders chip at topLeft position', (tester) async {
        tester.pumpComponent(
          DAvatar(text: 'JD', chipColor: true, chipPosition: DAvatarChipPosition.topLeft),
        );

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders chip at bottomLeft position', (tester) async {
        tester.pumpComponent(
          DAvatar(text: 'JD', chipColor: true, chipPosition: DAvatarChipPosition.bottomLeft),
        );

        expect(find.tag('div'), findsComponents);
      });
    });
  });

  group('DAvatarGroup', () {
    testComponents('renders multiple avatars', (tester) async {
      tester.pumpComponent(
        DAvatarGroup(
          avatars: [
            DAvatar(text: 'A'),
            DAvatar(text: 'B'),
            DAvatar(text: 'C'),
          ],
        ),
      );

      expect(find.text('A'), findsOneComponent);
      expect(find.text('B'), findsOneComponent);
      expect(find.text('C'), findsOneComponent);
    });

    testComponents('limits visible avatars to max', (tester) async {
      tester.pumpComponent(
        DAvatarGroup(
          max: 2,
          avatars: [
            DAvatar(text: 'A'),
            DAvatar(text: 'B'),
            DAvatar(text: 'C'),
            DAvatar(text: 'D'),
          ],
        ),
      );

      expect(find.text('A'), findsOneComponent);
      expect(find.text('B'), findsOneComponent);
      expect(find.text('C'), findsNothing);
      expect(find.text('D'), findsNothing);
      expect(find.text('+2'), findsOneComponent);
    });

    testComponents('does not show remainder when all avatars visible', (tester) async {
      tester.pumpComponent(
        DAvatarGroup(
          max: 5,
          avatars: [
            DAvatar(text: 'A'),
            DAvatar(text: 'B'),
          ],
        ),
      );

      expect(find.text('A'), findsOneComponent);
      expect(find.text('B'), findsOneComponent);
      expect(find.text('+'), findsNothing);
    });

    testComponents('renders with default max of 4', (tester) async {
      tester.pumpComponent(
        DAvatarGroup(
          avatars: [
            DAvatar(text: 'A'),
            DAvatar(text: 'B'),
            DAvatar(text: 'C'),
            DAvatar(text: 'D'),
            DAvatar(text: 'E'),
            DAvatar(text: 'F'),
          ],
        ),
      );

      expect(find.text('A'), findsOneComponent);
      expect(find.text('B'), findsOneComponent);
      expect(find.text('C'), findsOneComponent);
      expect(find.text('D'), findsOneComponent);
      expect(find.text('E'), findsNothing);
      expect(find.text('F'), findsNothing);
      expect(find.text('+2'), findsOneComponent);
    });

    testComponents('renders with custom size', (tester) async {
      tester.pumpComponent(
        DAvatarGroup(
          size: DAvatarSize.lg,
          avatars: [
            DAvatar(text: 'A'),
            DAvatar(text: 'B'),
          ],
        ),
      );

      expect(find.tag('div'), findsComponents);
    });

    testComponents('renders empty group', (tester) async {
      tester.pumpComponent(
        DAvatarGroup(avatars: []),
      );

      expect(find.tag('div'), findsOneComponent);
    });
  });
}
