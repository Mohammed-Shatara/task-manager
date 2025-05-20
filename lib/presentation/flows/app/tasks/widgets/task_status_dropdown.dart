import 'package:flutter/material.dart';

import '../blocs/create/create_task_cubit.dart';

class TaskStatusDropdown extends StatelessWidget {
  final TaskStatus? value;
  final Function(TaskStatus?) onChanged;
  final String? Function(String? value)? validator;

  const TaskStatusDropdown({
    super.key,
    this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xff242424),
            fontFamily: 'roboto',
          ),
        ),
        DropdownButtonFormField<TaskStatus>(
          value: value,
          style: TextStyle(
            color: Color(0xff242424),
            fontSize: 13,
            fontFamily: 'roboto',
          ),

          decoration: const InputDecoration(
            hintText: 'Status',
            prefixIcon: Icon(Icons.flag, color: Color(0xff797979)),
          ),
          items:
              TaskStatus.values.map((status) {
                return DropdownMenuItem<TaskStatus>(
                  value: status,
                  child: Text(status.label),
                );
              }).toList(),
          validator:
              validator != null
                  ? (value) {
                    return validator!(value.toString());
                  }
                  : null,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
