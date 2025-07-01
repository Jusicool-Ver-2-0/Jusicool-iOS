import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final bool hasError;
  final String errorMessage;
  final bool obscureText;
  final Function(String) onChanged;
  final double width;
  final double height;
  final InputDecoration Function(String, bool) getInputDecoration;
  final bool showLoginError;
  final VoidCallback clearLoginError;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    required this.hasError,
    required this.errorMessage,
    this.obscureText = false,
    required this.onChanged,
    required this.width,
    required this.height,
    required this.getInputDecoration,
    required this.showLoginError,
    required this.clearLoginError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: JusicoolTypography.bodySmall.copyWith(
            fontSize: 16.sp,
            color: hasError ? JusicoolColor.error : JusicoolColor.black,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: width,
          height: height,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            onChanged: (value) {
              onChanged(value);
              if (showLoginError) {
                clearLoginError();
              }
            },
            decoration: getInputDecoration(hint, hasError || showLoginError),
          ),
        ),
        if (hasError && errorMessage.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: SizedBox(
              width: width,
              child: Text(
                errorMessage,
                textAlign: TextAlign.right,
                style: JusicoolTypography.bodySmall.copyWith(
                  color: JusicoolColor.error,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
