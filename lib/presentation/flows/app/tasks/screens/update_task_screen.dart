import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/app/di.dart';
import 'package:task_manager/core/blocs/app_bloc/app_bloc.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/presentation/flows/app/tasks/blocs/update/update_task_cubit.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/validators/base_validator.dart';
import '../../../../../core/validators/required_validator.dart';
import '../../../../widgets/custom_date_picker.dart';
import '../../../../widgets/labeled_text_field.dart';
import '../widgets/task_status_dropdown.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({super.key});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final bloc = locator<UpdateTaskCubit>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id = GoRouterState.of(context).pathParameters['taskId'];
      bloc.getTaskData(int.parse(id!));
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Tasks"),
        actions: [
          BlocListener<UpdateTaskCubit, UpdateTaskState>(
            bloc: bloc,
            listenWhen:
                (previous, current) =>
                    previous.updateStatus != current.updateStatus,
            listener: (context, state) {
              if (state.updateStatus == PageStatus.error) {
                toastification.show(
                  context: context,
                  style: ToastificationStyle.flatColored,
                  alignment: Alignment.bottomCenter,
                  type: ToastificationType.error,
                  title: Text(state.error),
                  autoCloseDuration: const Duration(seconds: 2),
                );
                bloc.resetErrorState();
              } else if (state.updateStatus == PageStatus.success) {
                toastification.show(
                  context: context,
                  style: ToastificationStyle.flatColored,
                  alignment: Alignment.bottomCenter,
                  type: ToastificationType.success,
                  title: Text('Task Updated Successfully'),
                  autoCloseDuration: const Duration(seconds: 2),
                );
                context.pop(true);
              }
            },
            child: TextButton(
              onPressed: () {
                final userId = locator<AppBloc>().user?.id;
                if (userId != null) {
                  bloc.validateAndUpdateTask(userId);
                }
              },
              child: Text(
                'Save',
                style: TextTheme.of(context).bodyLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(right: 24, left: 24, bottom: 42, top: 24),

        child: SizedBox(
          width: double.infinity,

          child: BlocConsumer<UpdateTaskCubit, UpdateTaskState>(
            bloc: bloc,
            listener: (context, state) {
              // nameController.text = state.name;
              // descController.text = state.description??'';
            },
            builder: (context, state) {
              if (state.getTaskStatus == PageStatus.loading ||
                  state.getTaskStatus == PageStatus.init) {
                return CircularProgressIndicator();
              }
              print('state.name: ${state.name}');
              return Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabeledTextField(
                    initialValue: state.name,
                    // controller: nameController,
                    label: 'Task Name',
                    hint: "Name",
                    keyboardType: TextInputType.name,
                    onChanged: (text) {
                      bloc.setTaskData(name: text.trim());
                    },
                    validator: (value) {
                      return BaseValidator.validateValue(value, [
                        locator<RequiredValidator>(),
                        locator<MinimumValidator>(),
                      ], state.valid != null);
                    },
                  ),
                  LabeledTextField(
                    // controller: descController,
                    initialValue: state.description,

                    label: 'Task Description',
                    hint: "Description",
                    maxLength: 500,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onChanged: (text) {
                      bloc.setTaskData(description: text.trim());
                    },
                  ),

                  DateTimePickerFormField(
                    initialValue: state.dueDate,

                    onDateTimeChanged: (date) {
                      bloc.setTaskData(dueDate: date);
                    },
                    validator: (value) {
                      return BaseValidator.validateValue(value, [
                        locator<RequiredValidator>(),
                      ], state.valid != null);
                    },
                  ),

                  TaskStatusDropdown(
                    value: state.taskStatus,
                    onChanged: (value) {
                      bloc.setTaskData(taskStatus: value);
                    },
                    validator: (value) {
                      return BaseValidator.validateValue(value, [
                        locator<RequiredValidator>(),
                      ], state.valid != null);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
