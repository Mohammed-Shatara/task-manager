import 'package:flutter/material.dart';

class LabeledTextField extends StatefulWidget {
  const LabeledTextField({
    super.key,
    required this.label,
    this.password = false,
    this.suffixText,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.phoneCode,
    this.phone = false,
    this.hint,
    this.initialValue,
    this.keyboardType,
    this.textDirection,
    this.validator,
    this.onFieldSubmitted
  });

  final String label;
  final String? hint;
  final String? initialValue;
  final bool password;
  final bool phone;
  final Widget? phoneCode;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? suffixText;
  final Function(String val)? onChanged;
  final TextDirection? textDirection;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onFieldSubmitted;

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    final isRtl = Localizations.localeOf(context).languageCode == 'ar';
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xff242424),
            fontFamily: 'roboto',
          ),
        ),
        TextFormField(
          maxLines: widget.maxLines,
          initialValue: widget.initialValue,
          style: TextStyle(
            color: Color(0xff242424),
            fontSize: 13,
            fontFamily: 'roboto',
          ),
          cursorHeight: 18,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          textDirection: widget.textDirection,
          onChanged: widget.onChanged,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixText: widget.suffixText,
            prefixIcon: widget.phone && !isRtl ? widget.phoneCode : null,
            //suffixStyle: TextStyle(color: Colors.red),
            suffixIcon:
                widget.password
                    ? IconButton(
                      color: Color(0xff242424),
                      iconSize: 18,
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      icon: Icon(
                        show
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    )
                    : widget.phone && isRtl
                    ? widget.phoneCode
                    : null,
          ),
          // onChanged: widget.onChanged,
          obscureText: widget.password ? show : false,
          autovalidateMode: AutovalidateMode.always,
        ),
      ],
    );
  }
}
