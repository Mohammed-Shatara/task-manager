part of 'delete_task_cubit.dart';

 class DeleteTaskState extends Equatable {
   const DeleteTaskState({ this.status = PageStatus.init,  this.error = ''});

   final PageStatus status;
   final String error;

   DeleteTaskState copyWith({
     PageStatus? status,
     String? error,
   }) {
     return DeleteTaskState(
       status: status ?? this.status,
       error: error ?? this.error,
     );
   }

   @override
   List<Object?> get props => [status, error];
}


