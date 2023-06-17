import 'package:assignment/domain_layer/entities/employee.dart';
import 'package:assignment/domain_layer/entities/employee_presentation.dart';
import 'package:assignment/domain_layer/entities/roles.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/presentation_payer/common/inputs/modal_bottom_picker.dart';

abstract class ASEmployeeRepository {
  Future<List<ASModalBottomPickerOption<ASRoles>>> getRoleOptions(AppLocalizations localization);

  Future<ASEmployeePresentation> getEmployees();

  Future<ASEmployeePresentation> addEmployee(ASEmployee employee);

  Future<ASEmployeePresentation> deleteEmployee(ASEmployee employee);
}
