part of 'show_all_bloc.dart';

sealed class ShowAllEvent {}

class WatchTasksEvent extends ShowAllEvent {}

class SetTasksListEvent extends ShowAllEvent {
  final List<TaskModel> tasks;

  SetTasksListEvent({required this.tasks});
}

class GetUserTaskEvent extends ShowAllEvent {
  final int userId;

  GetUserTaskEvent({required this.userId});
}

class SwitchListEvent extends ShowAllEvent {

}