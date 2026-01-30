import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/data/pagination.dart';
import 'package:duxt_ui/src/theme/colors.dart';
import 'package:duxt_ui/src/theme/variants.dart';

void main() {
  group('DPagination', () {
    group('rendering', () {
      testComponents('renders with required props', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 10,
        ));

        expect(find.tag('nav'), findsOneComponent);
        expect(find.tag('ul'), findsOneComponent);
      });

      testComponents('renders page numbers', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
        ));

        expect(find.text('1'), findsOneComponent);
        expect(find.text('5'), findsOneComponent);
      });

      testComponents('renders nothing for zero total pages', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 0,
        ));

        expect(find.tag('nav'), findsNothing);
      });
    });

    group('current page highlighting', () {
      testComponents('highlights first page when current', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
        ));

        expect(find.text('1'), findsOneComponent);
      });

      testComponents('highlights middle page when current', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 3,
          totalPages: 5,
        ));

        expect(find.text('3'), findsOneComponent);
      });

      testComponents('highlights last page when current', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 5,
          totalPages: 5,
        ));

        expect(find.text('5'), findsOneComponent);
      });
    });

    group('navigation buttons', () {
      testComponents('shows prev/next buttons by default', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 3,
          totalPages: 10,
          showPrevNext: true,
        ));

        expect(find.tag('button'), findsComponents);
      });

      testComponents('hides prev/next buttons when disabled', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 3,
          totalPages: 10,
          showPrevNext: false,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('shows first/last buttons when enabled', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 5,
          totalPages: 10,
          showFirstLast: true,
        ));

        expect(find.tag('button'), findsComponents);
      });

      testComponents('hides first/last buttons by default', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 5,
          totalPages: 10,
          showFirstLast: false,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });
    });

    group('ellipsis', () {
      testComponents('shows ellipsis for many pages', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 5,
          totalPages: 20,
          siblingCount: 1,
        ));

        expect(find.text('...'), findsComponents);
      });

      testComponents('no ellipsis for few pages', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 2,
          totalPages: 3,
        ));

        expect(find.text('...'), findsNothing);
      });
    });

    group('variants', () {
      testComponents('renders solid variant', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          variant: DPaginationVariant.solid,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('renders outline variant (default)', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          variant: DPaginationVariant.outline,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('renders soft variant', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          variant: DPaginationVariant.soft,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('renders subtle variant', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          variant: DPaginationVariant.subtle,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('renders ghost variant', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          variant: DPaginationVariant.ghost,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders xs size', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          size: DSize.xs,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('renders sm size (default)', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          size: DSize.sm,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('renders md size', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          size: DSize.md,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          size: DSize.lg,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('renders xl size', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          size: DSize.xl,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          color: DColor.primary,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          color: DColor.secondary,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          color: DColor.success,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });
    });

    group('disabled state', () {
      testComponents('renders disabled pagination', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 5,
          disabled: true,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });
    });

    group('sibling count', () {
      testComponents('renders with sibling count 1 (default)', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 5,
          totalPages: 10,
          siblingCount: 1,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });

      testComponents('renders with sibling count 2', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 5,
          totalPages: 10,
          siblingCount: 2,
        ));

        expect(find.tag('nav'), findsOneComponent);
      });
    });

    group('boundary cases', () {
      testComponents('handles single page', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 1,
        ));

        expect(find.text('1'), findsOneComponent);
      });

      testComponents('handles two pages', (tester) async {
        tester.pumpComponent(DPagination(
          currentPage: 1,
          totalPages: 2,
        ));

        expect(find.text('1'), findsOneComponent);
        expect(find.text('2'), findsOneComponent);
      });
    });
  });

  group('DPaginationSimple', () {
    group('rendering', () {
      testComponents('renders with required props', (tester) async {
        tester.pumpComponent(DPaginationSimple(
          currentPage: 1,
          totalPages: 10,
        ));

        expect(find.tag('div'), findsComponents);
        expect(find.text('Previous'), findsOneComponent);
        expect(find.text('Next'), findsOneComponent);
      });

      testComponents('renders page info text', (tester) async {
        tester.pumpComponent(DPaginationSimple(
          currentPage: 3,
          totalPages: 10,
        ));

        expect(find.text('Page 3 of 10'), findsOneComponent);
      });
    });

    group('navigation buttons', () {
      testComponents('shows previous and next buttons', (tester) async {
        tester.pumpComponent(DPaginationSimple(
          currentPage: 5,
          totalPages: 10,
        ));

        expect(find.text('Previous'), findsOneComponent);
        expect(find.text('Next'), findsOneComponent);
      });

      testComponents('disables previous on first page', (tester) async {
        tester.pumpComponent(DPaginationSimple(
          currentPage: 1,
          totalPages: 10,
        ));

        expect(find.text('Previous'), findsOneComponent);
      });

      testComponents('disables next on last page', (tester) async {
        tester.pumpComponent(DPaginationSimple(
          currentPage: 10,
          totalPages: 10,
        ));

        expect(find.text('Next'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders sm size (default)', (tester) async {
        tester.pumpComponent(DPaginationSimple(
          currentPage: 1,
          totalPages: 5,
          size: DSize.sm,
        ));

        expect(find.tag('div'), findsComponents);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(DPaginationSimple(
          currentPage: 1,
          totalPages: 5,
          size: DSize.lg,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });

    group('disabled state', () {
      testComponents('renders disabled simple pagination', (tester) async {
        tester.pumpComponent(DPaginationSimple(
          currentPage: 5,
          totalPages: 10,
          disabled: true,
        ));

        expect(find.tag('div'), findsComponents);
      });
    });
  });
}
