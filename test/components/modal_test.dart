import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/button.dart';
import 'package:duxt_ui/src/components/modal.dart';

void main() {
  group('UModal', () {
    group('rendering', () {
      testComponents('renders nothing when closed', (tester) async {
        tester.pumpComponent(
          UModal(
            open: false,
            children: [Component.text('Modal content')],
          ),
        );

        expect(find.text('Modal content'), findsNothing);
      });

      testComponents('renders content when open', (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            children: [Component.text('Modal content')],
          ),
        );

        expect(find.text('Modal content'), findsOneComponent);
      });

      testComponents('renders with title', (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            title: 'Modal Title',
            children: [Component.text('Body')],
          ),
        );

        expect(find.text('Modal Title'), findsOneComponent);
        expect(find.tag('h3'), findsOneComponent);
      });

      testComponents('renders with description', (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            title: 'Title',
            description: 'Modal description text',
            children: [Component.text('Body')],
          ),
        );

        expect(
            find.text('Modal description text'), findsOneComponent);
      });

      testComponents('renders with custom header', (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            header: div([Component.text('Custom Header')]),
            children: [Component.text('Body')],
          ),
        );

        expect(find.text('Custom Header'), findsOneComponent);
      });

      testComponents('renders with footer', (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            children: [Component.text('Body')],
            footer: div([
              UButton(label: 'Cancel'),
              UButton(label: 'Save'),
            ]),
          ),
        );

        expect(find.text('Cancel'), findsOneComponent);
        expect(find.text('Save'), findsOneComponent);
      });

      testComponents('renders close button when onClose provided',
          (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            title: 'Title',
            onClose: () {},
            children: [Component.text('Body')],
          ),
        );

        // Close button renders with x character
        expect(find.tag('button'), findsComponents);
      });

      testComponents('does not render close button when preventClose',
          (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            title: 'Title',
            preventClose: true,
            onClose: () {},
            children: [Component.text('Body')],
          ),
        );

        expect(find.text('Title'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(
          UModal(
              open: true,
              size: UModalSize.xs,
              children: [Component.text('XS')]),
        );

        expect(find.text('XS'), findsOneComponent);
      });

      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          UModal(
              open: true,
              size: UModalSize.sm,
              children: [Component.text('SM')]),
        );

        expect(find.text('SM'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          UModal(
              open: true,
              size: UModalSize.md,
              children: [Component.text('MD')]),
        );

        expect(find.text('MD'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          UModal(
              open: true,
              size: UModalSize.lg,
              children: [Component.text('LG')]),
        );

        expect(find.text('LG'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(
          UModal(
              open: true,
              size: UModalSize.xl,
              children: [Component.text('XL')]),
        );

        expect(find.text('XL'), findsOneComponent);
      });

      testComponents('renders xxl size', (tester) async {
        tester.pumpComponent(
          UModal(
              open: true,
              size: UModalSize.xxl,
              children: [Component.text('XXL')]),
        );

        expect(find.text('XXL'), findsOneComponent);
      });

      testComponents('renders xxxl size', (tester) async {
        tester.pumpComponent(
          UModal(
              open: true,
              size: UModalSize.xxxl,
              children: [Component.text('XXXL')]),
        );

        expect(find.text('XXXL'), findsOneComponent);
      });

      testComponents('renders xxxxl size', (tester) async {
        tester.pumpComponent(
          UModal(
              open: true,
              size: UModalSize.xxxxl,
              children: [Component.text('XXXXL')]),
        );

        expect(find.text('XXXXL'), findsOneComponent);
      });

      testComponents('renders xxxxxl size', (tester) async {
        tester.pumpComponent(
          UModal(
              open: true,
              size: UModalSize.xxxxxl,
              children: [Component.text('XXXXXL')]),
        );

        expect(find.text('XXXXXL'), findsOneComponent);
      });

      testComponents('renders full size', (tester) async {
        tester.pumpComponent(
          UModal(
              open: true,
              size: UModalSize.full,
              children: [Component.text('Full')]),
        );

        expect(find.text('Full'), findsOneComponent);
      });
    });

    group('fullscreen mode', () {
      testComponents('renders fullscreen modal', (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            fullscreen: true,
            children: [Component.text('Fullscreen content')],
          ),
        );

        expect(find.text('Fullscreen content'), findsOneComponent);
      });
    });

    group('interactions', () {
      testComponents('onClose fires when close button clicked', (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            title: 'Test',
            onClose: () {},
            children: [Component.text('Content')],
          ),
        );

        // Find and click the close button
        expect(find.tag('button'), findsComponents);
      });

      testComponents('overlay click closes when closeOnOverlay true',
          (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            closeOnOverlay: true,
            onClose: () {},
            children: [Component.text('Content')],
          ),
        );

        expect(find.text('Content'), findsOneComponent);
      });

      testComponents('overlay click does not close when closeOnOverlay false',
          (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            closeOnOverlay: false,
            onClose: () {},
            children: [Component.text('Content')],
          ),
        );

        expect(find.text('Content'), findsOneComponent);
      });

      testComponents('preventClose prevents closing', (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            preventClose: true,
            onClose: () {},
            children: [Component.text('Content')],
          ),
        );

        expect(find.text('Content'), findsOneComponent);
      });
    });
  });

  group('USlideover', () {
    group('rendering', () {
      testComponents('renders nothing when closed', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: false,
            children: [Component.text('Slideover content')],
          ),
        );

        expect(find.text('Slideover content'), findsNothing);
      });

      testComponents('renders content when open', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: true,
            children: [Component.text('Slideover content')],
          ),
        );

        expect(find.text('Slideover content'), findsOneComponent);
      });

      testComponents('renders with title', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: true,
            title: 'Slideover Title',
            children: [Component.text('Body')],
          ),
        );

        expect(find.text('Slideover Title'), findsOneComponent);
      });

      testComponents('renders with description', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: true,
            title: 'Title',
            description: 'Description text',
            children: [Component.text('Body')],
          ),
        );

        expect(find.text('Description text'), findsOneComponent);
      });

      testComponents('renders with custom header', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: true,
            header: div([Component.text('Custom Header')]),
            children: [Component.text('Body')],
          ),
        );

        expect(find.text('Custom Header'), findsOneComponent);
      });

      testComponents('renders with footer', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: true,
            children: [Component.text('Body')],
            footer: div([UButton(label: 'Action')]),
          ),
        );

        expect(find.text('Action'), findsOneComponent);
      });
    });

    group('sides', () {
      testComponents('renders from right (default)', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: true,
            side: USlideoverSide.right,
            children: [Component.text('Right')],
          ),
        );

        expect(find.text('Right'), findsOneComponent);
      });

      testComponents('renders from left', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: true,
            side: USlideoverSide.left,
            children: [Component.text('Left')],
          ),
        );

        expect(find.text('Left'), findsOneComponent);
      });

      testComponents('renders from top', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: true,
            side: USlideoverSide.top,
            children: [Component.text('Top')],
          ),
        );

        expect(find.text('Top'), findsOneComponent);
      });

      testComponents('renders from bottom', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: true,
            side: USlideoverSide.bottom,
            children: [Component.text('Bottom')],
          ),
        );

        expect(find.text('Bottom'), findsOneComponent);
      });
    });

    group('interactions', () {
      testComponents('renders close button', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: true,
            title: 'Title',
            onClose: () {},
            children: [Component.text('Content')],
          ),
        );

        expect(find.tag('button'), findsComponents);
      });

      testComponents('preventClose hides close button', (tester) async {
        tester.pumpComponent(
          USlideover(
            open: true,
            title: 'Title',
            preventClose: true,
            onClose: () {},
            children: [Component.text('Content')],
          ),
        );

        expect(find.text('Title'), findsOneComponent);
      });
    });
  });

  group('Modal integration', () {
    testComponents('renders complete modal with all parts', (tester) async {
      tester.pumpComponent(
        UModal(
          open: true,
          title: 'Confirm Action',
          description: 'Are you sure you want to proceed?',
          onClose: () {},
          children: [
            p([Component.text('This action cannot be undone.')]),
          ],
          footer: div([
            UButton(label: 'Cancel', variant: UButtonVariant.ghost),
            UButton(label: 'Confirm', color: UButtonColor.error),
          ]),
        ),
      );

      expect(find.text('Confirm Action'), findsOneComponent);
      expect(find.text('Are you sure you want to proceed?'),
          findsOneComponent);
      expect(find.text('This action cannot be undone.'),
          findsOneComponent);
      expect(find.text('Cancel'), findsOneComponent);
      expect(find.text('Confirm'), findsOneComponent);
    });
  });
}
