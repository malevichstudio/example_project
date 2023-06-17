import 'package:assignment/domain_layer/entities/calendar_panel_switcher_option.dart';
import 'package:assignment/domain_layer/formatters/date_time_formatter.dart';
import 'package:assignment/generated/assets.gen.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/presentation_payer/common/buttons/primaty_button.dart';
import 'package:assignment/presentation_payer/common/buttons/secondary_button.dart';
import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:assignment/presentation_payer/common/inputs/date_picker.dart';
import 'package:assignment/presentation_payer/common/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ASSelectStartDateDialog extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime time) onDateSaved;
  ASSelectStartDateDialog({required this.onDateSaved, DateTime? initialDate, Key? key})
      : initialDate = initialDate ?? DateTime.now(),
        super(key: key);

  @override
  State<ASSelectStartDateDialog> createState() => ASSelectStartDateDialogState();
}

class ASSelectStartDateDialogState extends State<ASSelectStartDateDialog> {
  late final Map<_ASButtonOptions, DateTime> _mappedOption;
  List<ASCalendarPanelSwitcherOption<_ASButtonOptions>> _options = [];
  late DateTime _startDateCalendar;
  late DateTime _endDateCalendar;
  late DateTime _todayDate;
  late final ValueNotifier<DateTime> _selectedDate;
  late final ValueNotifier<DateTime> _focusedDate;

  @override
  void initState() {
    super.initState();
    _focusedDate = ValueNotifier(DateTime(widget.initialDate.year, widget.initialDate.month, 2));
    _startDateCalendar = DateTime(widget.initialDate.year - 1, widget.initialDate.month);
    _endDateCalendar = DateTime(widget.initialDate.year + 1, widget.initialDate.month, 3);
    _todayDate = DateTime.now();
    _selectedDate = ValueNotifier(widget.initialDate);

    _mappedOption = {
      _ASButtonOptions.today: _todayDate,
      _ASButtonOptions.nextTuesday: _nextDayWeek(
        weekday: DateTime.tuesday,
      ),
      _ASButtonOptions.nextMonday: _nextDayWeek(
        weekday: DateTime.monday,
      ),
      _ASButtonOptions.afterOneWeek: DateTime.now().add(const Duration(days: 7)),
    };
  }

  List<ASCalendarPanelSwitcherOption<_ASButtonOptions>> _initOptions() {
    return [
      ASCalendarPanelSwitcherOption<_ASButtonOptions>(
        title: AppLocalizations.of(context).today,
        onChanged: _onSelectedOption,
        isActive: _isEqualDates(first: _mappedOption[_ASButtonOptions.today], second: widget.initialDate),
        type: _ASButtonOptions.today,
      ),
      ASCalendarPanelSwitcherOption<_ASButtonOptions>(
        title: AppLocalizations.of(context).nextMonday,
        onChanged: _onSelectedOption,
        isActive: _isEqualDates(first: _mappedOption[_ASButtonOptions.nextMonday], second: widget.initialDate),
        type: _ASButtonOptions.nextMonday,
      ),
      ASCalendarPanelSwitcherOption<_ASButtonOptions>(
        title: AppLocalizations.of(context).nextTuesday,
        onChanged: _onSelectedOption,
        isActive: _isEqualDates(first: _mappedOption[_ASButtonOptions.nextTuesday], second: widget.initialDate),
        type: _ASButtonOptions.nextTuesday,
      ),
      ASCalendarPanelSwitcherOption<_ASButtonOptions>(
        title: AppLocalizations.of(context).afterOneWeek,
        onChanged: _onSelectedOption,
        isActive: _isEqualDates(first: _mappedOption[_ASButtonOptions.afterOneWeek], second: widget.initialDate),
        type: _ASButtonOptions.afterOneWeek,
      ),
    ];
  }

  bool _isEqualDates({
    required DateTime? first,
    required DateTime? second,
  }) {
    if (first == null && second == null) return false;
    return first?.year == second?.year && first?.month == second?.month && first?.day == second?.day;
  }

  DateTime _nextDayWeek({required int weekday}) {
    DateTime now = DateTime.now();
    if (now.weekday < weekday) {
      return now.add(Duration(days: weekday - now.weekday));
    }
    return now.add(Duration(days: 7 - now.weekday + weekday));
  }

  void _onSelectedOption(_ASButtonOptions option) {
    _options = _options.map((e) => e.copyWith(isActive: e.type == option)).toList();
    _selectedDate.value = _mappedOption[option]!;
    _focusedDate.value = DateTime(_mappedOption[option]!.year, _mappedOption[option]!.month, 2);
  }

  void _findOrDisable(DateTime selectedDate) {
    _options = _options
        .map((e) => e.copyWith(isActive: _isEqualDates(first: _mappedOption[e.type], second: selectedDate)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    _options = _initOptions();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ValueListenableBuilder(
                    valueListenable: _selectedDate,
                    builder: (BuildContext context, value, Widget? child) {
                      return ASCalendarPanelSwitchers(key: ValueKey(value), options: _options);
                    }),
                const SizedBox(
                  height: 25,
                ),
                ValueListenableBuilder(
                  valueListenable: _focusedDate,
                  builder: (BuildContext context, DateTime value, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (value.month > _startDateCalendar.month || value.year > _startDateCalendar.year) {
                              if (value.month > 1) {
                                _focusedDate.value = DateTime(value.year, value.month - 1);
                              } else {
                                _focusedDate.value = DateTime(value.year - 1, 12);
                              }
                            }
                          },
                          child: SizedBox(
                            height: 17,
                            width: 17,
                            child: Assets.svg.arrowLeft.svg(
                                fit: BoxFit.contain,
                                theme: SvgTheme(
                                    currentColor:
                                        (value.month > _startDateCalendar.month || value.year > _startDateCalendar.year)
                                            ? ASColors.darkGrey
                                            : ASColors.lightGrey)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 140,
                          child: Text(
                            DateFormat("LLLL y").format(value),
                            textAlign: TextAlign.center,
                            style: ASTextStyles.headerPage.copyWith(color: ASColors.black),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (value.month < _endDateCalendar.month || value.year < _endDateCalendar.year) {
                              if (value.month < 12) {
                                _focusedDate.value = DateTime(value.year, value.month + 1);
                              } else {
                                _focusedDate.value = DateTime(value.year + 1, 1);
                              }
                            }
                          },
                          child: SizedBox(
                            height: 17,
                            width: 17,
                            child: Assets.svg.arrowRight.svg(
                                fit: BoxFit.contain,
                                theme: SvgTheme(
                                  currentColor:
                                      (value.month < _endDateCalendar.month || value.year < _endDateCalendar.year)
                                          ? ASColors.darkGrey
                                          : ASColors.lightGrey,
                                )),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                  valueListenable: _focusedDate,
                  builder: (BuildContext context, DateTime value, Widget? child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 330,
                      child: ValueListenableBuilder(
                        valueListenable: _selectedDate,
                        builder: (BuildContext context, DateTime selectedDate, Widget? child) {
                          return TableCalendar(
                            focusedDay: value,
                            firstDay: _startDateCalendar,
                            lastDay: _endDateCalendar,
                            headerVisible: false,
                            shouldFillViewport: false,
                            sixWeekMonthsEnforced: false,
                            onPageChanged: (day) => _focusedDate.value = day,
                            calendarBuilders: CalendarBuilders(prioritizedBuilder: _buildDaysCalendar),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(
            color: ASColors.lightBackground,
            height: 1,
          ),
          _buildBottomPanel(),
        ],
      ),
    );
  }

  Widget _buildDaysCalendar(BuildContext context, DateTime day, DateTime focused) {
    final isTodayDate = _todayDate.year == day.year && _todayDate.month == day.month && _todayDate.day == day.day;
    final isDayOfThisMonth = day.month == _focusedDate.value.month;

    final selectedDateValue = _selectedDate.value;
    final isSelectedDate =
        selectedDateValue.year == day.year && selectedDateValue.month == day.month && selectedDateValue.day == day.day;

    if (isSelectedDate) {
      return _buildSelectedDate(day);
    }

    if (isTodayDate) {
      return _buildTodayDate(day);
    }

    if (!isDayOfThisMonth) {
      return const SizedBox(
        width: 30,
        height: 20,
      );
    }

    return _buildRegularDate(day);
  }

  Widget _buildSelectedDate(DateTime day) {
    return Container(
      width: 30,
      alignment: Alignment.center,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: ASColors.primary),
      child: Text(
        day.day.toString(),
        style: ASTextStyles.calendarDaysTextStyle.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildRegularDate(DateTime day) {
    return GestureDetector(
      onTap: () {
        _findOrDisable(day);
        _selectedDate.value = day;
      },
      child: Container(
        width: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        child: Text(
          day.day.toString(),
          style: ASTextStyles.calendarDaysTextStyle,
        ),
      ),
    );
  }

  Widget _buildTodayDate(DateTime day) {
    return GestureDetector(
      onTap: () {
        _findOrDisable(day);
        _selectedDate.value = day;
      },
      child: Container(
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1, color: ASColors.primary)),
        child: Text(
          day.day.toString(),
          style: ASTextStyles.calendarDaysTextStyle.copyWith(color: ASColors.primary),
        ),
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 23,
                width: 20,
                child: Assets.icons.calendar.image(fit: BoxFit.contain),
              ),
              const SizedBox(
                width: 12,
              ),
              ValueListenableBuilder(
                valueListenable: _selectedDate,
                builder: (BuildContext context, DateTime value, Widget? child) {
                  return Text(
                    ASDateFormatter().formatDatePicker(date: value, localization: AppLocalizations.of(context)),
                    style: ASTextStyles.inputTextStyle,
                  );
                },
              )
            ],
          ),
          Row(
            children: [
              ASSecondaryButton(
                onPressed: Navigator.of(context).pop,
                text: AppLocalizations.of(context).cancel,
              ),
              const SizedBox(
                width: 16,
              ),
              ASPrimaryButton(
                onPressed: () {
                  widget.onDateSaved(_selectedDate.value);
                  Navigator.of(context).pop();
                },
                text: AppLocalizations.of(context).save,
              )
            ],
          )
        ],
      ),
    );
  }
}

enum _ASButtonOptions {
  today,
  nextMonday,
  nextTuesday,
  afterOneWeek,
}
