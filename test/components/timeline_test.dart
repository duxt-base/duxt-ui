import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/data/timeline.dart';
import 'package:duxt_ui/src/theme/colors.dart';
import 'package:duxt_ui/src/theme/variants.dart';

void main() {
  group('DTimelineItem', () {
    group('construction', () {
      test('creates item with required title', () {
        final item = DTimelineItem(title: 'Test Event');

        expect(item.title, equals('Test Event'));
        expect(item.status, equals(DTimelineStatus.pending));
      });

      test('creates item with all properties', () {
        final item = DTimelineItem(
          id: 'item-1',
          title: 'Event',
          description: 'Description text',
          icon: 'i-lucide-check',
          time: '2024-01-01',
          status: DTimelineStatus.completed,
          color: DColor.success,
        );

        expect(item.id, equals('item-1'));
        expect(item.title, equals('Event'));
        expect(item.description, equals('Description text'));
        expect(item.icon, equals('i-lucide-check'));
        expect(item.time, equals('2024-01-01'));
        expect(item.status, equals(DTimelineStatus.completed));
        expect(item.color, equals(DColor.success));
      });
    });
  });

  group('DTimeline', () {
    group('rendering', () {
      testComponents('renders with required items', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'First Event'),
            DTimelineItem(title: 'Second Event'),
          ],
        ));

        expect(find.tag('div'), findsComponents);
        expect(find.text('First Event'), findsOneComponent);
        expect(find.text('Second Event'), findsOneComponent);
      });

      testComponents('renders empty timeline', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [],
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders single item', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [DTimelineItem(title: 'Only Event')],
        ));

        expect(find.text('Only Event'), findsOneComponent);
      });
    });

    group('orientation', () {
      testComponents('renders vertical orientation (default)', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Event 1'),
            DTimelineItem(title: 'Event 2'),
          ],
          orientation: DTimelineOrientation.vertical,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders horizontal orientation', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Event 1'),
            DTimelineItem(title: 'Event 2'),
          ],
          orientation: DTimelineOrientation.horizontal,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('item status', () {
      testComponents('renders pending status', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Pending', status: DTimelineStatus.pending),
          ],
        ));

        expect(find.text('Pending'), findsOneComponent);
      });

      testComponents('renders current status', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Current', status: DTimelineStatus.current),
          ],
        ));

        expect(find.text('Current'), findsOneComponent);
      });

      testComponents('renders completed status', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Completed', status: DTimelineStatus.completed),
          ],
        ));

        expect(find.text('Completed'), findsOneComponent);
      });

      testComponents('renders mixed statuses', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Done', status: DTimelineStatus.completed),
            DTimelineItem(title: 'Now', status: DTimelineStatus.current),
            DTimelineItem(title: 'Later', status: DTimelineStatus.pending),
          ],
        ));

        expect(find.text('Done'), findsOneComponent);
        expect(find.text('Now'), findsOneComponent);
        expect(find.text('Later'), findsOneComponent);
      });
    });

    group('item description', () {
      testComponents('renders description when provided', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(
              title: 'Event',
              description: 'Detailed description here',
            ),
          ],
        ));

        expect(find.text('Detailed description here'), findsOneComponent);
      });

      testComponents('renders without description', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Event'),
          ],
        ));

        expect(find.text('Event'), findsOneComponent);
      });
    });

    group('item time', () {
      testComponents('renders time when provided', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Event', time: '10:30 AM'),
          ],
        ));

        expect(find.text('10:30 AM'), findsOneComponent);
      });

      testComponents('renders date as time', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Event', time: 'Jan 15, 2024'),
          ],
        ));

        expect(find.text('Jan 15, 2024'), findsOneComponent);
      });
    });

    group('item icon', () {
      testComponents('renders icon when provided', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Event', icon: 'i-lucide-check'),
          ],
        ));

        expect(find.tag('i'), findsComponents);
      });

      testComponents('renders dot when no icon', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Event'),
          ],
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('connectors', () {
      testComponents('shows connectors by default', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Event 1'),
            DTimelineItem(title: 'Event 2'),
          ],
          showConnectors: true,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('hides connectors when disabled', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Event 1'),
            DTimelineItem(title: 'Event 2'),
          ],
          showConnectors: false,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [DTimelineItem(title: 'Event')],
          size: DSize.xs,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [DTimelineItem(title: 'Event')],
          size: DSize.sm,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [DTimelineItem(title: 'Event')],
          size: DSize.md,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [DTimelineItem(title: 'Event')],
          size: DSize.lg,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [DTimelineItem(title: 'Event')],
          size: DSize.xl,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [DTimelineItem(title: 'Event')],
          color: DColor.primary,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [DTimelineItem(title: 'Event')],
          color: DColor.success,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [DTimelineItem(title: 'Event')],
          color: DColor.error,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('item color overrides default', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(title: 'Event', color: DColor.warning),
          ],
          color: DColor.primary,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('click handler', () {
      testComponents('renders clickable items when handler provided',
          (tester) async {
        tester.pumpComponent(DTimeline(
          items: [DTimelineItem(title: 'Clickable')],
          onItemClick: (item, index) {},
        ));

        expect(find.tag('button'), findsComponents);
      });

      testComponents('renders non-clickable items by default', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [DTimelineItem(title: 'Static')],
        ));

        expect(find.text('Static'), findsOneComponent);
      });
    });

    group('custom content', () {
      testComponents('renders custom content component', (tester) async {
        tester.pumpComponent(DTimeline(
          items: [
            DTimelineItem(
              title: 'Event',
              content: span([Component.text('Custom Content')]),
            ),
          ],
        ));

        expect(find.text('Custom Content'), findsOneComponent);
      });
    });
  });

  group('DTimelineSimple', () {
    group('rendering', () {
      testComponents('renders with required items', (tester) async {
        tester.pumpComponent(DTimelineSimple(
          items: ['Step 1', 'Step 2', 'Step 3'],
        ));

        expect(find.tag('ul'), findsOneComponent);
        expect(find.text('Step 1'), findsOneComponent);
        expect(find.text('Step 2'), findsOneComponent);
        expect(find.text('Step 3'), findsOneComponent);
      });

      testComponents('renders empty list', (tester) async {
        tester.pumpComponent(DTimelineSimple(
          items: [],
        ));

        expect(find.tag('ul'), findsOneComponent);
      });

      testComponents('renders single item', (tester) async {
        tester.pumpComponent(DTimelineSimple(
          items: ['Only Step'],
        ));

        expect(find.text('Only Step'), findsOneComponent);
      });
    });

    group('active index', () {
      testComponents('highlights active item', (tester) async {
        tester.pumpComponent(DTimelineSimple(
          items: ['Step 1', 'Step 2', 'Step 3'],
          activeIndex: 1,
        ));

        expect(find.text('Step 2'), findsOneComponent);
      });

      testComponents('highlights first item', (tester) async {
        tester.pumpComponent(DTimelineSimple(
          items: ['Step 1', 'Step 2'],
          activeIndex: 0,
        ));

        expect(find.text('Step 1'), findsOneComponent);
      });

      testComponents('highlights last item', (tester) async {
        tester.pumpComponent(DTimelineSimple(
          items: ['Step 1', 'Step 2', 'Step 3'],
          activeIndex: 2,
        ));

        expect(find.text('Step 3'), findsOneComponent);
      });

      testComponents('renders without active index', (tester) async {
        tester.pumpComponent(DTimelineSimple(
          items: ['Step 1', 'Step 2'],
        ));

        expect(find.tag('ul'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(DTimelineSimple(
          items: ['Step 1'],
          color: DColor.primary,
        ));

        expect(find.tag('ul'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(DTimelineSimple(
          items: ['Step 1'],
          color: DColor.success,
        ));

        expect(find.tag('ul'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(DTimelineSimple(
          items: ['Step 1'],
          color: DColor.warning,
        ));

        expect(find.tag('ul'), findsOneComponent);
      });
    });
  });
}
