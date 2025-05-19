import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/blocs/app_bloc/app_bloc.dart';

import '../../../../../../domain/use_cases/tasks/create_task_use_case.dart';
import '../../../../../../domain/use_cases/tasks/validations/task_validation_use_case.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit({required this.validationUseCase, required this.createTaskUseCase})
    : super(CreateTaskState());

  final TaskValidationUseCase validationUseCase;
  final CreateTaskUseCase createTaskUseCase;

  void setTaskData({
    String? name,
    String? description,
    int? userId,
    TaskStatus? taskStatus,
    DateTime? dueDate,
  }) {
    emit(
      state.copyWith(
        name: name,
        description: description,
        taskStatus: taskStatus,
        dueDate: dueDate,
        userId: userId,
      ),
    );
  }

  Future<void> validateAndCreateTask() async {

    final taskParams = TaskParams(
      userId: state.userId ?? 0,
      name: state.name,
      status: state.taskStatus.name,
      dueDate: state.dueDate ?? DateTime.now(),
    );
    final result = validationUseCase(taskParams);

    if (result.hasErrorOnly) {
      emit(
        state.copyWith(pageStatus: PageStatus.error, error: result.error.toString(), valid: false),
      );
      return;
    }
    emit(state.copyWith(pageStatus: PageStatus.loading, valid: true));

    final createResult = await createTaskUseCase(taskParams);

    if (createResult.hasErrorOnly) {
      emit(state.copyWith(pageStatus: PageStatus.error, error: createResult.error.toString()));
      return;
    }

    emit(state.copyWith(pageStatus: PageStatus.success));
  }
}
