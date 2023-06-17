import 'package:assignment/domain_layer/entities/employee.dart';
import 'package:assignment/domain_layer/entities/employee_presentation.dart';
import 'package:assignment/domain_layer/entities/roles.dart';
import 'package:assignment/domain_layer/formatters/date_time_formatter.dart';
import 'package:assignment/domain_layer/repository/employee_repository.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/presentation_payer/common/inputs/modal_bottom_picker.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'edit_page_cubit.freezed.dart';
part 'edit_page_state.dart';

@Injectable()
class EditPageCubit extends Cubit<EditPageState> {
  final ASEmployeeRepository _repository;
  final ASDateFormatter _dateFormatter;
  EditPageCubit(this._repository)
      : _dateFormatter = ASDateFormatter(),
        super(const EditPageState.initial());

  late final ASEmployee? employee;

  Future<void> init({required AppLocalizations localization, required ASEmployee? employee}) async {
    this.employee = employee;
    final roleOptions = await _repository.getRoleOptions(localization);
    final startDate = employee?.startDate ?? DateTime.now();
    final startDatePresentationTitle = _dateFormatter.formatDatePicker(date: startDate, localization: localization);
    final endDatePresentationTitle =
        _dateFormatter.formatDatePicker(date: employee?.endDate, localization: localization);
    return emit(EditPageState.loaded(
      employeeName: employee?.employeeName,
      selectedRole: roleOptions.firstWhereOrNull(
        (element) => employee?.role == element.value,
      ),
      roleOptions: roleOptions,
      endDate: ASDate(
        datePresentationTitle: endDatePresentationTitle,
        date: employee?.endDate,
      ),
      startDate: ASDate(datePresentationTitle: startDatePresentationTitle, date: startDate),
      endDateTimeAvailableFromPick: startDate,
    ));
  }

  void selectRole(ASRoles role) {
    state.mapOrNull(
      loaded: (state) => emit(
        state.copyWith(
          selectedRole: state.roleOptions.firstWhere(
            (element) => element.value == role,
          ),
          roleError: null,
        ),
      ),
    );
  }

  void newValueEmployeeName(String value) {
    state.mapOrNull(
        loaded: (state) =>
            emit(state.copyWith(errorEmployeeName: value != "" ? null : state.errorEmployeeName, employeeName: value)));
  }

  void onStartDatePicked(DateTime startDate, AppLocalizations localization) {
    final startDatePresentationTitle = _dateFormatter.formatDatePicker(date: startDate, localization: localization);
    final dateNow = DateTime.now();
    state.mapOrNull(
      loaded: (state) => emit(
        state.copyWith(
            startDate: ASDate(datePresentationTitle: startDatePresentationTitle, date: startDate),
            startDateError: null,
            endDateTimeAvailableFromPick: _calculateEndDateTimeAvailableFromPick(startDate: startDate),
            endDate: _calculateEndDate(state: state, startDate: startDate)),
      ),
    );
  }

  void onEndDatePicked(DateTime? endDate, AppLocalizations localization) {
    final startDatePresentationTitle = _dateFormatter.formatDatePicker(date: endDate, localization: localization);
    state.mapOrNull(
      loaded: (state) => emit(
        state.copyWith(
          endDate: ASDate(
            datePresentationTitle: startDatePresentationTitle,
            date: endDate,
          ),
        ),
      ),
    );
  }

  void save({required Function(ASEmployeePresentation) onCreatedEmployee, required BuildContext context}) async {
    if (_isValid(context)) {
      state.mapOrNull(loaded: (state) async {
        ASEmployee newEmployee;
        if (employee != null) {
          newEmployee = employee!.copyWith(
            employeeName: state.employeeName!,
            role: state.selectedRole!.value,
            startDate: state.startDate.date!,
            endDate: state.endDate?.date,
          );
        } else {
          newEmployee = ASEmployee(
            employeeName: state.employeeName!,
            role: state.selectedRole!.value,
            startDate: state.startDate.date!,
            endDate: state.endDate?.date,
          );
        }
        final newList = await _repository.addEmployee(newEmployee);
        if (context.mounted) Navigator.of(context).pop();

        onCreatedEmployee(newList);
      });
    }
  }

  bool _isValid(BuildContext context) {
    return state.map(
        loaded: (state) {
          final newState = state.copyWith(
            roleError: state.selectedRole == null ? AppLocalizations.of(context).required : null,
            errorEmployeeName:
                state.employeeName == null || state.employeeName == "" ? AppLocalizations.of(context).required : null,
          );
          emit(newState);
          return state.employeeName != null &&
              state.employeeName != "" &&
              state.selectedRole != null &&
              state.startDate.date != null;
        },
        initial: (_EditPageStateInitial value) => false);
  }

  ASDate? _calculateEndDate({required EditPageStateLoaded state, required DateTime startDate}) {
    if (state.endDate?.date != null && startDate.isBefore(state.endDate!.date!)) {
      return state.endDate!;
    }
    return null;
  }

  DateTime _calculateEndDateTimeAvailableFromPick({required DateTime startDate}) {
    final nowDate = DateTime.now();
    if (startDate.isBefore(nowDate)) {
      return nowDate;
    }
    return startDate;
  }
}
