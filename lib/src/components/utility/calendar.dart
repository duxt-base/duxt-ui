import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'icon.dart';

/// DuxtUI Calendar component - Date picker grid
///
/// A calendar component for date selection with month/year navigation.
/// Supports single date selection with visual feedback.
class UCalendar extends StatefulComponent {
  /// Currently selected date
  final DateTime? selectedDate;

  /// Callback when date is selected
  final ValueChanged<DateTime>? onDateSelect;

  /// Minimum selectable date
  final DateTime? minDate;

  /// Maximum selectable date
  final DateTime? maxDate;

  /// First day of week (0 = Sunday, 1 = Monday)
  final int firstDayOfWeek;

  /// Custom CSS classes
  final String? classes;

  const UCalendar({
    super.key,
    this.selectedDate,
    this.onDateSelect,
    this.minDate,
    this.maxDate,
    this.firstDayOfWeek = 1, // Monday default
    this.classes,
  });

  @override
  State createState() => _UCalendarState();
}

class _UCalendarState extends State<UCalendar> {
  late int _displayMonth;
  late int _displayYear;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _displayMonth = component.selectedDate?.month ?? now.month;
    _displayYear = component.selectedDate?.year ?? now.year;
  }

  void _goToPreviousMonth() {
    setState(() {
      if (_displayMonth == 1) {
        _displayMonth = 12;
        _displayYear--;
      } else {
        _displayMonth--;
      }
    });
  }

  void _goToNextMonth() {
    setState(() {
      if (_displayMonth == 12) {
        _displayMonth = 1;
        _displayYear++;
      } else {
        _displayMonth++;
      }
    });
  }

  void _selectDate(int day) {
    final date = DateTime(_displayYear, _displayMonth, day);
    component.onDateSelect?.call(date);
  }

  bool _isDateDisabled(int day) {
    final date = DateTime(_displayYear, _displayMonth, day);
    if (component.minDate != null && date.isBefore(component.minDate!)) {
      return true;
    }
    if (component.maxDate != null && date.isAfter(component.maxDate!)) {
      return true;
    }
    return false;
  }

  bool _isSelected(int day) {
    if (component.selectedDate == null) return false;
    return component.selectedDate!.year == _displayYear &&
        component.selectedDate!.month == _displayMonth &&
        component.selectedDate!.day == day;
  }

  bool _isToday(int day) {
    final now = DateTime.now();
    return now.year == _displayYear &&
        now.month == _displayMonth &&
        now.day == day;
  }

  int _getDaysInMonth() {
    return DateTime(_displayYear, _displayMonth + 1, 0).day;
  }

  int _getFirstDayOfMonth() {
    final firstDay = DateTime(_displayYear, _displayMonth, 1).weekday;
    // Adjust for firstDayOfWeek
    return (firstDay - component.firstDayOfWeek + 7) % 7;
  }

  List<String> _getWeekdayLabels() {
    const labels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final result = <String>[];
    for (var i = 0; i < 7; i++) {
      result.add(labels[(i + component.firstDayOfWeek) % 7]);
    }
    return result;
  }

  String _getMonthName() {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[_displayMonth - 1];
  }

  @override
  Component build(BuildContext context) {
    final daysInMonth = _getDaysInMonth();
    final firstDayOffset = _getFirstDayOfMonth();
    final weekdayLabels = _getWeekdayLabels();

    return div(
      classes:
          'p-4 bg-white dark:bg-gray-900 rounded-lg border border-gray-200 dark:border-gray-700 ${component.classes ?? ""}',
      [
        // Header with month/year navigation
        div(
          classes: 'flex items-center justify-between mb-4',
          [
            button(
              type: ButtonType.button,
              onClick: _goToPreviousMonth,
              classes:
                  'p-2 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-colors',
              attributes: {'aria-label': 'Previous month'},
              [
                UIcon(name: UIconNames.chevronLeft, size: UIconSize.sm),
              ],
            ),
            span(
              classes: 'font-semibold text-gray-900 dark:text-white',
              [Component.text('${_getMonthName()} $_displayYear')],
            ),
            button(
              type: ButtonType.button,
              onClick: _goToNextMonth,
              classes:
                  'p-2 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-colors',
              attributes: {'aria-label': 'Next month'},
              [
                UIcon(name: UIconNames.chevronRight, size: UIconSize.sm),
              ],
            ),
          ],
        ),

        // Weekday headers
        div(
          classes: 'grid grid-cols-7 gap-1 mb-2',
          [
            for (final label in weekdayLabels)
              div(
                classes:
                    'text-center text-xs font-medium text-gray-500 dark:text-gray-400 py-2',
                [Component.text(label)],
              ),
          ],
        ),

        // Days grid
        div(
          classes: 'grid grid-cols-7 gap-1',
          [
            // Empty cells for offset
            for (var i = 0; i < firstDayOffset; i++) div(classes: 'p-2', []),

            // Day cells
            for (var day = 1; day <= daysInMonth; day++) _buildDayCell(day),
          ],
        ),
      ],
    );
  }

  Component _buildDayCell(int day) {
    final isDisabled = _isDateDisabled(day);
    final isSelected = _isSelected(day);
    final isToday = _isToday(day);

    String cellClasses =
        'w-10 h-10 flex items-center justify-center text-sm rounded-lg transition-colors ';

    if (isDisabled) {
      cellClasses += 'text-gray-300 dark:text-gray-600 cursor-not-allowed';
    } else if (isSelected) {
      cellClasses += 'bg-indigo-600 text-white font-semibold';
    } else if (isToday) {
      cellClasses +=
          'bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 font-semibold hover:bg-indigo-100 dark:hover:bg-indigo-900/30 cursor-pointer';
    } else {
      cellClasses +=
          'text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-800 cursor-pointer';
    }

    return button(
      type: ButtonType.button,
      onClick: isDisabled ? null : () => _selectDate(day),
      disabled: isDisabled,
      classes: cellClasses,
      [Component.text('$day')],
    );
  }
}
