import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/theme/colors.dart';
import 'package:duxt_ui/src/theme/variants.dart';
import 'package:duxt_ui/src/theme/provider.dart';

void main() {
  group('DColor', () {
    test('has all semantic color values', () {
      expect(DColor.values.length, equals(7));
      expect(DColor.values, contains(DColor.primary));
      expect(DColor.values, contains(DColor.secondary));
      expect(DColor.values, contains(DColor.success));
      expect(DColor.values, contains(DColor.info));
      expect(DColor.values, contains(DColor.warning));
      expect(DColor.values, contains(DColor.error));
      expect(DColor.values, contains(DColor.neutral));
    });
  });

  group('DColorShade', () {
    test('has all shade levels', () {
      expect(DColorShade.values.length, equals(11));
      expect(DColorShade.values, contains(DColorShade.s50));
      expect(DColorShade.values, contains(DColorShade.s100));
      expect(DColorShade.values, contains(DColorShade.s200));
      expect(DColorShade.values, contains(DColorShade.s300));
      expect(DColorShade.values, contains(DColorShade.s400));
      expect(DColorShade.values, contains(DColorShade.s500));
      expect(DColorShade.values, contains(DColorShade.s600));
      expect(DColorShade.values, contains(DColorShade.s700));
      expect(DColorShade.values, contains(DColorShade.s800));
      expect(DColorShade.values, contains(DColorShade.s900));
      expect(DColorShade.values, contains(DColorShade.s950));
    });
  });

  group('defaultColorMapping', () {
    test('maps all semantic colors', () {
      expect(defaultColorMapping[DColor.primary], equals('cyan'));
      expect(defaultColorMapping[DColor.secondary], equals('blue'));
      expect(defaultColorMapping[DColor.success], equals('green'));
      expect(defaultColorMapping[DColor.info], equals('blue'));
      expect(defaultColorMapping[DColor.warning], equals('yellow'));
      expect(defaultColorMapping[DColor.error], equals('red'));
      expect(defaultColorMapping[DColor.neutral], equals('slate'));
    });
  });

  group('colorClass', () {
    test('generates color class with default shade', () {
      expect(colorClass(DColor.primary), equals('cyan-500'));
      expect(colorClass(DColor.secondary), equals('blue-500'));
      expect(colorClass(DColor.error), equals('red-500'));
    });

    test('generates color class with custom shade', () {
      expect(colorClass(DColor.primary, 100), equals('cyan-100'));
      expect(colorClass(DColor.primary, 900), equals('cyan-900'));
      expect(colorClass(DColor.error, 600), equals('red-600'));
    });
  });

  group('bgColor', () {
    test('generates background color class', () {
      expect(bgColor(DColor.primary), equals('bg-cyan-500'));
      expect(bgColor(DColor.error, 100), equals('bg-red-100'));
    });
  });

  group('textColor', () {
    test('generates text color class', () {
      expect(textColor(DColor.primary), equals('text-cyan-500'));
      expect(textColor(DColor.warning, 600), equals('text-yellow-600'));
    });
  });

  group('ringColor', () {
    test('generates ring color class', () {
      expect(ringColor(DColor.primary), equals('ring-cyan-500'));
      expect(ringColor(DColor.info, 400), equals('ring-blue-400'));
    });
  });

  group('DTextColors', () {
    test('has semantic text color classes', () {
      expect(DTextColors.highlighted, equals('text-gray-900 dark:text-white'));
      expect(DTextColors.muted, equals('text-gray-500 dark:text-gray-400'));
      expect(DTextColors.dimmed, equals('text-gray-400 dark:text-gray-500'));
      expect(DTextColors.inverted, equals('text-white dark:text-gray-900'));
      expect(
          DTextColors.defaultText, equals('text-gray-700 dark:text-gray-200'));
    });
  });

  group('DBgColors', () {
    test('has semantic background color classes', () {
      expect(DBgColors.defaultBg, equals('bg-white dark:bg-gray-900'));
      expect(DBgColors.elevated, equals('bg-gray-50 dark:bg-gray-800'));
      expect(DBgColors.inverted, equals('bg-gray-900 dark:bg-white'));
      expect(DBgColors.muted, equals('bg-gray-100 dark:bg-gray-800'));
    });
  });

  group('DRingColors', () {
    test('has semantic ring color classes', () {
      expect(
          DRingColors.defaultRing, equals('ring-gray-200 dark:ring-gray-800'));
      expect(DRingColors.accented, equals('ring-gray-300 dark:ring-gray-700'));
    });
  });

  group('DDivideColors', () {
    test('has semantic divide color classes', () {
      expect(DDivideColors.defaultDivide,
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
  group('DSize', () {
    test('has all size values', () {
      expect(DSize.values.length, equals(5));
      expect(DSize.values, contains(DSize.xs));
      expect(DSize.values, contains(DSize.sm));
      expect(DSize.values, contains(DSize.md));
      expect(DSize.values, contains(DSize.lg));
      expect(DSize.values, contains(DSize.xl));
    });
  });

  group('DVariant', () {
    test('has all variant values', () {
      expect(DVariant.values.length, equals(7));
      expect(DVariant.values, contains(DVariant.solid));
      expect(DVariant.values, contains(DVariant.outline));
      expect(DVariant.values, contains(DVariant.soft));
      expect(DVariant.values, contains(DVariant.subtle));
      expect(DVariant.values, contains(DVariant.ghost));
      expect(DVariant.values, contains(DVariant.link));
      expect(DVariant.values, contains(DVariant.none));
    });
  });

  group('buttonSizeClasses', () {
    test('has classes for all sizes', () {
      expect(buttonSizeClasses[DSize.xs], isNotNull);
      expect(buttonSizeClasses[DSize.sm], isNotNull);
      expect(buttonSizeClasses[DSize.md], isNotNull);
      expect(buttonSizeClasses[DSize.lg], isNotNull);
      expect(buttonSizeClasses[DSize.xl], isNotNull);
    });

    test('classes contain expected tailwind utilities', () {
      expect(buttonSizeClasses[DSize.xs], contains('px-2'));
      expect(buttonSizeClasses[DSize.xs], contains('text-xs'));
      expect(buttonSizeClasses[DSize.md], contains('text-sm'));
      expect(buttonSizeClasses[DSize.xl], contains('text-base'));
    });
  });

  group('buttonIconSizeClasses', () {
    test('has classes for all sizes', () {
      expect(buttonIconSizeClasses[DSize.xs], equals('size-4'));
      expect(buttonIconSizeClasses[DSize.sm], equals('size-4'));
      expect(buttonIconSizeClasses[DSize.md], equals('size-5'));
      expect(buttonIconSizeClasses[DSize.lg], equals('size-5'));
      expect(buttonIconSizeClasses[DSize.xl], equals('size-6'));
    });
  });

  group('inputSizeClasses', () {
    test('has classes for all sizes', () {
      expect(inputSizeClasses[DSize.xs], isNotNull);
      expect(inputSizeClasses[DSize.sm], isNotNull);
      expect(inputSizeClasses[DSize.md], isNotNull);
      expect(inputSizeClasses[DSize.lg], isNotNull);
      expect(inputSizeClasses[DSize.xl], isNotNull);
    });
  });

  group('badgeSizeClasses', () {
    test('has classes for all sizes', () {
      expect(badgeSizeClasses[DSize.xs], isNotNull);
      expect(badgeSizeClasses[DSize.sm], isNotNull);
      expect(badgeSizeClasses[DSize.md], isNotNull);
      expect(badgeSizeClasses[DSize.lg], isNotNull);
      expect(badgeSizeClasses[DSize.xl], isNotNull);
    });

    test('includes rounded classes', () {
      expect(badgeSizeClasses[DSize.xs], contains('rounded-sm'));
      expect(badgeSizeClasses[DSize.md], contains('rounded-md'));
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
  group('DThemeMode', () {
    test('has all mode values', () {
      expect(DThemeMode.values.length, equals(3));
      expect(DThemeMode.values, contains(DThemeMode.light));
      expect(DThemeMode.values, contains(DThemeMode.dark));
      expect(DThemeMode.values, contains(DThemeMode.system));
    });
  });

  group('DThemeConfig', () {
    test('has default configuration', () {
      const config = DThemeConfig();
      expect(config.primaryColor, equals(DColor.primary));
      expect(config.secondaryColor, equals(DColor.secondary));
      expect(config.successColor, equals(DColor.success));
      expect(config.infoColor, equals(DColor.info));
      expect(config.warningColor, equals(DColor.warning));
      expect(config.errorColor, equals(DColor.error));
      expect(config.mode, equals(DThemeMode.system));
    });

    test('default config constant is accessible', () {
      expect(DThemeConfig.defaultConfig.mode, equals(DThemeMode.system));
    });

    test('allows custom configuration', () {
      const config = DThemeConfig(
        primaryColor: DColor.secondary,
        mode: DThemeMode.dark,
      );
      expect(config.primaryColor, equals(DColor.secondary));
      expect(config.mode, equals(DThemeMode.dark));
    });
  });

  group('DThemeProvider', () {
    testComponents('renders with default config', (tester) async {
      tester.pumpComponent(
        DThemeProvider(
          child: div([Component.text('Content')]),
        ),
      );

      expect(find.text('Content'), findsOneComponent);
    });

    testComponents('renders with custom config', (tester) async {
      tester.pumpComponent(
        DThemeProvider(
          config: const DThemeConfig(mode: DThemeMode.dark),
          child: div([Component.text('Dark mode')]),
        ),
      );

      expect(find.text('Dark mode'), findsOneComponent);
    });
  });

  group('DApp', () {
    testComponents('renders with default theme', (tester) async {
      tester.pumpComponent(
        DApp(
          child: div([Component.text('App content')]),
        ),
      );

      expect(find.text('App content'), findsOneComponent);
    });

    testComponents('renders with custom theme', (tester) async {
      tester.pumpComponent(
        DApp(
          theme: const DThemeConfig(mode: DThemeMode.dark),
          child: div([Component.text('Dark app')]),
        ),
      );

      expect(find.text('Dark app'), findsOneComponent);
    });
  });

  // Integration with components
  group('Theme integration', () {
    testComponents('components work within DApp', (tester) async {
      tester.pumpComponent(
        DApp(
          child: div([
            span(
                classes: DTextColors.highlighted,
                [Component.text('Highlighted')]),
            div(classes: DBgColors.elevated, [Component.text('Elevated')]),
          ]),
        ),
      );

      expect(find.text('Highlighted'), findsOneComponent);
      expect(find.text('Elevated'), findsOneComponent);
    });
  });
}
