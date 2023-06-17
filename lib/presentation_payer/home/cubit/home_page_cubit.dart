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

  void init() async {
    final data = await _repository.getEmployees();
    return emit(HomePageStateLoaded(
        currentEmployee: data.currentEmployees, previousEmployee: data.previousEmployees, employees: data.employees));
  }

  Future<void> deleteEmployee(ASEmployee employee) async {
    state.mapOrNull(loaded: (state) async {
      final deletedResponse = await _repository.deleteEmployee(employee);
      emit(state.copyWith(
          currentEmployee: deletedResponse.currentEmployees,
          previousEmployee: deletedResponse.previousEmployees,
          employees: deletedResponse.employees));
    });
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
