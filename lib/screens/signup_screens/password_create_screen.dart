import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_ios/screens/signup_screens/find_school_screen.dart';

class PasswordCreateScreen extends StatefulWidget {
  const PasswordCreateScreen({super.key});

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

  static const double FIELD_HEIGHT = 58.0;
  static const double BUTTON_HEIGHT = 54.0;

  static final TextStyle TITLE_STYLE = AppTypography.bodyMedium.copyWith(
    fontSize: 18.sp,
    color: AppColor.black,
  );
  static final TextStyle LABEL_STYLE = AppTypography.bodySmall.copyWith(
    fontSize: 16.sp,
  );
  static final TextStyle ERROR_STYLE = AppTypography.bodySmall.copyWith(
    fontSize: 12.sp,
    color: AppColor.error,
  );
  static final TextStyle HINT_STYLE = AppTypography.bodySmall.copyWith(
    fontSize: 16.sp,
    color: AppColor.gray300,
  );

  @override
  void initState() {
    super.initState();
    passwordController.addListener(onPasswordChanged);
    confirmPasswordController.addListener(onConfirmPasswordChanged);
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

    int satisfiedConditions =
        [hasLetter, hasNumber, hasSpecial].where((e) => e).length;
    return satisfiedConditions >= 2;
  }

  void onNextButtonPressed() {
    print('비밀번호: ${passwordController.text}');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FindSchoolScreen()),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isValid,
  }) {
    return SizedBox(
      height: FIELD_HEIGHT.h,
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: HINT_STYLE,
          contentPadding: EdgeInsets.all(16.w),
          filled: true,
          fillColor: AppColor.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: isValid ? AppColor.gray300 : AppColor.error,
              width: 1.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: isValid ? AppColor.gray300 : AppColor.error,
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: isValid ? AppColor.main : AppColor.error,
              width: 2.w,
            ),
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
        leading: BackButton(),
        backgroundColor: AppColor.white,
        elevation: 0,
      ),
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar 바로 아래에 딱 붙는 타이틀
            SizedBox(height: 8.h), // 살짝만 띄움 (너무 붙으면 답답할 수 있어서)
            Text('비밀번호를 입력해주세요', style: TITLE_STYLE),
            SizedBox(height: 32.h),

            // 비밀번호 입력 필드
            Text(
              '비밀번호',
              style: LABEL_STYLE.copyWith(
                color: isPasswordValid ? AppColor.black : AppColor.error,
              ),
            ),
            SizedBox(height: 8.h),
            buildTextField(
              controller: passwordController,
              hintText: '비밀번호를 입력해주세요',
              isValid: isPasswordValid,
            ),
            if (!isPasswordValid)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  '영문, 숫자, 특수문자 중 2개 이상의 조합으로 8글자 이상 13글자 이하',
                  style: ERROR_STYLE,
                ),
              ),
            SizedBox(height: 24.h),

            // 비밀번호 재입력 필드
            Text(
              '비밀번호 재 입력',
              style: LABEL_STYLE.copyWith(
                color: isPasswordMatched ? AppColor.black : AppColor.error,
              ),
            ),
            SizedBox(height: 8.h),
            buildTextField(
              controller: confirmPasswordController,
              hintText: '비밀번호를 다시 입력해주세요',
              isValid: isPasswordMatched,
            ),
            if (!isPasswordMatched)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text('비밀번호가 일치하지 않아요', style: ERROR_STYLE),
              ),
            SizedBox(height: 48.h),

            // 다음 버튼
            SizedBox(
              width: double.infinity,
              height: BUTTON_HEIGHT.h,
              child: ElevatedButton(
                onPressed: isButtonEnabled ? onNextButtonPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isButtonEnabled ? AppColor.main : AppColor.gray300,
                  foregroundColor:
                      isButtonEnabled ? AppColor.white : AppColor.gray600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(
                      color: isButtonEnabled ? AppColor.main : AppColor.gray100,
                      width: 1.w,
                    ),
                  ),
                ),
                child: Text(
                  '다음',
                  style: AppTypography.bodyMedium.copyWith(
                    color: isButtonEnabled ? AppColor.white : AppColor.gray600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
