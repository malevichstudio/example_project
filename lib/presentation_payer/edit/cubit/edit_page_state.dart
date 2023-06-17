part of 'edit_page_cubit.dart';

@freezed
class EditPageState with _$EditPageState {
  const factory EditPageState.initial() = _EditPageStateInitial;
  const factory EditPageState.loaded({
    required String? employeeName,
    String? errorEmployeeName,
    required ASModalBottomPickerOption<ASRoles>? selectedRole,
    String? roleError,
    required List<ASModalBottomPickerOption<ASRoles>> roleOptions,
    required ASDate startDate,
    String? startDateError,
    required ASDate? endDate,
    required DateTime endDateTimeAvailableFromPick,
  }) = EditPageStateLoaded;
}

class ASDate {
  final String datePresentationTitle;
  final DateTime? date;

  ASDate({required this.datePresentationTitle, required this.date});
}
