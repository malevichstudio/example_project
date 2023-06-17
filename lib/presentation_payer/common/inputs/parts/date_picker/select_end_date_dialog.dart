import 'package:assignment/domain_layer/entities/calendar_panel_switcher_option.dart';
import 'package:assignment/domain_layer/formatters/date_time_formatter.dart';
import 'package:assignment/generated/assets.gen.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/presentation_payer/common/buttons/primaty_button.dart';
import 'package:assignment/presentation_payer/common/buttons/secondary_button.dart';
import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:assignment/presentation_payer/common/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../date_picker.dart';

class ASSelectEndDateDialog extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime dateTimeAvailableFromPick;
  final Function(DateTime? time) onDateSaved;
  const ASSelectEndDateDialog(
      {required this.onDateSaved, required this.dateTimeAvailableFromPick, this.initialDate, Key? key})
      : super(key: key);

  @override
  State<ASSelectEndDateDialog> createState() => ASSelectEndDateDialogState();
}

class ASSelectEndDateDialogState extends State<ASSelectEndDateDialog> {
  late final Map<_ASButtonOptions, DateTime?> _mappedOption;
  List<ASCalendarPanelSwitcherOption<_ASButtonOptions>> _options = [];
  late DateTime _startDateCalendar;
  late DateTime _endDateCalendar;
  late DateTime _todayDate;
  late final ValueNotifier<DateTime?> _selectedDate;
  late final ValueNotifier<DateTime> _focusedDate;

  @override
  void initState() {
    super.initState();
    _todayDate = DateTime.now();
    _focusedDate = ValueNotifier(
        DateTime(widget.initialDate?.year ?? _todayDate.year, widget.initialDate?.month ?? _todayDate.month, 2));
    _startDateCalendar =
        DateTime((widget.initialDate?.year ?? _todayDate.year) - 1, widget.initialDate?.month ?? _todayDate.month);
    _endDateCalendar =
        DateTime((widget.initialDate?.year ?? _todayDate.year) + 1, widget.initialDate?.month ?? _todayDate.month, 3);
    _selectedDate = ValueNotifier(widget.initialDate);

    _mappedOption = {
      _ASButtonOptions.today: _todayDate,
      _ASButtonOptions.noDate: null,
    };
  }

  List<ASCalendarPanelSwitcherOption<_ASButtonOptions>> _initOptions() {
    return [
      ASCalendarPanelSwitcherOption<_ASButtonOptions>(
        title: AppLocalizations.of(context).noDate,
        onChanged: _onSelectedOption,
        isActive: _mappedOption[_ASButtonOptions.noDate] == widget.initialDate,
        type: _ASButtonOptions.noDate,
      ),
      ASCalendarPanelSwitcherOption<_ASButtonOptions>(
        title: AppLocalizations.of(context).today,
        onChanged: _onSelectedOption,
        isActive: _isEqualDates(first: _mappedOption[_ASButtonOptions.today]!, second: widget.initialDate),
        type: _ASButtonOptions.today,
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

  void _onSelectedOption(_ASButtonOptions option) {
    _options = _options.map((e) => e.copyWith(isActive: e.type == option)).toList();
    _selectedDate.value = _mappedOption[option];
    if (_mappedOption[option] != null) {
      _focusedDate.value = DateTime(_mappedOption[option]!.year, _mappedOption[option]!.month, 2);
    }
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
                  builder: (BuildContext context, DateTime? value, Widget? child) {
                    return ASCalendarPanelSwitchers(key: ValueKey(value), options: _options);
                  },
                ),
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
                                          : ASColors.lightGrey,
                                )),
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
                        builder: (BuildContext context, DateTime? selectedDate, Widget? child) {
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
    final isDayOfThisMonth = day.month == _focusedDate.value.month;

    final availableToPick = day.year >= widget.dateTimeAvailableFromPick.year &&
        day.month >= widget.dateTimeAvailableFromPick.month &&
        (day.month == widget.dateTimeAvailableFromPick.month ? day.day >= widget.dateTimeAvailableFromPick.day : true);

    final selectedDateValue = _selectedDate.value;
    final isSelectedDate = selectedDateValue?.year == day.year &&
        selectedDateValue?.month == day.month &&
        selectedDateValue?.day == day.day;

    if (isSelectedDate && isDayOfThisMonth) {
      return _buildSelectedDate(day);
    }

    if (!isDayOfThisMonth) {
      return const SizedBox(
        width: 30,
        height: 20,
      );
    }

    return _buildRegularDate(day, availableToPick: availableToPick);
  }

  Widget _buildSelectedDate(DateTime day) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 30),
      alignment: Alignment.center,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: ASColors.primary),
      child: Text(
        day.day.toString(),
        style: ASTextStyles.calendarDaysTextStyle.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildRegularDate(DateTime day, {required bool availableToPick}) {
    return GestureDetector(
      onTap: () {
        if (availableToPick) {
          _findOrDisable(day);
          _selectedDate.value = day;
        }
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 30),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        child: Text(
          day.day.toString(),
          style:
              ASTextStyles.calendarDaysTextStyle.copyWith(color: availableToPick ? Colors.black : ASColors.lightGrey),
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
                builder: (BuildContext context, DateTime? value, Widget? child) {
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
  noDate,
  today,
}
