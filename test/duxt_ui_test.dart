/// DuxtUI Component Library Test Suite
///
/// This file serves as the main entry point for all DuxtUI component tests.
/// Run all tests with: `dart test`
///
/// Test structure:
/// - test/components/ - Individual component tests
///   - button_test.dart - UButton, UButtonGroup tests
///   - card_test.dart - UCard, UCardHeader, UCardBody, UCardFooter tests
///   - badge_test.dart - UBadge tests
///   - input_test.dart - UInput, UTextarea tests
///   - tabs_test.dart - UTabs, UControlledTabs, UTabItem tests
///   - modal_test.dart - UModal, USlideover tests
///   - alert_test.dart - UAlert tests
/// - test/theme/ - Theme system tests
///   - theme_test.dart - Colors, Variants, Provider tests
library;

import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

// Import components directly to avoid theme.dart which has syntax issues
import 'package:duxt_ui/src/components/button.dart';
import 'package:duxt_ui/src/components/card.dart';
import 'package:duxt_ui/src/components/badge.dart';
import 'package:duxt_ui/src/components/input.dart';
import 'package:duxt_ui/src/components/tabs.dart';
import 'package:duxt_ui/src/components/modal.dart';
import 'package:duxt_ui/src/components/alert.dart';

// Component tests
import 'components/button_test.dart' as button_test;
import 'components/card_test.dart' as card_test;
import 'components/badge_test.dart' as badge_test;
import 'components/input_test.dart' as input_test;
import 'components/tabs_test.dart' as tabs_test;
import 'components/modal_test.dart' as modal_test;
import 'components/alert_test.dart' as alert_test;

// Theme tests
import 'theme/theme_test.dart' as theme_test;

void main() {
  group('DuxtUI Component Library', () {
    group('Components', () {
      button_test.main();
      card_test.main();
      badge_test.main();
      input_test.main();
      tabs_test.main();
      modal_test.main();
      alert_test.main();
    });

    group('Theme', () {
      theme_test.main();
    });

    // Integration tests - testing components working together
    group('Integration', () {
      testComponents('form with multiple components', (tester) async {
        tester.pumpComponent(
          UCard(
            header: UCardHeader(
              title: 'Sign Up',
              description: 'Create your account',
            ),
            children: [
              UInput(
                label: 'Email',
                type: InputType.email,
                placeholder: 'you@example.com',
                required: true,
              ),
              UInput(
                label: 'Password',
                type: InputType.password,
                placeholder: 'Enter password',
                required: true,
              ),
            ],
            footer: UCardFooter(
              children: [
                UButton(label: 'Cancel', variant: UButtonVariant.ghost),
                UButton(label: 'Sign Up'),
              ],
            ),
          ),
        );

        expect(find.text('Sign Up'), findsComponents);
        expect(find.text('Create your account'), findsOneComponent);
        expect(find.text('Email'), findsOneComponent);
        expect(find.text('Password'), findsOneComponent);
        expect(find.text('Cancel'), findsOneComponent);
      });

      testComponents('modal with form', (tester) async {
        tester.pumpComponent(
          UModal(
            open: true,
            title: 'Edit Profile',
            children: [
              UInput(label: 'Name', value: 'John Doe'),
              UTextarea(label: 'Bio', placeholder: 'Tell us about yourself'),
            ],
            footer: div([
              UButton(label: 'Cancel', variant: UButtonVariant.outline),
              UButton(label: 'Save Changes'),
            ]),
          ),
        );

        expect(find.text('Edit Profile'), findsOneComponent);
        expect(find.text('Name'), findsOneComponent);
        expect(find.text('Bio'), findsOneComponent);
        expect(find.text('Cancel'), findsOneComponent);
        expect(find.text('Save Changes'), findsOneComponent);
      });

      testComponents('alert with action buttons', (tester) async {
        tester.pumpComponent(
          UAlert(
            variant: UAlertVariant.soft,
            color: UAlertColor.warning,
            title: 'Update Available',
            description: 'A new version is ready to install.',
            actions: [
              UButton(
                label: 'Later',
                variant: UButtonVariant.ghost,
                size: UButtonSize.sm,
              ),
              UButton(
                label: 'Update Now',
                variant: UButtonVariant.soft,
                color: UButtonColor.warning,
                size: UButtonSize.sm,
              ),
            ],
          ),
        );

        expect(find.text('Update Available'), findsOneComponent);
        expect(find.text('A new version is ready to install.'),
            findsOneComponent);
        expect(find.text('Later'), findsOneComponent);
        expect(find.text('Update Now'), findsOneComponent);
      });

      testComponents('tabs with cards', (tester) async {
        tester.pumpComponent(
          UTabs(
            items: [
              UTabItem(
                label: 'Overview',
                value: 'overview',
                content: UCard(
                  children: [Component.text('Overview content')],
                ),
              ),
              UTabItem(
                label: 'Settings',
                value: 'settings',
                content: UCard(
                  children: [
                    UInput(label: 'Theme'),
                  ],
                ),
              ),
            ],
          ),
        );

        expect(find.text('Overview'), findsOneComponent);
        expect(find.text('Settings'), findsOneComponent);
        expect(find.text('Overview content'), findsOneComponent);
      });

      testComponents('badge collection', (tester) async {
        tester.pumpComponent(
          div(classes: 'flex gap-2', [
            UBadge(label: 'New', color: UBadgeColor.success),
            UBadge(label: 'Featured', color: UBadgeColor.primary),
            UBadge(label: 'Sale', color: UBadgeColor.error),
            UBadge(label: 'Limited', color: UBadgeColor.warning),
          ]),
        );

        expect(find.text('New'), findsOneComponent);
        expect(find.text('Featured'), findsOneComponent);
        expect(find.text('Sale'), findsOneComponent);
        expect(find.text('Limited'), findsOneComponent);
      });

      testComponents('nested modals pattern', (tester) async {
        tester.pumpComponent(
          div([
            UButton(label: 'Open Modal'),
            UModal(
              open: true,
              title: 'Confirm Delete',
              description: 'This action cannot be undone.',
              footer: div([
                UButton(label: 'Cancel', variant: UButtonVariant.ghost),
                UButton(label: 'Delete', color: UButtonColor.error),
              ]),
              children: [
                UAlert(
                  color: UAlertColor.error,
                  variant: UAlertVariant.soft,
                  title: 'Warning',
                  description: 'All data will be permanently removed.',
                ),
              ],
            ),
          ]),
        );

        expect(find.text('Open Modal'), findsOneComponent);
        expect(find.text('Confirm Delete'), findsOneComponent);
        expect(find.text('Warning'), findsOneComponent);
        expect(find.text('Delete'), findsOneComponent);
      });
    });
  });

  // Smoke tests - quick checks that components render without errors
  group('Smoke Tests', () {
    testComponents('all button variants render', (tester) async {
      for (final variant in UButtonVariant.values) {
        tester.pumpComponent(
          UButton(label: variant.name, variant: variant),
        );
        expect(find.text(variant.name), findsOneComponent);
      }
    });

    testComponents('all button colors render', (tester) async {
      for (final color in UButtonColor.values) {
        tester.pumpComponent(
          UButton(label: color.name, color: color),
        );
        expect(find.text(color.name), findsOneComponent);
      }
    });

    testComponents('all button sizes render', (tester) async {
      for (final size in UButtonSize.values) {
        tester.pumpComponent(
          UButton(label: size.name, size: size),
        );
        expect(find.text(size.name), findsOneComponent);
      }
    });

    testComponents('all badge variants render', (tester) async {
      for (final variant in UBadgeVariant.values) {
        tester.pumpComponent(
          UBadge(label: variant.name, variant: variant),
        );
        expect(find.text(variant.name), findsOneComponent);
      }
    });

    testComponents('all badge colors render', (tester) async {
      for (final color in UBadgeColor.values) {
        tester.pumpComponent(
          UBadge(label: color.name, color: color),
        );
        expect(find.text(color.name), findsOneComponent);
      }
    });

    testComponents('all alert variants render', (tester) async {
      for (final variant in UAlertVariant.values) {
        tester.pumpComponent(
          UAlert(title: variant.name, variant: variant),
        );
        expect(find.text(variant.name), findsOneComponent);
      }
    });

    testComponents('all alert colors render', (tester) async {
      for (final color in UAlertColor.values) {
        tester.pumpComponent(
          UAlert(title: color.name, color: color),
        );
        expect(find.text(color.name), findsOneComponent);
      }
    });

    testComponents('all card variants render', (tester) async {
      for (final variant in UCardVariant.values) {
        tester.pumpComponent(
          UCard(variant: variant, children: [Component.text(variant.name)]),
        );
        expect(find.text(variant.name), findsOneComponent);
      }
    });

    testComponents('all input variants render', (tester) async {
      for (final variant in UInputVariant.values) {
        tester.pumpComponent(
          UInput(label: variant.name, variant: variant),
        );
        expect(find.text(variant.name), findsOneComponent);
      }
    });

    testComponents('all input sizes render', (tester) async {
      for (final size in UInputSize.values) {
        tester.pumpComponent(
          UInput(label: size.name, size: size),
        );
        expect(find.text(size.name), findsOneComponent);
      }
    });

    testComponents('all modal sizes render', (tester) async {
      for (final size in UModalSize.values) {
        tester.pumpComponent(
          UModal(open: true, size: size, children: [Component.text(size.name)]),
        );
        expect(find.text(size.name), findsOneComponent);
      }
    });

    testComponents('all slideover sides render', (tester) async {
      for (final side in USlideoverSide.values) {
        tester.pumpComponent(
          USlideover(
              open: true, side: side, children: [Component.text(side.name)]),
        );
        expect(find.text(side.name), findsOneComponent);
      }
    });
  });
}
