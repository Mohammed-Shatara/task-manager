part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class LaunchAppEvent extends AppEvent {}

class LogoutEvent extends AppEvent {}

class SetAppStatusEvent extends AppEvent {
  final AppStatus appStatus;
  final bool? isFirstTime;

  SetAppStatusEvent(this.appStatus, {this.isFirstTime});
}
