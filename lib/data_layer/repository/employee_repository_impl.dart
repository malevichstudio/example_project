import 'package:assignment/data_layer/datasources/local_datasource.dart';
import 'package:assignment/domain_layer/entities/employee.dart';
import 'package:assignment/domain_layer/entities/employee_presentation.dart';
import 'package:assignment/domain_layer/entities/roles.dart';
import 'package:assignment/domain_layer/repository/employee_repository.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/presentation_payer/common/inputs/modal_bottom_picker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ASEmployeeRepository)
class ASEmployeeRepositoryImpl implements ASEmployeeRepository {
  final ASLocalDataSource _localDataSource;

  ASEmployeeRepositoryImpl(this._localDataSource);

  @override
  Future<List<ASModalBottomPickerOption<ASRoles>>> getRoleOptions(AppLocalizations localization) {
    return _localDataSource.getRoleOptions(localization);
  }

  @override
  Future<ASEmployeePresentation> getEmployees() async {
    final employees = await _localDataSource.getData();
    return ASEmployeePresentation.fromEmployeesList(employees);
  }

  @override
  Future<ASEmployeePresentation> addEmployee(ASEmployee employee) async {
    final employees = await _localDataSource.cacheData(data: employee);
    return ASEmployeePresentation.fromEmployeesList(employees);
  }

  @override
  Future<ASEmployeePresentation> deleteEmployee(ASEmployee employee) async {
    final employees = await _localDataSource.deleteData(employee);
    return ASEmployeePresentation.fromEmployeesList(employees);
  }
}
