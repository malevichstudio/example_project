import 'dart:convert';

import 'package:assignment/app_layer/modules/storage/interfaces/storage.dart';
import 'package:assignment/domain_layer/entities/employee.dart';
import 'package:assignment/domain_layer/entities/roles.dart';
import 'package:assignment/presentation_payer/common/inputs/modal_bottom_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n/l10n.dart';

const String employeeKey = "employee_storage_key";

abstract class ASLocalDataSource extends ASStorageService<ASEmployee, List<ASEmployee>> {
  Future<List<ASModalBottomPickerOption<ASRoles>>> getRoleOptions(AppLocalizations localization);
}

@LazySingleton(as: ASLocalDataSource)
class ASLocalDataSourceImpl implements ASLocalDataSource {
  final SharedPreferences _prefs;
  const ASLocalDataSourceImpl(this._prefs);

  @override
  Future<List<ASModalBottomPickerOption<ASRoles>>> getRoleOptions(AppLocalizations localization) async {
    return [
      ASModalBottomPickerOption(
        value: ASRoles.productDesigner,
        displayableName: ASRoles.productDesigner.name(localization),
      ),
      ASModalBottomPickerOption(
        value: ASRoles.flutterDeveloper,
        displayableName: ASRoles.flutterDeveloper.name(localization),
      ),
      ASModalBottomPickerOption(
        value: ASRoles.qaTester,
        displayableName: ASRoles.qaTester.name(localization),
      ),
      ASModalBottomPickerOption(
        value: ASRoles.productOwner,
        displayableName: ASRoles.productOwner.name(localization),
      ),
    ];
  }

  @override
  Future<List<ASEmployee>> cacheData({required ASEmployee data}) async {
    final employees = await getData();
    if (employees == null) {
      _prefs.setString(employeeKey, jsonEncode([data.toJson()]));
      return [data];
    }
    final index = employees.indexWhere((element) => element.id == data.id);
    if (index == -1) {
      employees.add(data);
    } else {
      employees[index] = data;
    }
    _prefs.setString(employeeKey, jsonEncode(employees.map((e) => e.toJson()).toList()));
    return employees;
  }

  @override
  Future<List<ASEmployee>> deleteData(ASEmployee deleteItem) async {
    final employees = await getData();
    if (employees == null) {
      return [];
    }
    employees.removeWhere((data) => data == deleteItem);
    _prefs.setString(employeeKey, jsonEncode(employees.map((e) => e.toJson()).toList()));
    return employees;
  }

  @override
  Future<List<ASEmployee>?> getData() async {
    final data = _prefs.getString(employeeKey);
    if (data != null) {
      return (jsonDecode(data) as List).map((e) => ASEmployee.fromJson(e as Map<String, dynamic>)).toList();
    }
    return null;
  }
}
