import 'package:assignment/domain_layer/entities/roles.dart';
import 'package:assignment/l10n/l10n.dart';
import "package:collection/collection.dart";
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'employee.g.dart';

const Map<int, ASRoles> _rolesCollection = {
  1: ASRoles.productOwner,
  2: ASRoles.qaTester,
  3: ASRoles.flutterDeveloper,
  4: ASRoles.productDesigner,
};

int _modeToJsonValue(ASRoles mode) {
  final value = _rolesCollection.entries.firstWhereOrNull((element) => element.value == mode)?.key;
  if (value != null) return value;
  throw Exception('Cannot find index of sharing mode enumeration!');
}

ASRoles _modeFromJson(int jsonValue) {
  final value = _rolesCollection.entries.firstWhereOrNull((element) => element.key == jsonValue)?.value;
  if (value != null) return value;
  throw Exception('Cannot find enumeration of sharing mode index!');
}

@JsonSerializable()
class ASEmployee extends Equatable {
  @JsonKey(name: "id")
  final int id;
  final String employeeName;
  @JsonKey(toJson: _modeToJsonValue)
  final ASRoles role;
  final DateTime startDate;
  final DateTime? endDate;

  String datePresentationString(AppLocalizations localizations) => _datePresentationString(localizations);

  ASEmployee({
    required this.employeeName,
    required this.role,
    required this.startDate,
    required this.endDate,
    int? id,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch;

  const ASEmployee._({
    required this.employeeName,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.id,
  });

  factory ASEmployee.fromJson(Map<String, dynamic> json) {
    return ASEmployee._(
      employeeName: json['employeeName'] as String,
      role: _modeFromJson(json['role'] as int),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() => _$ASEmployeeToJson(this);

  @override
  List<Object?> get props => [employeeName, role, startDate, endDate, id];

  String _datePresentationString(AppLocalizations localizations) {
    if (endDate == null) {
      final formattedDate = DateFormat("d LLL, y").format(startDate);
      return localizations.dateFrom(formattedDate);
    }
    final formattedDateStart = DateFormat("d LLL, y").format(startDate);
    final formattedDateEnd = DateFormat("d LLL, y").format(endDate!);
    return localizations.dateFrom("$formattedDateStart - $formattedDateEnd");
  }

  ASEmployee copyWith({
    String? employeeName,
    ASRoles? role,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ASEmployee._(
      employeeName: employeeName ?? this.employeeName,
      role: role ?? this.role,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      id: id,
    );
  }
}
