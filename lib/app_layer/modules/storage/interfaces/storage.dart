import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedPreferencesModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

abstract class ASStorageService<T, F> {
  Future<F> cacheData({required T data});

  Future<F> deleteData(T deleteItem);

  Future<F?> getData();
}
