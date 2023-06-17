import 'dart:async';
import 'dart:developer';

import 'package:assignment/app_layer/app/app.dart';
import 'package:assignment/app_layer/app/injection.dart';
import 'package:assignment/app_layer/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final getIt = await configureDependencies();
      final router = getIt<ASNavigator>();
      runApp(App(
        navigator: router,
      ));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
