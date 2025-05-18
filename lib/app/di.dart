import 'package:dio/dio.dart';
import 'package:flutter_bloc_mediator/bloc_hub/concrete_hub.dart';
import 'package:flutter_bloc_mediator/bloc_hub/hub.dart';
import 'package:get_it/get_it.dart';

import '../core/api/auth_interceptor.dart';
import '../core/blocs/app_bloc/app_bloc.dart';
import '../core/resources/colors.dart';
import '../core/services/init_app_store.dart';
import '../core/services/session_manager.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerLazySingleton<BlocHub>(() => ConcreteHub());

  locator.registerLazySingleton<SessionManager>(() => DefaultSessionManager());

  locator.registerFactory(() => Dio());

  locator.registerLazySingleton(
    () => AuthInterceptor(locator<SessionManager>(), locator()),
  );

  locator.registerLazySingleton(() => InitAppStore());
  locator.registerFactory<AppThemeColors>(
    () => ThemeFactory.colorModeFactory(AppThemeMode.light),
  );

  locator.registerLazySingleton(
    () => AppBloc(initAppStore: locator(), sessionManager: locator()),
  );

  locator<BlocHub>().registerByName(
    locator<AppBloc>(),
    BlocMembersNames.appBloc,
  );
}

class BlocMembersNames {
  static String get appBloc => 'APP_BLOC';

  static String get authBLoc => 'AUTH_BLOC';
}
