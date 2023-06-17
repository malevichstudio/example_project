part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.initial() = _HomePageStateInitial;
  const factory HomePageState.loaded({
    required List<ASEmployee> currentEmployee,
    required List<ASEmployee> previousEmployee,
    required List<ASEmployee> employees,
  }) = HomePageStateLoaded;
}
