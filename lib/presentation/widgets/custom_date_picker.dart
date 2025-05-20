import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerFormField extends StatefulWidget {
  final DateTime? initialValue;
  final Function(DateTime date) onDateTimeChanged;
  final String? Function(String? value)? validator;

  const DateTimePickerFormField({
    super.key,
    this.initialValue,
    this.validator,
    required this.onDateTimeChanged,
  });

  @override
  State<DateTimePickerFormField> createState() =>
      _DateTimePickerFormFieldState();
}

class _DateTimePickerFormFieldState extends State<DateTimePickerFormField> {
  late TextEditingController _controller;
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialValue;
    _controller = TextEditingController(
      text: _formatDateTime(_selectedDateTime),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('d/MMM/y – h:mm a').format(dateTime);
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? now),
    );

    if (pickedTime == null) return;

    final fullDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      _selectedDateTime = fullDateTime;
      _controller.text = _formatDateTime(fullDateTime);
    });

    widget.onDateTimeChanged(fullDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Due Date',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xff242424),
            fontFamily: 'roboto',
          ),
        ),
        TextFormField(
          controller: _controller,
          readOnly: true,
          validator: widget.validator,
          style: TextStyle(
            color: Color(0xff242424),
            fontSize: 13,
            fontFamily: 'roboto',
          ),

          onTap: _pickDateTime,
          autovalidateMode: AutovalidateMode.always,
          decoration: const InputDecoration(
            hintText: 'Due Date & Time',
            prefixIcon: Icon(
              Icons.calendar_today,
              color: Color(0xff797979),
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
