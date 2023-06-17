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
      selectedRole: roleOptions.firstWhereOrNull((element) => employee?.role == element.value),
      roleOptions: roleOptions,
      form: GlobalKey<FormState>(),
      endDate: ASDate(datePresentationTitle: endDatePresentationTitle, date: employee?.endDate),
      startDate: ASDate(datePresentationTitle: startDatePresentationTitle, date: startDate),
    ));
  }

  void selectRole(ASRoles role) {
    state.mapOrNull(
        loaded: (state) =>
            emit(state.copyWith(selectedRole: state.roleOptions.firstWhere((element) => element.value == role))));
  }

  void newValueEmployeeName(String value) {
    state.mapOrNull(loaded: (state) => emit(state.copyWith(employeeName: value)));
  }

  void onStartDatePicked(DateTime startDate, AppLocalizations localization) {
    final startDatePresentationTitle = _dateFormatter.formatDatePicker(date: startDate, localization: localization);
    state.mapOrNull(
        loaded: (state) => emit(
            state.copyWith(startDate: ASDate(datePresentationTitle: startDatePresentationTitle, date: startDate))));
  }

  void onEndDatePicked(DateTime? endDate, AppLocalizations localization) {
    final startDatePresentationTitle = _dateFormatter.formatDatePicker(date: endDate, localization: localization);
    state.mapOrNull(
        loaded: (state) =>
            emit(state.copyWith(endDate: ASDate(datePresentationTitle: startDatePresentationTitle, date: endDate))));
  }

  void save({required Function(ASEmployeePresentation) onCreatedEmployee, required BuildContext context}) async {
    if (_isValid()) {
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

  bool _isValid() {
    return state.map(
        loaded: (state) {
          return state.form.currentState!.validate() && state.selectedRole != null && state.startDate.date != null;
        },
        initial: (_EditPageStateInitial value) => false);
  }
}
