import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_ios/screens/signup_screens/password_create_screen.dart';
import 'package:email_validator/email_validator.dart';

// 문자열 상수 (지역화 지원)
class AppStrings {
  static const emailLabel = '이메일';
  static const emailHint = '이메일을 입력해주세요';
  static const emailInvalidFormat = '이메일 형식을 다시 확인해주세요';
  static const emailTaken = '중복된 이메일입니다';
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
  const EmailAuthScreen({super.key});

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final FocusNode _codeFocusNode = FocusNode();
  Timer? _codeExpirationTimer;
  Timer? _debounceTimer;
  Timer? _countdownTimer;
  static const codeExpirationDuration = Duration(minutes: 5);

  final List<String> dummyRegisteredEmails = [
    'test@example.com',
    'user@mail.com',
  ];

  bool isEmailValid = true;
  bool isEmailUnique = true;
  bool codeSent = false;
  bool isCodeMatched = true;
  bool isSendingCode = false;
  String generatedCode = '';
  Duration timeRemaining = codeExpirationDuration;
  String get timerText =>
      '${(timeRemaining.inSeconds ~/ 60).toString().padLeft(1, '0')}:${(timeRemaining.inSeconds % 60).toString().padLeft(2, '0')}';

  static const double FIELD_HEIGHT = 48.0;
  static const double BUTTON_HEIGHT = 54.0;

  // 스타일 정의
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
    codeController.addListener(onCodeChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _codeExpirationTimer?.cancel();
    _countdownTimer?.cancel();
    _codeFocusNode.dispose();
    emailController.dispose();
    codeController.dispose();
    super.dispose();
  }

  void onEmailChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      validateEmail();
      print(
        "이메일 입력: ${emailController.text}, 유효성: $isEmailValid, 중복 없음: $isEmailUnique",
      );
    });
  }

  void onCodeChanged() {
    if (codeSent && codeController.text.length == 6) {
      checkCodeMatch();
      print("입력된 코드: ${codeController.text}, 일치 여부: $isCodeMatched");
    }
  }

  void validateEmail() {
    final email = emailController.text.trim();
    setState(() {
      isEmailValid = email.isEmpty || EmailValidator.validate(email);
      isEmailUnique = email.isEmpty || !dummyRegisteredEmails.contains(email);
    });
  }

  Future<void> sendVerificationCode() async {
    if (!isEmailValid || !isEmailUnique) {
      return;
    }

    setState(() {
      isSendingCode = true;
    });
    try {
      // TODO: 실제 백엔드 API 호출로 교체
      await Future.delayed(const Duration(seconds: 1));
      final random = Random();
      generatedCode = List.generate(6, (_) => random.nextInt(10)).join();
      print("생성된 인증 코드: $generatedCode");

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
          generatedCode = '';
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.networkErrorMessage)),
      );
    } finally {
      setState(() {
        isSendingCode = false;
      });
    }
  }

  void checkCodeMatch() {
    setState(() {
      isCodeMatched = codeController.text == generatedCode;
      if (isCodeMatched) {
        _codeExpirationTimer?.cancel();
        _countdownTimer?.cancel();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('인증번호가 확인되었습니다')));
      }
    });
  }

  bool get isNextEnabled {
    final canSendCode =
        isEmailValid &&
        isEmailUnique &&
        emailController.text.isNotEmpty &&
        !codeSent;
    final canProceed =
        isEmailValid &&
        isEmailUnique &&
        codeSent &&
        isCodeMatched &&
        codeController.text.length == 6;
    return canSendCode || canProceed;
  }

  void handleNextButton() {
    if (!codeSent && isEmailValid && isEmailUnique) {
      sendVerificationCode();
    } else if (codeSent && isCodeMatched && codeController.text.length == 6) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PasswordCreateScreen()),
      );
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
    BorderSide borderSide = BorderSide.none;
    if (controller.text.isNotEmpty) {
      if (controller == emailController) {
        borderSide = BorderSide(
          color: isEmailValid && isEmailUnique ? AppColor.main : AppColor.error,
          width: 2.w,
        );
      } else {
        borderSide = BorderSide(
          color: isValid ? AppColor.main : AppColor.error,
          width: 2.w,
        );
      }
    }

    return Semantics(
      label: hintText,
      child: SizedBox(
        height: FIELD_HEIGHT.h,
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          focusNode: focusNode,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: HINT_STYLE,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            filled: true,
            fillColor: AppColor.gray100,
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
      ),
    );
  }

  Widget buildButton({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return Semantics(
      button: true,
      label: label,
      child: SizedBox(
        width: double.infinity,
        height: BUTTON_HEIGHT.h,
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
      body: Column(
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

                  // 이메일 입력
                  Text(AppStrings.emailLabel, style: LABEL_STYLE),
                  SizedBox(height: 8.h),
                  buildTextField(
                    controller: emailController,
                    hintText: AppStrings.emailHint,
                    isValid: isEmailValid && isEmailUnique,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  if (emailController.text.isNotEmpty &&
                      (!isEmailValid || !isEmailUnique))
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        !isEmailValid
                            ? AppStrings.emailInvalidFormat
                            : AppStrings.emailTaken,
                        style: ERROR_STYLE,
                      ),
                    ),
                  SizedBox(height: 24.h),

                  // 인증 코드 섹션
                  if (codeSent) ...[
                    SizedBox(height: 16.h),
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
                      maxLength: 6,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (codeController.text.isNotEmpty && !isCodeMatched)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              AppStrings.codeInvalid,
                              style: ERROR_STYLE,
                            ),
                          ),
                        const Spacer(),
                        TextButton(
                          onPressed: sendVerificationCode,
                          child: Text(
                            AppStrings.resendCodeButton,
                            style: RESEND_STYLE,
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
          // 다음 버튼 (화면 하단에 고정)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: buildButton(
              label: AppStrings.nextButton,
              onPressed: isNextEnabled ? handleNextButton : null,
              isLoading: isSendingCode,
            ),
          ),
        ],
      ),
    );
  }
}
