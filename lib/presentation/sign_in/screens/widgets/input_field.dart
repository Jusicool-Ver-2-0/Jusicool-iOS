import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final String errorMessage;
  final bool hasError;
  final bool obscureText;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.errorMessage = "",
    this.hasError = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: JusicoolTypography.bodySmall.copyWith(
            fontSize: 16.sp,
            color: hasError ? JusicoolColor.error : JusicoolColor.black,
          ),
        ),
        SizedBox.shrink(),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          cursorColor: JusicoolColor.main,
          cursorErrorColor: JusicoolColor.error,
          decoration: getInputDecoration(hint, hasError),
        ),
        if (hasError && errorMessage.isNotEmpty)
          Text(
            errorMessage,
            textAlign: TextAlign.right,
            style: JusicoolTypography.bodySmall.copyWith(
              color: JusicoolColor.error,
              fontSize: 12.sp,
            ),
          ),
      ],
    );
  }

  InputDecoration getInputDecoration(String hint, bool hasError) {
    return InputDecoration(
      hintText: hint,
      hintStyle: JusicoolTypography.bodySmall.copyWith(
        color: hasError ? JusicoolColor.error : JusicoolColor.gray500,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: hasError ? JusicoolColor.error : JusicoolColor.gray300,
          width: 1.w,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: hasError ? JusicoolColor.error : JusicoolColor.main,
          width: 2.w,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: JusicoolColor.error, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: JusicoolColor.error, width: 2.w),
      ),
    );
  }
}
