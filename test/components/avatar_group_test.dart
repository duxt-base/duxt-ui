import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/data/avatar_group.dart';
import 'package:duxt_ui/src/components/avatar.dart';

void main() {
  group('DAvatarGroupEnhanced', () {
    group('rendering', () {
      testComponents('renders with required avatars', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [
            DAvatar(text: 'JD'),
            DAvatar(text: 'AB'),
          ],
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders empty group with no avatars', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [],
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders single avatar', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [DAvatar(text: 'JD')],
        ));

        expect(find.text('JD'), findsOneComponent);
      });
    });

    group('max prop', () {
      testComponents('limits displayed avatars based on max', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [
            DAvatar(text: 'A'),
            DAvatar(text: 'B'),
            DAvatar(text: 'C'),
            DAvatar(text: 'D'),
            DAvatar(text: 'E'),
          ],
          max: 3,
        ));

        // Should show +2 indicator
        expect(find.text('+2'), findsOneComponent);
      });

      testComponents('shows all avatars when count is less than max',
          (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [
            DAvatar(text: 'A'),
            DAvatar(text: 'B'),
          ],
          max: 4,
        ));

        expect(find.text('A'), findsOneComponent);
        expect(find.text('B'), findsOneComponent);
      });

      testComponents('default max is 4', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [
            DAvatar(text: '1'),
            DAvatar(text: '2'),
            DAvatar(text: '3'),
            DAvatar(text: '4'),
            DAvatar(text: '5'),
            DAvatar(text: '6'),
          ],
        ));

        // Default max is 4, so +2 remaining
        expect(find.text('+2'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [DAvatar(text: 'A')],
          size: DAvatarSize.xs,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [DAvatar(text: 'A')],
          size: DAvatarSize.sm,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [DAvatar(text: 'A')],
          size: DAvatarSize.md,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [DAvatar(text: 'A')],
          size: DAvatarSize.lg,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [DAvatar(text: 'A')],
          size: DAvatarSize.xl,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('reverse prop', () {
      testComponents('renders with reverse stacking order', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [
            DAvatar(text: 'A'),
            DAvatar(text: 'B'),
          ],
          reverse: true,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with normal stacking order (default)',
          (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [
            DAvatar(text: 'A'),
            DAvatar(text: 'B'),
          ],
          reverse: false,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('custom styling', () {
      testComponents('renders with custom spacing', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [DAvatar(text: 'A'), DAvatar(text: 'B')],
          spacing: '-space-x-4',
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with custom ring color', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [DAvatar(text: 'A')],
          ringColor: 'ring-blue-500',
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with custom ring width', (tester) async {
        tester.pumpComponent(DAvatarGroupEnhanced(
          avatars: [DAvatar(text: 'A')],
          ringWidth: 'ring-4',
        ));

        expect(find.tag('div'), findsComponents);
      });
    });
  });

  group('DAvatarStack', () {
    group('rendering', () {
      testComponents('renders with required avatars', (tester) async {
        tester.pumpComponent(DAvatarStack(
          avatars: [
            DAvatar(text: 'JD'),
            DAvatar(text: 'AB'),
          ],
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders vertical stack layout', (tester) async {
        tester.pumpComponent(DAvatarStack(
          avatars: [DAvatar(text: 'A')],
        ));

        expect(find.text('A'), findsOneComponent);
      });
    });

    group('max prop', () {
      testComponents('limits displayed avatars based on max', (tester) async {
        tester.pumpComponent(DAvatarStack(
          avatars: [
            DAvatar(text: 'A'),
            DAvatar(text: 'B'),
            DAvatar(text: 'C'),
            DAvatar(text: 'D'),
            DAvatar(text: 'E'),
          ],
          max: 2,
        ));

        // Should show +3 indicator
        expect(find.text('+3'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(DAvatarStack(
          avatars: [DAvatar(text: 'A')],
          size: DAvatarSize.xs,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DAvatarStack(
          avatars: [DAvatar(text: 'A')],
          size: DAvatarSize.lg,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });
  });
}
