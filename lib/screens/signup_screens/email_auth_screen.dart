import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:email_validator/email_validator.dart';
import 'package:go_router/go_router.dart';

class AppStrings {
  static const emailLabel = '이메일';
  static const emailHint = '이메일을 입력해주세요';
  static const emailInvalidFormat = '이메일 형식을 다시 확인해주세요';
  static const codeLabel = '인증번호';
  static const codeHint = '인증번호를 입력해주세요';
  static const codeInvalid = '인증번호가 일치하지 않습니다';
  static const resendCodeButton = '인증번호 재전송';
  static const nextButton = '다음';
  static const codeSentMessage = '인증번호가 전송되었습니다';
  static const codeExpiredMessage = '인증번호가 만료되었습니다';
  static const networkErrorMessage = '인증번호 전송에 실패했습니다';
  static const verifyEmailTitle = '이메일을 인증해주세요';
}

class EmailAuthScreen extends StatefulWidget {
  final String username;
  const EmailAuthScreen({super.key, required this.username});

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final FocusNode _codeFocusNode = FocusNode();
  Timer? _codeExpirationTimer;
  Timer? _countdownTimer;
  static const codeExpirationDuration = Duration(minutes: 5);

  bool isEmailValid = true;
  bool codeSent = false;
  bool isCodeMatched = true;
  bool isSendingCode = false;
  Duration timeRemaining = codeExpirationDuration;
  String get timerText =>
      '${(timeRemaining.inSeconds ~/ 60).toString().padLeft(1, '0')}:${(timeRemaining.inSeconds % 60).toString().padLeft(2, '0')}';

  static final TextStyle LABEL_STYLE = AppTypography.bodySmall.copyWith(
    fontSize: 16.sp,
    color: AppColor.black,
  );
  static final TextStyle ERROR_STYLE = AppTypography.bodySmall.copyWith(
    fontSize: 12.sp,
    color: AppColor.error,
  );
  static final TextStyle HINT_STYLE = AppTypography.bodySmall.copyWith(
    fontSize: 16.sp,
    color: AppColor.gray300,
  );
  static final TextStyle TIMER_STYLE = AppTypography.bodySmall.copyWith(
    fontSize: 14.sp,
    color: AppColor.black,
  );
  static final TextStyle RESEND_STYLE = AppTypography.bodySmall.copyWith(
    fontSize: 14.sp,
    color: AppColor.main,
    decoration: TextDecoration.underline,
  );

  @override
  void initState() {
    super.initState();
    emailController.addListener(onEmailChanged);
  }

  @override
  void dispose() {
    _codeExpirationTimer?.cancel();
    _countdownTimer?.cancel();
    _codeFocusNode.dispose();
    emailController.dispose();
    codeController.dispose();
    super.dispose();
  }

  void onEmailChanged() {
    final email = emailController.text.trim();
    setState(() {
      isEmailValid = email.isEmpty || EmailValidator.validate(email);
    });
  }

  void sendVerificationCode() {
    if (!isEmailValid || isSendingCode) return;

    setState(() => isSendingCode = true);
    try {
      setState(() {
        codeSent = true;
        isCodeMatched = true;
        codeController.clear();
        timeRemaining = codeExpirationDuration;
      });

      _codeExpirationTimer?.cancel();
      _countdownTimer?.cancel();
      _codeExpirationTimer = Timer(codeExpirationDuration, () {
        setState(() {
          codeSent = false;
          _countdownTimer?.cancel();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.codeExpiredMessage)),
          );
        });
      });

      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (timeRemaining.inSeconds > 0) {
            timeRemaining = timeRemaining - const Duration(seconds: 1);
          } else {
            timer.cancel();
          }
        });
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.codeSentMessage)));
      FocusScope.of(context).requestFocus(_codeFocusNode);
    } finally {
      setState(() => isSendingCode = false);
    }
  }

  void checkCodeMatch() {
    if (isSendingCode) return;

    setState(() => isSendingCode = true);
    try {
      if (codeController.text == "1234") {
        setState(() {
          isCodeMatched = true;
          _codeExpirationTimer?.cancel();
          _countdownTimer?.cancel();
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('인증번호가 확인되었습니다')));
        context.push(
          '/password-create',
          extra: {
            'username': widget.username,
            'email': emailController.text.trim(),
          },
        );
        return;
      }

      setState(() => isCodeMatched = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.codeInvalid)));
    } finally {
      setState(() => isSendingCode = false);
    }
  }

  bool get isNextEnabled {
    final canSendCode =
        isEmailValid && emailController.text.isNotEmpty && !codeSent;
    final canProceed = codeSent && codeController.text.length == 4;
    return canSendCode || canProceed;
  }

  void handleNextButton() {
    if (!codeSent && isEmailValid) {
      sendVerificationCode();
    } else if (codeSent && codeController.text.length == 4) {
      checkCodeMatch();
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isValid,
    TextInputType? keyboardType,
    FocusNode? focusNode,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final borderSide = BorderSide(
      color:
          controller.text.isNotEmpty
              ? (controller == emailController
                  ? (isEmailValid ? AppColor.main : AppColor.error)
                  : (isValid ? AppColor.main : AppColor.error))
              : AppColor.gray300,
      width: 1.w,
    );

    return SizedBox(
      width: 312.w,
      height: 58.h,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        focusNode: focusNode,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: HINT_STYLE,
          contentPadding: EdgeInsets.all(16.w),
          filled: true,
          fillColor: AppColor.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: borderSide,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: borderSide,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: borderSide,
          ),
          counterText: '',
        ),
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
                  ? AppColor.main
                  : AppColor.gray300,
          foregroundColor:
              onPressed != null && !isLoading
                  ? AppColor.white
                  : AppColor.gray600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide.none,
          ),
          elevation: 0,
        ),
        child:
            isLoading
                ? const CircularProgressIndicator(color: AppColor.white)
                : Text(
                  label,
                  style: AppTypography.bodyMedium.copyWith(
                    color:
                        onPressed != null && !isLoading
                            ? AppColor.white
                            : AppColor.gray600,
                  ),
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColor.black),
        backgroundColor: AppColor.white,
        elevation: 0,
        foregroundColor: AppColor.black,
      ),
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      AppStrings.verifyEmailTitle,
                      style: AppTypography.subTitle,
                    ),
                    SizedBox(height: 32.h),
                    Text(AppStrings.emailLabel, style: LABEL_STYLE),
                    SizedBox(height: 8.h),
                    buildTextField(
                      controller: emailController,
                      hintText: AppStrings.emailHint,
                      isValid: isEmailValid,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    if (emailController.text.isNotEmpty && !isEmailValid)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          AppStrings.emailInvalidFormat,
                          style: ERROR_STYLE,
                        ),
                      ),
                    SizedBox(height: 24.h),
                    if (codeSent) ...[
                      Row(
                        children: [
                          Text(AppStrings.codeLabel, style: LABEL_STYLE),
                          SizedBox(width: 8.w),
                          Text(timerText, style: TIMER_STYLE),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      buildTextField(
                        controller: codeController,
                        hintText: AppStrings.codeHint,
                        isValid: isCodeMatched,
                        keyboardType: TextInputType.number,
                        focusNode: _codeFocusNode,
                        maxLength: 4,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      if (codeController.text.isNotEmpty && !isCodeMatched)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            AppStrings.codeInvalid,
                            style: ERROR_STYLE,
                          ),
                        ),
                      SizedBox(height: 8.h),
                      TextButton(
                        onPressed: sendVerificationCode,
                        child: Text(
                          AppStrings.resendCodeButton,
                          style: RESEND_STYLE,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: buildButton(
                label: AppStrings.nextButton,
                onPressed: isNextEnabled ? handleNextButton : null,
                isLoading: isSendingCode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
