import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_ios/core/config/router/router.dart';
import '../controller/sign_up_email_controller.dart';

class EmailAuthScreen extends ConsumerWidget {
  const EmailAuthScreen({super.key});

  String formatTimer(Duration duration) {
    final minutes = duration.inSeconds ~/ 60;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isValid,
    TextInputType? keyboardType,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final borderSide = BorderSide(
      color: isValid ? JusicoolColor.main : JusicoolColor.error,
      width: 2.w,
    );

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: JusicoolTypography.bodySmall.copyWith(
          fontSize: 16.sp,
          color: JusicoolColor.gray300,
        ),
        contentPadding: EdgeInsets.all(16.w),
        filled: true,
        fillColor: JusicoolColor.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: isValid ? JusicoolColor.gray200 : JusicoolColor.error,
            width: 2.w,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: isValid ? JusicoolColor.gray200 : JusicoolColor.error,
            width: 2.w,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: borderSide,
        ),
        counterText: '',
      ),
    );
  }

  Widget buildButton({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              onPressed != null && !isLoading
                  ? JusicoolColor.main
                  : JusicoolColor.gray300,
          foregroundColor:
              onPressed != null && !isLoading
                  ? JusicoolColor.white
                  : JusicoolColor.gray600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child:
            isLoading
                ? const CircularProgressIndicator(color: JusicoolColor.white)
                : Text(
                  label,
                  style: JusicoolTypography.bodyMedium.copyWith(
                    color:
                        onPressed != null && !isLoading
                            ? JusicoolColor.white
                            : JusicoolColor.gray600,
                  ),
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(emailAuthControllerProvider.notifier);
    final state = ref.watch(emailAuthControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15.w, top: 20.h),
          child: const BackButton(),
        ),
        backgroundColor: JusicoolColor.white,
        elevation: 0,
      ),
      backgroundColor: JusicoolColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 56.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        '이메일을 인증해주세요',
                        style: JusicoolTypography.subTitle,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '이메일',
                          style: JusicoolTypography.bodySmall.copyWith(
                            fontSize: 16.sp,
                            color: JusicoolColor.black,
                          ),
                        ),
                        buildTextField(
                          controller: controller.emailController,
                          hintText: '이메일을 입력해주세요',
                          isValid: state.isEmailValid,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        if (controller.emailController.text.isNotEmpty &&
                            !state.isEmailValid)
                          Text(
                            state.errorMessage ?? '올바른 이메일 형식이 아닙니다',
                            style: JusicoolTypography.bodySmall.copyWith(
                              fontSize: 12.sp,
                              color: JusicoolColor.error,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    if (state.codeSent)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '인증번호',
                                style: JusicoolTypography.bodySmall.copyWith(
                                  fontSize: 16.sp,
                                  color: JusicoolColor.black,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                formatTimer(state.timeRemaining),
                                style: JusicoolTypography.bodySmall.copyWith(
                                  fontSize: 14.sp,
                                  color: JusicoolColor.black,
                                ),
                              ),
                            ],
                          ),
                          buildTextField(
                            controller: controller.codeController,
                            hintText: '인증번호를 입력해주세요',
                            isValid: state.isCodeMatched,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          if (controller.codeController.text.isNotEmpty &&
                              !state.isCodeMatched)
                            Text(
                              '인증번호가 일치하지 않습니다',
                              style: JusicoolTypography.bodySmall.copyWith(
                                fontSize: 12.sp,
                                color: JusicoolColor.error,
                              ),
                            ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: controller.sendEmail,
                              child: Text(
                                '인증번호 재전송',
                                style: JusicoolTypography.bodySmall.copyWith(
                                  fontSize: 14.sp,
                                  color: JusicoolColor.main,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
              child: buildButton(
                label: '다음',
                onPressed:
                    state.enableButton
                        ? state.codeSent
                            ? () {
                              bool result = controller.sendVerificationCode(
                              );
                              if (result) {
                                context.push(RoutePaths.passwordCreate);
                              }
                            }
                            : controller.sendEmail
                        : null,
                isLoading: state.isSendingCode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
