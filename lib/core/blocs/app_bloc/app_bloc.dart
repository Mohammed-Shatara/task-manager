import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_mediator/bloc_hub/bloc_member.dart';
import 'package:flutter_bloc_mediator/communication_types/base_communication.dart';
import 'package:meta/meta.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/domain/use_cases/auth/get_user_use_case.dart';

import '../../services/init_app_store.dart';
import '../../services/session_manager.dart';

part 'app_event.dart';

part 'app_state.dart';

enum PageStatus { init, loading, success, error }

class AppStatus extends CommunicationType {
  final Status data;
  final UserModel? userModel;

  AppStatus({this.data = Status.startup, this.userModel});
}

class AppBloc extends Bloc<AppEvent, AppState> with BlocMember {
  final InitAppStore initAppStore;
  final SessionManager sessionManager;
  final GetUserUseCase getUserUseCase;

  UserModel? get user => state.me;

  AppBloc({
    required this.initAppStore,
    required this.sessionManager,
    required this.getUserUseCase,
  }) : super(const AppState()) {
    on<LaunchAppEvent>(_onLaunchApp);
    on<SetAppStatusEvent>(_onSetAppStatus);
    on<LogoutEvent>(_onLogout);
  }

  @override
  void receive(String from, CommunicationType data) {
    switch (data.runtimeType) {
      case const (AppStatus):
        setAppStatus(data as AppStatus);
        break;

      /// handle app status receiver and me result
    }
  }
}

extension AppBlocMappers on AppBloc {
  void _onLaunchApp(LaunchAppEvent event, Emitter<AppState> emit) async {
    final isFirstTime = await initAppStore.isFirstTime;
    await Future.delayed(const Duration(milliseconds: 3100));
    if (isFirstTime) {
      initAppStore.setFirstTime();
    }

    final hasToken = await sessionManager.hasToken;
    Status appStatus = hasToken ? Status.authorized : Status.unauthorized;

    if (hasToken) {
      final userId = int.tryParse(await sessionManager.authToken);
      if (userId != null) {
        final result = await getUserUseCase(userId);
        if (result.hasDataOnly) {
          emit(state.copyWith(me: result.data));
        }
      }
    }

    emit(
      state.copyWith(
        isLaunched: true,
        isFirstTime: isFirstTime,
        appStatus: appStatus,
      ),
    );
    return;
  }

  void _onSetAppStatus(SetAppStatusEvent event, Emitter<AppState> emit) {
    emit(
      state.copyWith(
        appStatus: event.appStatus.data,
        me: event.appStatus.userModel,
      ),
    );
  }

  void _onLogout(LogoutEvent event, Emitter<AppState> emit) async {
    await sessionManager.deleteToken();
    emit(state.copyWith(appStatus: Status.unauthorized));
  }
}

extension AppBlocActions on AppBloc {
  void setAppStatus(AppStatus status) {
    add(SetAppStatusEvent(status));
  }

  void logout() {
    add(LogoutEvent());
  }
}
