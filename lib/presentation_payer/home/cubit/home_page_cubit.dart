import 'dart:async';

import 'package:assignment/domain_layer/entities/employee.dart';
import 'package:assignment/domain_layer/entities/employee_presentation.dart';
import 'package:assignment/domain_layer/repository/employee_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_page_cubit.freezed.dart';
part 'home_page_state.dart';

@Injectable()
class HomePageCubit extends Cubit<HomePageState> {
  final ASEmployeeRepository _repository;
  HomePageCubit(this._repository) : super(const HomePageState.initial());

  Timer? _timer;
  ASEmployee? _candidateDeleteEmployee;

  void init() async {
    final data = await _repository.getEmployees();
    return emit(HomePageStateLoaded(
        currentEmployee: data.currentEmployees, previousEmployee: data.previousEmployees, employees: data.employees));
  }

  Future<void> _deleteEmployeeFromStorage() async {
    await _repository.deleteEmployee(_candidateDeleteEmployee!);
  }

  void deletePreviousEmployeeUI(int index) {
    if (_candidateDeleteEmployee != null) {
      _deleteNow();
    }
    state.mapOrNull(loaded: (state) {
      List<ASEmployee> newPreviousList = List<ASEmployee>.from(state.previousEmployee);
      _candidateDeleteEmployee = newPreviousList.removeAt(index);
      _timer = Timer(const Duration(seconds: 5), () {
        if (_candidateDeleteEmployee != null) {
          _deleteEmployeeFromStorage();
          _candidateDeleteEmployee = null;
          _timer!.cancel();
        }
      });
      emit(state.copyWith(previousEmployee: newPreviousList));
    });
  }

  void deleteCurrentEmployeeUI(int index) {
    if (_candidateDeleteEmployee != null) {
      _deleteNow();
    }
    state.mapOrNull(loaded: (state) {
      List<ASEmployee> newCurrentList = List<ASEmployee>.from(state.currentEmployee);
      _candidateDeleteEmployee = newCurrentList.removeAt(index);
      _timer = Timer(const Duration(seconds: 5), () {
        if (_candidateDeleteEmployee != null) {
          _deleteEmployeeFromStorage();
          _candidateDeleteEmployee = null;
          _timer!.cancel();
        }
      });
      emit(state.copyWith(currentEmployee: newCurrentList));
    });
  }

  void _deleteNow() {
    _deleteEmployeeFromStorage();
    _candidateDeleteEmployee = null;
    _timer!.cancel();
  }

  void undoDeletion() {
    _timer?.cancel();
    if (_candidateDeleteEmployee == null) {
      return;
    }
    state.mapOrNull(loaded: (state) {
      final list = ASEmployeePresentation.fromEmployeesList(
          [...state.currentEmployee, ...state.previousEmployee, _candidateDeleteEmployee!]);
      emit(state.copyWith(
          currentEmployee: list.currentEmployees, previousEmployee: list.previousEmployees, employees: list.employees));
    });
    _candidateDeleteEmployee = null;
  }

  void onEmployeeChanged(ASEmployeePresentation employees) {
    state.mapOrNull(loaded: (state) {
      emit(state.copyWith(
          currentEmployee: employees.currentEmployees,
          previousEmployee: employees.previousEmployees,
          employees: employees.employees));
    });
  }
}
