import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/domain/use_cases/tasks/get_single_task_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/update_task_use_case.dart';

import '../../../../../../core/blocs/app_bloc/app_bloc.dart';
import '../../../../../../domain/use_cases/tasks/create_task_use_case.dart';
import '../../../../../../domain/use_cases/tasks/validations/task_validation_use_case.dart';
import '../create/create_task_cubit.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  UpdateTaskCubit({
    required this.validationUseCase,
    required this.updateTaskUseCase,
    required this.getSingleTaskUseCase,
  }) : super(UpdateTaskState());

  final UpdateTaskValidationUseCase validationUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final GetSingleTaskUseCase getSingleTaskUseCase;

  void getTaskData(int id) async {
    emit(state.copyWith(getTaskStatus: PageStatus.loading));
    final result = await getSingleTaskUseCase(id);
    if (result.hasDataOnly) {
      final task = result.data!;
      setTaskData(
        id: task.id,
        name: task.name,
        description: task.description,
        userId: task.userId,
        dueDate: task.dueDate,
        taskStatus: TaskStatusExtension.fromName(task.status),
      );
      emit(state.copyWith(getTaskStatus: PageStatus.success));
    } else {
      emit(
        state.copyWith(
          getTaskStatus: PageStatus.error,
          error: result.error.toString(),
        ),
      );
    }
  }

  void setTaskData({
    int? id,
    String? name,
    String? description,
    int? userId,
    TaskStatus? taskStatus,
    DateTime? dueDate,
  }) {
    emit(
      state.copyWith(
        id: id,
        name: name,
        description: description,
        taskStatus: taskStatus,
        dueDate: dueDate,
        userId: userId,
      ),
    );
  }

  Future<void> validateAndUpdateTask(int userId) async {
    final taskParams = UpdateTaskParams(
      id: state.id!,
      userId: userId,
      name: state.name,
      status: state.taskStatus.name,
      description: state.description,
      dueDate: state.dueDate ?? DateTime.now(),
    );
    final result = validationUseCase(taskParams);

    if (result.hasErrorOnly) {
      emit(
        state.copyWith(
          updateStatus: PageStatus.error,
          error: result.error.toString(),
          valid: false,
        ),
      );
      return;
    }
    emit(state.copyWith(updateStatus: PageStatus.loading, valid: true));

    final updateResult = await updateTaskUseCase(taskParams);

    if (updateResult.hasErrorOnly) {
      emit(
        state.copyWith(
          updateStatus: PageStatus.error,
          error: updateResult.error.toString(),
        ),
      );
      return;
    }

    emit(state.copyWith(updateStatus: PageStatus.success));
  }

  void resetErrorState() {
    emit(state.copyWith(error: '', updateStatus: PageStatus.init));
  }
}
