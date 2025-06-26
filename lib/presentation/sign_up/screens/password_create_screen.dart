import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:go_router/go_router.dart';

class PasswordCreateScreen extends StatefulWidget {
  final String username;
  final String email;

  const PasswordCreateScreen({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  State<PasswordCreateScreen> createState() => _PasswordCreateScreenState();
}

class _PasswordCreateScreenState extends State<PasswordCreateScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isFormFilled = false;
  bool isPasswordValid = true;
  bool isPasswordMatched = true;

  static final TextStyle titleStyle = JusicoolTypography.bodyMedium.copyWith(
    fontSize: 18.sp,
    color: JusicoolColor.black,
  );
  static final TextStyle labelStyle = JusicoolTypography.bodySmall.copyWith(
    fontSize: 16.sp,
    color: JusicoolColor.black,
  );
  static final TextStyle errorStyle = JusicoolTypography.bodySmall.copyWith(
    fontSize: 12.sp,
    color: JusicoolColor.error,
  );
  static final TextStyle hintStyle = JusicoolTypography.bodySmall.copyWith(
    fontSize: 16.sp,
    color: JusicoolColor.gray300,
  );

  @override
  void initState() {
    super.initState();
    passwordController.addListener(onPasswordChanged);
    confirmPasswordController.addListener(onConfirmPasswordChanged);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: JusicoolColor.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: JusicoolColor.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void onPasswordChanged() {
    validatePassword(passwordController.text);
    updateFormState();
    checkPasswordsMatch();
  }

  void onConfirmPasswordChanged() {
    updateFormState();
    checkPasswordsMatch();
  }

  void updateFormState() {
    setState(() {
      isFormFilled =
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty;
    });
  }

  void validatePassword(String password) {
    setState(() {
      isPasswordValid = isValidPassword(password);
    });
  }

  void checkPasswordsMatch() {
    setState(() {
      isPasswordMatched =
          passwordController.text == confirmPasswordController.text;
    });
  }

  bool isValidPassword(String password) {
    if (password.length < 8 || password.length > 13) return false;

    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    final hasNumber = RegExp(r'\d').hasMatch(password);
    final hasSpecial = RegExp(r'[@$!%*?&]').hasMatch(password);

    int count = [hasLetter, hasNumber, hasSpecial].where((e) => e).length;
    return count >= 2;
  }

  void onNextButtonPressed() {
    context.push(
      '/find-school',
      extra: {
        'username': widget.username,
        'email': widget.email,
        'password': passwordController.text,
      },
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isValid,
  }) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: EdgeInsets.all(16.w),
        filled: true,
        fillColor: JusicoolColor.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: isValid ? JusicoolColor.gray300 : JusicoolColor.error,
            width: 1.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: isValid ? JusicoolColor.gray300 : JusicoolColor.error,
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: isValid ? JusicoolColor.main : JusicoolColor.error,
            width: 2.w,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled =
        isFormFilled && isPasswordValid && isPasswordMatched;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: JusicoolColor.black),
        backgroundColor: JusicoolColor.white,
        elevation: 0,
      ),
      backgroundColor: JusicoolColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text('비밀번호를 입력해주세요', style: titleStyle),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Text(
                  '비밀번호',
                  style: labelStyle.copyWith(
                    color:
                        isPasswordValid
                            ? JusicoolColor.black
                            : JusicoolColor.error,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: buildTextField(
                  controller: passwordController,
                  hintText: '비밀번호를 입력해주세요',
                  isValid: isPasswordValid,
                ),
              ),
              if (!isPasswordValid)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    '영문, 숫자, 특수문자 중 2개 이상 조합으로 8~13자',
                    style: errorStyle,
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: Text(
                  '비밀번호 재 입력',
                  style: labelStyle.copyWith(
                    color:
                        isPasswordMatched
                            ? JusicoolColor.black
                            : JusicoolColor.error,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: buildTextField(
                  controller: confirmPasswordController,
                  hintText: '비밀번호를 다시 입력해주세요',
                  isValid: isPasswordMatched,
                ),
              ),
              if (!isPasswordMatched)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text('비밀번호가 일치하지 않아요', style: errorStyle),
                ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Container(
                  width: double.infinity,
                  height: 54.h,
                  child: ElevatedButton(
                    onPressed: isButtonEnabled ? onNextButtonPressed : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isButtonEnabled
                              ? JusicoolColor.main
                              : JusicoolColor.gray300,
                      foregroundColor:
                          isButtonEnabled
                              ? JusicoolColor.white
                              : JusicoolColor.gray600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      '다음',
                      style: JusicoolTypography.bodyMedium.copyWith(
                        color:
                            isButtonEnabled
                                ? JusicoolColor.white
                                : JusicoolColor.gray600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
