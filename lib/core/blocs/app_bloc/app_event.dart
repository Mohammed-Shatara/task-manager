part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class LaunchAppEvent extends AppEvent {}

class LogoutEvent extends AppEvent {}

class ChangeStatusEvent extends AppEvent {
  final Status appStatus;
  final String? token;

  ChangeStatusEvent({required this.appStatus, this.token});
}
