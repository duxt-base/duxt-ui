import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/data/user.dart';
import 'package:duxt_ui/src/theme/variants.dart';

void main() {
  group('DUser', () {
    group('rendering', () {
      testComponents('renders with required name', (tester) async {
        tester.pumpComponent(DUser(name: 'John Doe'));

        expect(find.text('John Doe'), findsOneComponent);
        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders user name correctly', (tester) async {
        tester.pumpComponent(DUser(name: 'Jane Smith'));

        expect(find.text('Jane Smith'), findsOneComponent);
      });
    });

    group('description', () {
      testComponents('renders description when provided', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          description: 'Software Engineer',
        ));

        expect(find.text('John Doe'), findsOneComponent);
        expect(find.text('Software Engineer'), findsOneComponent);
      });

      testComponents('renders without description', (tester) async {
        tester.pumpComponent(DUser(name: 'John Doe'));

        expect(find.text('John Doe'), findsOneComponent);
      });

      testComponents('renders email as description', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          description: 'john@example.com',
        ));

        expect(find.text('john@example.com'), findsOneComponent);
      });
    });

    group('avatar', () {
      testComponents('renders avatar with image', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          avatarSrc: 'https://example.com/avatar.jpg',
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders avatar with initials', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          avatarInitials: 'JD',
        ));

        expect(find.text('JD'), findsOneComponent);
      });

      testComponents('generates initials from name', (tester) async {
        tester.pumpComponent(DUser(name: 'John Doe'));

        // Should generate 'JD' from 'John Doe'
        expect(find.text('JD'), findsOneComponent);
      });

      testComponents('generates single initial for single name',
          (tester) async {
        tester.pumpComponent(DUser(name: 'John'));

        expect(find.text('J'), findsOneComponent);
      });

      testComponents('renders avatar with custom color', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          avatarColor: 'bg-blue-500',
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(DUser(name: 'John', size: DSize.xs));

        expect(find.text('John'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(DUser(name: 'John', size: DSize.sm));

        expect(find.text('John'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(DUser(name: 'John', size: DSize.md));

        expect(find.text('John'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DUser(name: 'John', size: DSize.lg));

        expect(find.text('John'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(DUser(name: 'John', size: DSize.xl));

        expect(find.text('John'), findsOneComponent);
      });
    });

    group('orientation', () {
      testComponents('renders horizontal orientation (default)',
          (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          orientation: DUserOrientation.horizontal,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders vertical orientation', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          orientation: DUserOrientation.vertical,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('reverse layout', () {
      testComponents('renders with avatar on left (default)', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          reverse: false,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders with avatar on right', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          reverse: true,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('online status', () {
      testComponents('shows online indicator', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          online: true,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('shows offline indicator', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          online: false,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('hides status indicator by default', (tester) async {
        tester.pumpComponent(DUser(name: 'John Doe'));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('status text', () {
      testComponents('renders status text', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          status: 'Available',
        ));

        expect(find.text('Available'), findsOneComponent);
      });

      testComponents('status overrides description', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          description: 'Engineer',
          status: 'Away',
        ));

        expect(find.text('Away'), findsOneComponent);
      });
    });

    group('click handler', () {
      testComponents('renders as button when onClick provided', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          onClick: () {},
        ));

        expect(find.tag('button'), findsComponents);
      });

      testComponents('renders as div when no onClick', (tester) async {
        tester.pumpComponent(DUser(name: 'John Doe'));

        expect(find.text('John Doe'), findsOneComponent);
      });
    });

    group('actions', () {
      testComponents('renders action buttons', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          actions: [
            span([Component.text('Action')]),
          ],
        ));

        expect(find.text('Action'), findsOneComponent);
      });

      testComponents('renders multiple actions', (tester) async {
        tester.pumpComponent(DUser(
          name: 'John Doe',
          actions: [
            span([Component.text('Edit')]),
            span([Component.text('Delete')]),
          ],
        ));

        expect(find.text('Edit'), findsOneComponent);
        expect(find.text('Delete'), findsOneComponent);
      });
    });
  });

  group('DUserCard', () {
    group('rendering', () {
      testComponents('renders with required name', (tester) async {
        tester.pumpComponent(DUserCard(name: 'John Doe'));

        expect(find.text('John Doe'), findsOneComponent);
        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders card structure', (tester) async {
        tester.pumpComponent(DUserCard(name: 'John Doe'));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('description', () {
      testComponents('renders description', (tester) async {
        tester.pumpComponent(DUserCard(
          name: 'John Doe',
          description: 'Product Manager',
        ));

        expect(find.text('Product Manager'), findsOneComponent);
      });
    });

    group('avatar', () {
      testComponents('renders avatar image', (tester) async {
        tester.pumpComponent(DUserCard(
          name: 'John Doe',
          avatarSrc: 'https://example.com/avatar.jpg',
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders avatar initials', (tester) async {
        tester.pumpComponent(DUserCard(
          name: 'John Doe',
          avatarInitials: 'JD',
        ));

        expect(find.text('JD'), findsOneComponent);
      });
    });

    group('custom content', () {
      testComponents('renders custom content', (tester) async {
        tester.pumpComponent(DUserCard(
          name: 'John Doe',
          content: span([Component.text('Custom bio text')]),
        ));

        expect(find.text('Custom bio text'), findsOneComponent);
      });
    });

    group('actions', () {
      testComponents('renders action buttons', (tester) async {
        tester.pumpComponent(DUserCard(
          name: 'John Doe',
          actions: [
            span([Component.text('Follow')]),
            span([Component.text('Message')]),
          ],
        ));

        expect(find.text('Follow'), findsOneComponent);
        expect(find.text('Message'), findsOneComponent);
      });
    });

    group('click handler', () {
      testComponents('renders clickable card', (tester) async {
        tester.pumpComponent(DUserCard(
          name: 'John Doe',
          onClick: () {},
        ));

        expect(find.tag('button'), findsComponents);
      });

      testComponents('renders non-clickable card by default', (tester) async {
        tester.pumpComponent(DUserCard(name: 'John Doe'));

        expect(find.text('John Doe'), findsOneComponent);
      });
    });
  });

  group('DUserListItem', () {
    group('rendering', () {
      testComponents('renders with required name', (tester) async {
        tester.pumpComponent(DUserListItem(name: 'John Doe'));

        expect(find.text('John Doe'), findsOneComponent);
        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders list item structure', (tester) async {
        tester.pumpComponent(DUserListItem(name: 'John Doe'));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('description', () {
      testComponents('renders description', (tester) async {
        tester.pumpComponent(DUserListItem(
          name: 'John Doe',
          description: 'john@example.com',
        ));

        expect(find.text('john@example.com'), findsOneComponent);
      });
    });

    group('avatar', () {
      testComponents('renders avatar image', (tester) async {
        tester.pumpComponent(DUserListItem(
          name: 'John Doe',
          avatarSrc: 'https://example.com/avatar.jpg',
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders avatar initials', (tester) async {
        tester.pumpComponent(DUserListItem(
          name: 'John Doe',
          avatarInitials: 'JD',
        ));

        expect(find.text('JD'), findsOneComponent);
      });
    });

    group('trailing content', () {
      testComponents('renders trailing component', (tester) async {
        tester.pumpComponent(DUserListItem(
          name: 'John Doe',
          trailing: span([Component.text('Admin')]),
        ));

        expect(find.text('Admin'), findsOneComponent);
      });
    });

    group('selected state', () {
      testComponents('renders selected item', (tester) async {
        tester.pumpComponent(DUserListItem(
          name: 'John Doe',
          selected: true,
        ));

        expect(find.text('John Doe'), findsOneComponent);
      });

      testComponents('renders unselected item (default)', (tester) async {
        tester.pumpComponent(DUserListItem(
          name: 'John Doe',
          selected: false,
        ));

        expect(find.text('John Doe'), findsOneComponent);
      });
    });

    group('click handler', () {
      testComponents('renders clickable item', (tester) async {
        tester.pumpComponent(DUserListItem(
          name: 'John Doe',
          onClick: () {},
        ));

        expect(find.tag('button'), findsComponents);
      });

      testComponents('renders non-clickable item by default', (tester) async {
        tester.pumpComponent(DUserListItem(name: 'John Doe'));

        expect(find.text('John Doe'), findsOneComponent);
      });
    });

    group('combined props', () {
      testComponents('renders with all props', (tester) async {
        tester.pumpComponent(DUserListItem(
          name: 'John Doe',
          description: 'john@example.com',
          avatarInitials: 'JD',
          trailing: span([Component.text('Online')]),
          selected: true,
          onClick: () {},
        ));

        expect(find.text('John Doe'), findsOneComponent);
        expect(find.text('john@example.com'), findsOneComponent);
        expect(find.text('JD'), findsOneComponent);
        expect(find.text('Online'), findsOneComponent);
      });
    });
  });
}
