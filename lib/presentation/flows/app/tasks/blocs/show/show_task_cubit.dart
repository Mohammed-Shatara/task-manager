import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/blocs/app_bloc/app_bloc.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../../../../../../domain/use_cases/tasks/get_single_task_use_case.dart';

part 'show_task_state.dart';

class ShowTaskCubit extends Cubit<ShowState> {
  ShowTaskCubit({required this.getSingleTaskUseCase}) : super(ShowState());

  final GetSingleTaskUseCase getSingleTaskUseCase;

  void getSingleTaskData(int id) async {
    emit(state.copyWith(status: PageStatus.loading));
    final result = await getSingleTaskUseCase(id);
    if (result.hasDataOnly) {
      emit(state.copyWith(status: PageStatus.success, taskModel: result.data));
    } else {
      emit(
        state.copyWith(
          status: PageStatus.error,
          error: result.error.toString(),
        ),
      );
    }
  }
}
