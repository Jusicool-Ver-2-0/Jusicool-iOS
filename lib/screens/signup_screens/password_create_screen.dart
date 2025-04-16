import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_ios/screens/signup_screens/find_school_screen.dart';

// 비밀번호 생성 화면
class PasswordCreateScreen extends StatefulWidget {
  const PasswordCreateScreen({super.key});

  @override
  State<PasswordCreateScreen> createState() => _PasswordCreateScreenState();
}

class _PasswordCreateScreenState extends State<PasswordCreateScreen> {
  // 텍스트 필드 컨트롤러
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // 상태 변수
  bool isFormFilled = false; // 양쪽 필드가 모두 채워졌는지 여부
  bool isPasswordValid = true; // 비밀번호 유효성 여부
  bool isPasswordMatched = true; // 비밀번호 일치 여부

  // 상수 정의
  static const double HORIZONTAL_PADDING = 24.0;
  static const double TITLE_TOP = 112.0;
  static const double PASSWORD_LABEL_TOP = 179.0;
  static const double PASSWORD_FIELD_TOP = 209.0;
  static const double PASSWORD_ERROR_TOP = 271.0;
  static const double CONFIRM_LABEL_TOP = 295.0;
  static const double CONFIRM_FIELD_TOP = 325.0;
  static const double CONFIRM_ERROR_TOP = 387.0;
  static const double BUTTON_TOP = 690.0;
  static const double FIELD_WIDTH = 312.0;
  static const double FIELD_HEIGHT = 58.0;
  static const double BUTTON_WIDTH = 312.0;
  static const double BUTTON_HEIGHT = 54.0;

  // 스타일 상수
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
    // 텍스트 필드 변경 리스너 추가
    passwordController.addListener(onPasswordChanged);
    confirmPasswordController.addListener(onConfirmPasswordChanged);
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // 비밀번호 입력값 변경 시 호출
  void onPasswordChanged() {
    validatePassword(passwordController.text);
    updateFormState();
    checkPasswordsMatch();
  }

  // 비밀번호 확인 입력값 변경 시 호출
  void onConfirmPasswordChanged() {
    updateFormState();
    checkPasswordsMatch();
  }

  // 양쪽 필드가 채워졌는지 확인
  void updateFormState() {
    setState(() {
      isFormFilled =
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty;
    });
  }

  // 비밀번호 유효성 검사
  void validatePassword(String password) {
    setState(() {
      isPasswordValid = isValidPassword(password);
    });
  }

  // 비밀번호 일치 여부 확인
  void checkPasswordsMatch() {
    setState(() {
      isPasswordMatched =
          passwordController.text == confirmPasswordController.text;
    });
  }

  // 비밀번호 유효성 검사 로직
  bool isValidPassword(String password) {
    // 길이 체크 (8~13자)
    if (password.length < 8 || password.length > 13) return false;

    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    final hasNumber = RegExp(r'\d').hasMatch(password);
    final hasSpecial = RegExp(r'[@$!%*?&]').hasMatch(password);

    // 조건 3개 중 2개 이상 만족해야 함
    int satisfiedConditions =
        [hasLetter, hasNumber, hasSpecial].where((e) => e).length;
    return satisfiedConditions >= 2;
  }

  // 다음 버튼 클릭 시 동작
  void onNextButtonPressed() {
    print('비밀번호: ${passwordController.text}');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FindSchoolScreen()),
    );
  }

  // 공통 텍스트 필드 위젯 생성
  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isValid,
  }) {
    return SizedBox(
      width: FIELD_WIDTH.w,
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

  // 공통 라벨 위젯 생성
  Widget buildLabel({
    required String text,
    required double top,
    required bool isValid,
  }) {
    return Positioned(
      top: top.h,
      left: HORIZONTAL_PADDING.w,
      child: Text(
        text,
        style: LABEL_STYLE.copyWith(
          color: isValid ? AppColor.black : AppColor.error,
        ),
      ),
    );
  }

  // 에러 메시지 위젯 생성
  Widget buildErrorMessage({required String message, required double top}) {
    return Positioned(
      top: top.h,
      left: HORIZONTAL_PADDING.w,
      child: Text(message, style: ERROR_STYLE),
    );
  }

  // 다음 버튼 위젯 생성
  Widget buildNextButton() {
    final isButtonEnabled =
        isFormFilled && isPasswordValid && isPasswordMatched;

    return Positioned(
      top: BUTTON_TOP.h,
      left: HORIZONTAL_PADDING.w,
      child: SizedBox(
        width: BUTTON_WIDTH.w,
        height: BUTTON_HEIGHT.h,
        child: ElevatedButton(
          onPressed: isButtonEnabled ? onNextButtonPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isButtonEnabled ? AppColor.main : AppColor.gray300,
            foregroundColor:
                isButtonEnabled ? AppColor.white : AppColor.gray600,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          // 타이틀
          Positioned(
            top: TITLE_TOP.h,
            left: HORIZONTAL_PADDING.w,
            child: Text('비밀번호를 입력해주세요', style: TITLE_STYLE),
          ),
          // 비밀번호 라벨
          buildLabel(
            text: '비밀번호',
            top: PASSWORD_LABEL_TOP,
            isValid: isPasswordValid,
          ),
          // 비밀번호 입력 필드
          Positioned(
            top: PASSWORD_FIELD_TOP.h,
            left: HORIZONTAL_PADDING.w,
            child: buildTextField(
              controller: passwordController,
              hintText: '비밀번호를 입력해주세요',
              isValid: isPasswordValid,
            ),
          ),
          // 비밀번호 유효성 에러 메시지
          if (!isPasswordValid)
            buildErrorMessage(
              message: '영문, 숫자, 특수문자 중 2개 이상의 조합으로 8글자 이상 13글자 이하',
              top: PASSWORD_ERROR_TOP,
            ),
          // 비밀번호 확인 라벨
          buildLabel(
            text: '비밀번호 재 입력',
            top: CONFIRM_LABEL_TOP,
            isValid: isPasswordMatched,
          ),
          // 비밀번호 확인 입력 필드
          Positioned(
            top: CONFIRM_FIELD_TOP.h,
            left: HORIZONTAL_PADDING.w,
            child: buildTextField(
              controller: confirmPasswordController,
              hintText: '비밀번호를 다시 입력해주세요',
              isValid: isPasswordMatched,
            ),
          ),
          // 비밀번호 일치 에러 메시지
          if (!isPasswordMatched)
            buildErrorMessage(
              message: '비밀번호가 일치하지 않아요',
              top: CONFIRM_ERROR_TOP,
            ),
          // 다음 버튼
          buildNextButton(),
        ],
      ),
    );
  }
}
