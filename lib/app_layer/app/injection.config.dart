// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:assignment/app_layer/modules/storage/interfaces/storage.dart'
    as _i10;
import 'package:assignment/app_layer/router/router.dart' as _i3;
import 'package:assignment/data_layer/datasources/local_datasource.dart' as _i5;
import 'package:assignment/data_layer/repository/employee_repository_impl.dart'
    as _i7;
import 'package:assignment/domain_layer/repository/employee_repository.dart'
    as _i6;
import 'package:assignment/presentation_payer/edit/cubit/edit_page_cubit.dart'
    as _i8;
import 'package:assignment/presentation_payer/home/cubit/home_page_cubit.dart'
    as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPreferencesModule = _$SharedPreferencesModule();
    gh.singleton<_i3.ASNavigator>(_i3.ASNavigatorImpl());
    await gh.factoryAsync<_i4.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i5.ASLocalDataSource>(
        () => _i5.ASLocalDataSourceImpl(gh<_i4.SharedPreferences>()));
    gh.lazySingleton<_i6.ASEmployeeRepository>(
        () => _i7.ASEmployeeRepositoryImpl(gh<_i5.ASLocalDataSource>()));
    gh.factory<_i8.EditPageCubit>(
        () => _i8.EditPageCubit(gh<_i6.ASEmployeeRepository>()));
    gh.factory<_i9.HomePageCubit>(
        () => _i9.HomePageCubit(gh<_i6.ASEmployeeRepository>()));
    return this;
  }
}

class _$SharedPreferencesModule extends _i10.SharedPreferencesModule {}
