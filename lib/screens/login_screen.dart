import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_ios/main.dart';
import 'package:jusicool_ios/screens/signup_screens/name_input_screen.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_design_system/src/ui/widgets/button/button_medium.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showEmailError = false;
  String emailErrorMessage = '';
  bool showPasswordError = false;
  String passwordErrorMessage = '';
  bool showLoginError = false;
  String loginErrorMessage = '';

  static const double FIELD_HEIGHT = 56.0;
  static const double FORM_WIDTH = 312.0;

  final List<Map<String, String>> database = [
    {'email': 's24001@gsm.hs.kr', 'password': '12345678!'},
  ];

  // 공통 에러 처리 함수
  void setError({
    required bool emailError,
    required String emailMsg,
    required bool passwordError,
    required String passwordMsg,
    required bool loginError,
    required String loginMsg,
  }) {
    setState(() {
      showEmailError = emailError;
      emailErrorMessage = emailMsg;
      showPasswordError = passwordError;
      passwordErrorMessage = passwordMsg;
      showLoginError = loginError;
      loginErrorMessage = loginMsg;
    });
  }

  // 텍스트 필드 스타일을 관리하는 공통 함수
  InputDecoration getInputDecoration(String hint, bool hasError) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTypography.bodySmall.copyWith(
        color: hasError ? AppColor.error : AppColor.gray500,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: hasError ? AppColor.error : AppColor.gray300,
          width: 1.w,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: hasError ? AppColor.error : AppColor.main,
          width: 2.w,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColor.error, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColor.error, width: 2.w),
      ),
    );
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

  void validateEmail(String email) {
    if (email.isEmpty || EmailValidator.validate(email)) {
      setError(
        emailError: false,
        emailMsg: '',
        passwordError: showPasswordError,
        passwordMsg: passwordErrorMessage,
        loginError: showLoginError,
        loginMsg: loginErrorMessage,
      );
    } else {
      setError(
        emailError: true,
        emailMsg: '유효한 이메일 주소를 입력해주세요.',
        passwordError: showPasswordError,
        passwordMsg: passwordErrorMessage,
        loginError: showLoginError,
        loginMsg: loginErrorMessage,
      );
    }
  }

  void validatePassword(String password) {
    if (password.isEmpty || isValidPassword(password)) {
      setError(
        emailError: showEmailError,
        emailMsg: emailErrorMessage,
        passwordError: false,
        passwordMsg: '',
        loginError: showLoginError,
        loginMsg: loginErrorMessage,
      );
    } else {
      setError(
        emailError: showEmailError,
        emailMsg: emailErrorMessage,
        passwordError: true,
        passwordMsg: '영문, 숫자, 특수문자 중 2개 이상 조합으로 8글자 이상.',
        loginError: showLoginError,
        loginMsg: loginErrorMessage,
      );
    }
  }

  void handleLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    final isEmailValid = EmailValidator.validate(email);
    final isPasswordValid = isValidPassword(password);

    if (!isEmailValid || !isPasswordValid) {
      setError(
        emailError: !isEmailValid,
        emailMsg: !isEmailValid ? '유효한 이메일 주소를 입력해주세요.' : '',
        passwordError: !isPasswordValid,
        passwordMsg:
            !isPasswordValid ? '영문, 숫자, 특수문자 중 2개 이상 조합으로 8글자 이상.' : '',
        loginError: false,
        loginMsg: '',
      );
      return;
    }

    final user = database.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      setError(
        emailError: false,
        emailMsg: '',
        passwordError: false,
        passwordMsg: '',
        loginError: true,
        loginMsg: '아이디와 비밀번호를 다시 한 번 확인해주세요',
      );
    }
  }

  Widget buildInputField({
    required double top,
    required String label,
    required TextEditingController controller,
    required String hint,
    required bool hasError,
    required String errorMessage,
    bool obscureText = false,
    required Function(String) onChanged,
  }) {
    return Positioned(
      top: top,
      left: 24.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 16.sp,
              color: hasError ? AppColor.error : AppColor.black,
            ),
          ),
          SizedBox(height: 8.h),
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: FORM_WIDTH.w,
                height: FIELD_HEIGHT.h,
                child: TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  onChanged: (value) {
                    onChanged(value);
                    if (showLoginError) {
                      setState(() {
                        showLoginError = false;
                        loginErrorMessage = '';
                      });
                    }
                  },
                  decoration: getInputDecoration(
                    hint,
                    hasError || showLoginError,
                  ),
                ),
              ),
              if (hasError && errorMessage.isNotEmpty)
                Positioned(
                  top: FIELD_HEIGHT.h + 4.h,
                  right: 0,
                  child: SizedBox(
                    width: FORM_WIDTH.w,
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.right,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColor.error,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFormFilled =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          Positioned(
            top: 112.h,
            left: 24.w,
            child: Image.asset(
              'assets/images/JUSICOOL.png',
              width: 220.w,
              height: 32.h,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 152.h,
            left: 26.w,
            child: Text(
              'jusicool로 간단하게 모의투자부터',
              style: AppTypography.bodySmall.copyWith(
                color: AppColor.gray600,
                fontSize: 16.sp,
              ),
            ),
          ),
          buildInputField(
            top: 234.h,
            label: '이메일',
            controller: _emailController,
            hint: '이메일을 입력해주세요',
            hasError: showEmailError || showLoginError,
            errorMessage: emailErrorMessage,
            onChanged: validateEmail,
          ),
          buildInputField(
            top: 330.h,
            label: '비밀번호',
            controller: _passwordController,
            hint: '비밀번호를 입력해주세요',
            hasError: showPasswordError || showLoginError,
            errorMessage:
                showPasswordError
                    ? passwordErrorMessage
                    : (showLoginError ? loginErrorMessage : ''),
            obscureText: true,
            onChanged: validatePassword,
          ),
          Positioned(
            top: 614.h,
            left: 24.w,
            child: SizedBox(
              width: FORM_WIDTH.w,
              child: AppButtonMedium(
                text: '로그인',
                onPressed: handleLogin,
                backgroundColor:
                    isFormFilled ? AppColor.main : AppColor.gray300,
                textColor: isFormFilled ? AppColor.white : AppColor.gray600,
                borderColor: isFormFilled ? AppColor.main : AppColor.gray300,
              ),
            ),
          ),
          Positioned(
            top: 672.h,
            left: 0,
            right: 0,
            child: Text(
              '아직 계정이 없으신가요?',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                fontSize: 14.sp,
                color: AppColor.gray300,
              ),
            ),
          ),
          Positioned(
            top: 696.h,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NameInputScreen(),
                  ),
                );
              },
              child: Text(
                '회원가입',
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall.copyWith(
                  fontSize: 16.sp,
                  color: AppColor.main,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
