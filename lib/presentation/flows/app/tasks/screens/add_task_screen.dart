import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/app/di.dart';
import 'package:task_manager/core/blocs/app_bloc/app_bloc.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/presentation/flows/app/tasks/blocs/create/create_task_cubit.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/validators/base_validator.dart';
import '../../../../../core/validators/required_validator.dart';
import '../../../../widgets/custom_date_picker.dart';
import '../../../../widgets/labeled_text_field.dart';
import '../widgets/task_status_dropdown.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final bloc = locator<CreateTaskCubit>();

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
          BlocListener<CreateTaskCubit, CreateTaskState>(
            bloc: bloc,
            listener: (context, state) {
              if (state.pageStatus == PageStatus.error) {
                toastification.show(
                  context: context,
                  style: ToastificationStyle.flatColored,
                  alignment: Alignment.bottomCenter,
                  type: ToastificationType.error,
                  title: Text(state.error),
                  autoCloseDuration: const Duration(seconds: 2),
                );
                bloc.resetErrorState();
              } else if (state.pageStatus == PageStatus.success) {
                toastification.show(
                  context: context,
                  style: ToastificationStyle.flatColored,
                  alignment: Alignment.bottomCenter,
                  type: ToastificationType.success,
                  title: Text('Task Created Successfully'),
                  autoCloseDuration: const Duration(seconds: 2),
                );
                context.pop(true);
              }
            },
            child: TextButton(
              onPressed: () {
                final userId = locator<AppBloc>().user?.id;
                final fullName = locator<AppBloc>().user?.fullname;
                if (userId != null) {
                  bloc.validateAndCreateTask(userId, fullName);
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

          child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
            bloc: bloc,
            builder: (context, state) {
              return Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabeledTextField(
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
                    onDateTimeChanged: (date) {
                      bloc.setTaskData(dueDate: date);
                    },
                    validator: (value) {
                      return BaseValidator.validateValue(value, [
                        locator<RequiredValidator>(),
                        locator<DateAsStringValidator>(),
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
