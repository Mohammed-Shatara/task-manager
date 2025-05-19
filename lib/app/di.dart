import 'package:dio/dio.dart';
import 'package:flutter_bloc_mediator/bloc_hub/concrete_hub.dart';
import 'package:flutter_bloc_mediator/bloc_hub/hub.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/core/validators/email_validator.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/core/validators/required_validator.dart';
import 'package:task_manager/data/data_sources/auth/auth_data_source_impl.dart';
import 'package:task_manager/data/data_sources/tasks/tasks_data_source_impl.dart';
import 'package:task_manager/data/database/app_database.dart';
import 'package:task_manager/data/repositories/auth_repository_impl.dart';
import 'package:task_manager/data/repositories/tasks_repository_impl.dart';
import 'package:task_manager/domain/use_cases/auth/login_use_case.dart';
import 'package:task_manager/domain/use_cases/auth/register_use_case.dart';
import 'package:task_manager/domain/use_cases/auth/validations/login_validator_use_case.dart';
import 'package:task_manager/domain/use_cases/auth/validations/register_validator_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/create_task_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/delete_task_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/get_single_task_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/get_user_tasks_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/update_task_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/validations/task_validation_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/watch_tasks_use_case.dart';

import '../core/api/auth_interceptor.dart';
import '../core/blocs/app_bloc/app_bloc.dart';
import '../core/resources/colors.dart';
import '../core/services/init_app_store.dart';
import '../core/services/session_manager.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerLazySingleton<BlocHub>(() => ConcreteHub());
  locator.registerLazySingleton(() => AppDatabase());

  locator.registerLazySingleton<SessionManager>(() => DefaultSessionManager());

  locator.registerFactory(() => Dio());

  locator.registerLazySingleton(() => AuthInterceptor(locator<SessionManager>(), locator()));

  locator.registerLazySingleton(() => InitAppStore());
  locator.registerFactory<AppThemeColors>(() => ThemeFactory.colorModeFactory(AppThemeMode.light));

  locator.registerLazySingleton(() => AppBloc(initAppStore: locator(), sessionManager: locator()));

  ///********************************* Auth ******************************************
  locator.registerLazySingleton(() => AuthDataSourceImpl(locator<AppDatabase>().userDao));

  locator.registerLazySingleton(() => AuthRepositoryImpl(locator<AuthDataSourceImpl>()));

  locator.registerLazySingleton(() => RequiredValidator());
  locator.registerLazySingleton(() => EmailValidator());
  locator.registerLazySingleton(() => DateValidator());
  locator.registerLazySingleton(() => PasswordValidator(minLength: 8));
  locator.registerLazySingleton(() => MinimumValidator(minLength: 4));

  locator.registerLazySingleton(
    () => LoginValidatorUseCase(
      requiredValidator: locator(),
      emailValidator: locator(),
      passwordValidator: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => RegisterValidatorUseCase(
      requiredValidator: locator(),
      emailValidator: locator(),
      passwordValidator: locator(),
      minimumValidator: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => LoginUseCase(loginValidatorUseCase: locator(), authRepository: locator()),
  );
  locator.registerLazySingleton(
    () => RegisterUseCase(registerValidatorUseCase: locator(), authRepository: locator()),
  );

  ///********************************* Tasks ******************************************

  locator.registerLazySingleton(() => TasksDataSourceImpl(locator<AppDatabase>().taskDao));
  locator.registerLazySingleton(() => TasksRepositoryImpl(tasksDataSource: locator()));

  locator.registerLazySingleton(
    () => TaskValidationUseCase(
      requiredValidator: locator(),
      minimumValidator: locator(),
      dateValidator: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => CreateTaskUseCase(tasksRepository: locator(), taskValidationUseCase: locator()),
  );
  locator.registerLazySingleton(
    () => UpdateTaskUseCase(tasksRepository: locator(), taskValidationUseCase: locator()),
  );
  locator.registerLazySingleton(() => GetUserTaskUseCase(tasksRepository: locator()));
  locator.registerLazySingleton(() => GetSingleTaskUseCase(tasksRepository: locator()));
  locator.registerLazySingleton(() => WatchTasksUseCase(tasksRepository: locator()));
  locator.registerLazySingleton(() => DeleteTaskUseCase(tasksRepository: locator()));

  locator<BlocHub>().registerByName(locator<AppBloc>(), BlocMembersNames.appBloc);
}

class BlocMembersNames {
  static String get appBloc => 'APP_BLOC';

  static String get authBLoc => 'AUTH_BLOC';
}
