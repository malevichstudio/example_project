import 'package:assignment/domain_layer/entities/employee.dart';
import 'package:equatable/equatable.dart';

class ASEmployeePresentation extends Equatable {
  final List<ASEmployee> currentEmployees;
  final List<ASEmployee> previousEmployees;

  List<ASEmployee> get employees => [...currentEmployees, ...previousEmployees];

  const ASEmployeePresentation._({required this.currentEmployees, required this.previousEmployees});

  factory ASEmployeePresentation.fromEmployeesList(List<ASEmployee>? employees) {
    if (employees == null) {
      return const ASEmployeePresentation._(currentEmployees: [], previousEmployees: []);
    }
    final dateNow = DateTime.now();
    final currentEmployees = <ASEmployee>[];
    final previousEmployees = <ASEmployee>[];
    for (final i in employees) {
      if (i.endDate == null ||
          (i.endDate!.year > dateNow.year && i.endDate!.month > dateNow.month && i.endDate!.day > dateNow.day)) {
        currentEmployees.add(i);
        continue;
      }
      previousEmployees.add(i);
    }
    currentEmployees.sort((a, b) => a.startDate.compareTo(b.startDate));
    previousEmployees.sort((a, b) => a.startDate.compareTo(b.startDate));
    return ASEmployeePresentation._(currentEmployees: currentEmployees, previousEmployees: previousEmployees);
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
