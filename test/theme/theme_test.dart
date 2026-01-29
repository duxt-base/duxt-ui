import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/theme/colors.dart';
import 'package:duxt_ui/src/theme/variants.dart';
import 'package:duxt_ui/src/theme/provider.dart';

void main() {
  group('UColor', () {
    test('has all semantic color values', () {
      expect(UColor.values.length, equals(7));
      expect(UColor.values, contains(UColor.primary));
      expect(UColor.values, contains(UColor.secondary));
      expect(UColor.values, contains(UColor.success));
      expect(UColor.values, contains(UColor.info));
      expect(UColor.values, contains(UColor.warning));
      expect(UColor.values, contains(UColor.error));
      expect(UColor.values, contains(UColor.neutral));
    });
  });

  group('UColorShade', () {
    test('has all shade levels', () {
      expect(UColorShade.values.length, equals(11));
      expect(UColorShade.values, contains(UColorShade.s50));
      expect(UColorShade.values, contains(UColorShade.s100));
      expect(UColorShade.values, contains(UColorShade.s200));
      expect(UColorShade.values, contains(UColorShade.s300));
      expect(UColorShade.values, contains(UColorShade.s400));
      expect(UColorShade.values, contains(UColorShade.s500));
      expect(UColorShade.values, contains(UColorShade.s600));
      expect(UColorShade.values, contains(UColorShade.s700));
      expect(UColorShade.values, contains(UColorShade.s800));
      expect(UColorShade.values, contains(UColorShade.s900));
      expect(UColorShade.values, contains(UColorShade.s950));
    });
  });

  group('defaultColorMapping', () {
    test('maps all semantic colors', () {
      expect(defaultColorMapping[UColor.primary], equals('green'));
      expect(defaultColorMapping[UColor.secondary], equals('blue'));
      expect(defaultColorMapping[UColor.success], equals('green'));
      expect(defaultColorMapping[UColor.info], equals('blue'));
      expect(defaultColorMapping[UColor.warning], equals('yellow'));
      expect(defaultColorMapping[UColor.error], equals('red'));
      expect(defaultColorMapping[UColor.neutral], equals('slate'));
    });
  });

  group('colorClass', () {
    test('generates color class with default shade', () {
      expect(colorClass(UColor.primary), equals('green-500'));
      expect(colorClass(UColor.secondary), equals('blue-500'));
      expect(colorClass(UColor.error), equals('red-500'));
    });

    test('generates color class with custom shade', () {
      expect(colorClass(UColor.primary, 100), equals('green-100'));
      expect(colorClass(UColor.primary, 900), equals('green-900'));
      expect(colorClass(UColor.error, 600), equals('red-600'));
    });
  });

  group('bgColor', () {
    test('generates background color class', () {
      expect(bgColor(UColor.primary), equals('bg-green-500'));
      expect(bgColor(UColor.error, 100), equals('bg-red-100'));
    });
  });

  group('textColor', () {
    test('generates text color class', () {
      expect(textColor(UColor.primary), equals('text-green-500'));
      expect(textColor(UColor.warning, 600), equals('text-yellow-600'));
    });
  });

  group('ringColor', () {
    test('generates ring color class', () {
      expect(ringColor(UColor.primary), equals('ring-green-500'));
      expect(ringColor(UColor.info, 400), equals('ring-blue-400'));
    });
  });

  group('UTextColors', () {
    test('has semantic text color classes', () {
      expect(UTextColors.highlighted, equals('text-gray-900 dark:text-white'));
      expect(UTextColors.muted, equals('text-gray-500 dark:text-gray-400'));
      expect(UTextColors.dimmed, equals('text-gray-400 dark:text-gray-500'));
      expect(UTextColors.inverted, equals('text-white dark:text-gray-900'));
      expect(
          UTextColors.defaultText, equals('text-gray-700 dark:text-gray-200'));
    });
  });

  group('UBgColors', () {
    test('has semantic background color classes', () {
      expect(UBgColors.defaultBg, equals('bg-white dark:bg-gray-900'));
      expect(UBgColors.elevated, equals('bg-gray-50 dark:bg-gray-800'));
      expect(UBgColors.inverted, equals('bg-gray-900 dark:bg-white'));
      expect(UBgColors.muted, equals('bg-gray-100 dark:bg-gray-800'));
    });
  });

  group('URingColors', () {
    test('has semantic ring color classes', () {
      expect(
          URingColors.defaultRing, equals('ring-gray-200 dark:ring-gray-800'));
      expect(URingColors.accented, equals('ring-gray-300 dark:ring-gray-700'));
    });
  });

  group('UDivideColors', () {
    test('has semantic divide color classes', () {
      expect(UDivideColors.defaultDivide,
          equals('divide-gray-200 dark:divide-gray-800'));
    });
  });

  group('DuxtColors', () {
    test('has primary color hex values', () {
      expect(DuxtColors.primary50, equals('#eef2ff'));
      expect(DuxtColors.primary100, equals('#e0e7ff'));
      expect(DuxtColors.primary500, equals('#6366f1'));
      expect(DuxtColors.primary600, equals('#4f46e5'));
      expect(DuxtColors.primary700, equals('#4338ca'));
    });

    test('has gray color hex values', () {
      expect(DuxtColors.gray50, equals('#f9fafb'));
      expect(DuxtColors.gray100, equals('#f3f4f6'));
      expect(DuxtColors.gray200, equals('#e5e7eb'));
      expect(DuxtColors.gray300, equals('#d1d5db'));
      expect(DuxtColors.gray400, equals('#9ca3af'));
      expect(DuxtColors.gray500, equals('#6b7280'));
      expect(DuxtColors.gray600, equals('#4b5563'));
      expect(DuxtColors.gray700, equals('#374151'));
      expect(DuxtColors.gray800, equals('#1f2937'));
      expect(DuxtColors.gray900, equals('#111827'));
    });

    test('has success color hex values', () {
      expect(DuxtColors.success50, equals('#f0fdf4'));
      expect(DuxtColors.success500, equals('#22c55e'));
      expect(DuxtColors.success600, equals('#16a34a'));
    });

    test('has warning color hex values', () {
      expect(DuxtColors.warning50, equals('#fffbeb'));
      expect(DuxtColors.warning500, equals('#f59e0b'));
      expect(DuxtColors.warning600, equals('#d97706'));
    });

    test('has error color hex values', () {
      expect(DuxtColors.error50, equals('#fef2f2'));
      expect(DuxtColors.error500, equals('#ef4444'));
      expect(DuxtColors.error600, equals('#dc2626'));
    });

    test('has info color hex values', () {
      expect(DuxtColors.info50, equals('#eff6ff'));
      expect(DuxtColors.info500, equals('#3b82f6'));
      expect(DuxtColors.info600, equals('#2563eb'));
    });
  });

  // Variant tests
  group('USize', () {
    test('has all size values', () {
      expect(USize.values.length, equals(5));
      expect(USize.values, contains(USize.xs));
      expect(USize.values, contains(USize.sm));
      expect(USize.values, contains(USize.md));
      expect(USize.values, contains(USize.lg));
      expect(USize.values, contains(USize.xl));
    });
  });

  group('UVariant', () {
    test('has all variant values', () {
      expect(UVariant.values.length, equals(7));
      expect(UVariant.values, contains(UVariant.solid));
      expect(UVariant.values, contains(UVariant.outline));
      expect(UVariant.values, contains(UVariant.soft));
      expect(UVariant.values, contains(UVariant.subtle));
      expect(UVariant.values, contains(UVariant.ghost));
      expect(UVariant.values, contains(UVariant.link));
      expect(UVariant.values, contains(UVariant.none));
    });
  });

  group('buttonSizeClasses', () {
    test('has classes for all sizes', () {
      expect(buttonSizeClasses[USize.xs], isNotNull);
      expect(buttonSizeClasses[USize.sm], isNotNull);
      expect(buttonSizeClasses[USize.md], isNotNull);
      expect(buttonSizeClasses[USize.lg], isNotNull);
      expect(buttonSizeClasses[USize.xl], isNotNull);
    });

    test('classes contain expected tailwind utilities', () {
      expect(buttonSizeClasses[USize.xs], contains('px-2'));
      expect(buttonSizeClasses[USize.xs], contains('text-xs'));
      expect(buttonSizeClasses[USize.md], contains('text-sm'));
      expect(buttonSizeClasses[USize.xl], contains('text-base'));
    });
  });

  group('buttonIconSizeClasses', () {
    test('has classes for all sizes', () {
      expect(buttonIconSizeClasses[USize.xs], equals('size-4'));
      expect(buttonIconSizeClasses[USize.sm], equals('size-4'));
      expect(buttonIconSizeClasses[USize.md], equals('size-5'));
      expect(buttonIconSizeClasses[USize.lg], equals('size-5'));
      expect(buttonIconSizeClasses[USize.xl], equals('size-6'));
    });
  });

  group('inputSizeClasses', () {
    test('has classes for all sizes', () {
      expect(inputSizeClasses[USize.xs], isNotNull);
      expect(inputSizeClasses[USize.sm], isNotNull);
      expect(inputSizeClasses[USize.md], isNotNull);
      expect(inputSizeClasses[USize.lg], isNotNull);
      expect(inputSizeClasses[USize.xl], isNotNull);
    });
  });

  group('badgeSizeClasses', () {
    test('has classes for all sizes', () {
      expect(badgeSizeClasses[USize.xs], isNotNull);
      expect(badgeSizeClasses[USize.sm], isNotNull);
      expect(badgeSizeClasses[USize.md], isNotNull);
      expect(badgeSizeClasses[USize.lg], isNotNull);
      expect(badgeSizeClasses[USize.xl], isNotNull);
    });

    test('includes rounded classes', () {
      expect(badgeSizeClasses[USize.xs], contains('rounded-sm'));
      expect(badgeSizeClasses[USize.md], contains('rounded-md'));
    });
  });

  group('cx utility', () {
    test('combines class strings', () {
      expect(cx(['class1', 'class2']), equals('class1 class2'));
    });

    test('filters out null values', () {
      expect(cx(['class1', null, 'class2']), equals('class1 class2'));
    });

    test('filters out empty strings', () {
      expect(cx(['class1', '', 'class2']), equals('class1 class2'));
    });

    test('returns empty string for empty list', () {
      expect(cx([]), equals(''));
    });

    test('returns empty string for all null values', () {
      expect(cx([null, null]), equals(''));
    });
  });

  // Theme provider tests
  group('UThemeMode', () {
    test('has all mode values', () {
      expect(UThemeMode.values.length, equals(3));
      expect(UThemeMode.values, contains(UThemeMode.light));
      expect(UThemeMode.values, contains(UThemeMode.dark));
      expect(UThemeMode.values, contains(UThemeMode.system));
    });
  });

  group('UThemeConfig', () {
    test('has default configuration', () {
      const config = UThemeConfig();
      expect(config.primaryColor, equals(UColor.primary));
      expect(config.secondaryColor, equals(UColor.secondary));
      expect(config.successColor, equals(UColor.success));
      expect(config.infoColor, equals(UColor.info));
      expect(config.warningColor, equals(UColor.warning));
      expect(config.errorColor, equals(UColor.error));
      expect(config.mode, equals(UThemeMode.system));
    });

    test('default config constant is accessible', () {
      expect(UThemeConfig.defaultConfig.mode, equals(UThemeMode.system));
    });

    test('allows custom configuration', () {
      const config = UThemeConfig(
        primaryColor: UColor.secondary,
        mode: UThemeMode.dark,
      );
      expect(config.primaryColor, equals(UColor.secondary));
      expect(config.mode, equals(UThemeMode.dark));
    });
  });

  group('UThemeProvider', () {
    testComponents('renders with default config', (tester) async {
      tester.pumpComponent(
        UThemeProvider(
          child: div([Component.text('Content')]),
        ),
      );

      expect(find.text('Content'), findsOneComponent);
    });

    testComponents('renders with custom config', (tester) async {
      tester.pumpComponent(
        UThemeProvider(
          config: const UThemeConfig(mode: UThemeMode.dark),
          child: div([Component.text('Dark mode')]),
        ),
      );

      expect(find.text('Dark mode'), findsOneComponent);
    });
  });

  group('UApp', () {
    testComponents('renders with default theme', (tester) async {
      tester.pumpComponent(
        UApp(
          child: div([Component.text('App content')]),
        ),
      );

      expect(find.text('App content'), findsOneComponent);
    });

    testComponents('renders with custom theme', (tester) async {
      tester.pumpComponent(
        UApp(
          theme: const UThemeConfig(mode: UThemeMode.dark),
          child: div([Component.text('Dark app')]),
        ),
      );

      expect(find.text('Dark app'), findsOneComponent);
    });
  });

  // Integration with components
  group('Theme integration', () {
    testComponents('components work within UApp', (tester) async {
      tester.pumpComponent(
        UApp(
          child: div([
            span(
                classes: UTextColors.highlighted,
                [Component.text('Highlighted')]),
            div(classes: UBgColors.elevated, [Component.text('Elevated')]),
          ]),
        ),
      );

      expect(find.text('Highlighted'), findsOneComponent);
      expect(find.text('Elevated'), findsOneComponent);
    });
  });
}
