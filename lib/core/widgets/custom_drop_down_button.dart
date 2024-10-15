import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.labelStyle,
    this.validator,
    required this.value,
  });
  final String label;
  final TextStyle? labelStyle;
  final List<DropdownMenuItem<Object>>? items;
  final Function(Object?)? onChanged;
  final String? Function(Object?)? validator;
  final dynamic value;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(
        label,
        style: labelStyle,
      ),
      value: value,
      borderRadius: BorderRadius.circular(5),
      items: items,
      onChanged: onChanged,
      dropdownColor: const Color(0xff121212),
      focusColor: const Color(0xff121212),
      validator: validator,
      decoration: InputDecoration(
        fillColor: const Color(0xff121212),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xff121212)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xff121212)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xff121212)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xff121212)),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 15.w,
        ),
      ),
      isExpanded: true,
    );
  }
}
