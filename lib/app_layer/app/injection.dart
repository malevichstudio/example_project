import 'package:assignment/app_layer/app/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<GetIt> configureDependencies() async => await getIt.init();
