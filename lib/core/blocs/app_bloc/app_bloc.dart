import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_mediator/bloc_hub/bloc_member.dart';
import 'package:flutter_bloc_mediator/communication_types/base_communication.dart';
import 'package:meta/meta.dart';

import '../../services/init_app_store.dart';
import '../../services/session_manager.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with BlocMember {
  final InitAppStore initAppStore;
  final SessionManager sessionManager;

  AppBloc({required this.initAppStore, required this.sessionManager})
    : super(const AppState()) {
    on<LaunchAppEvent>(_onLaunchApp);
    on<ChangeStatusEvent>(_onChangeStatus);
  }

  @override
  void receive(String from, CommunicationType data) {
    switch (data.runtimeType) {
      /// handle app status receiver and me result
    }
  }
}

extension AppBlocMappers on AppBloc {
  void _onLaunchApp(LaunchAppEvent event, Emitter<AppState> emit) async {
    final isFirstTime = await initAppStore.isFirstTime;
    await Future.delayed(const Duration(seconds: 1));
    if (isFirstTime) {
      initAppStore.setFirstTime();
    }
    Status appStatus =
        await sessionManager.hasToken ? Status.authorized : Status.unauthorized;

    emit(
      state.copyWith(
        isLaunched: true,
        isFirstTime: isFirstTime,
        appStatus: appStatus,
      ),
    );
    return;
  }

  void _onChangeStatus(ChangeStatusEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(appStatus: event.appStatus, token: event.token));
  }
}

extension AppBlocActions on AppBloc {
  void changeStatus(Status appStatus, {String? token}) {
    add(ChangeStatusEvent(appStatus: appStatus, token: token));
  }
}
