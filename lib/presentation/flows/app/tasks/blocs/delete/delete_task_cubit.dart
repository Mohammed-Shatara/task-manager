import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/blocs/app_bloc/app_bloc.dart';
import 'package:task_manager/domain/use_cases/tasks/delete_task_use_case.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit({required this.deleteTaskUseCase}) : super(DeleteTaskState());

  final DeleteTaskUseCase deleteTaskUseCase;

  void deleteTask(int id) async {
    emit(state.copyWith(status: PageStatus.loading));
    final result = await deleteTaskUseCase(id);
    if (result.hasDataOnly) {
      emit(state.copyWith(status: PageStatus.success));
    } else {
      emit(state.copyWith(status: PageStatus.error, error: result.error.toString()));
    }
  }
}
