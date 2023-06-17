// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ASEmployee _$ASEmployeeFromJson(Map<String, dynamic> json) => ASEmployee(
      employeeName: json['employeeName'] as String,
      role: $enumDecode(_$ASRolesEnumMap, json['role']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$ASEmployeeToJson(ASEmployee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeName': instance.employeeName,
      'role': _modeToJsonValue(instance.role),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };

const _$ASRolesEnumMap = {
  ASRoles.productDesigner: 'productDesigner',
  ASRoles.flutterDeveloper: 'flutterDeveloper',
  ASRoles.qaTester: 'qaTester',
  ASRoles.productOwner: 'productOwner',
};
