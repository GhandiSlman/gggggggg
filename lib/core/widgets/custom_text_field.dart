import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final int? maxLine;
  final int? minLine;
  final bool? filled;
  final Color? filledColor;
  final Widget? suffix;
  final bool readOnly;
  final Function()? onSuffixTap;
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.hint,
    this.readOnly = false,
    this.suffix,
    this.filledColor,
    this.minLine,
    this.onChanged,
    this.maxLine,
    this.filled,
    this.keyboardType,
    this.controller,
    this.onSuffixTap,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLine,
      minLines: minLine,
      readOnly: readOnly,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffix,
        suffixIconColor: AppColor.amber2Color,
        hintText: hint,
        fillColor: filledColor,
        filled: filled,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColor.greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColor.primaryColor),
        ),
      ),
    );
  }
}
