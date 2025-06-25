import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:email_validator/email_validator.dart';
import 'package:jusicool_ios/router.dart';
import '../../sign_up/screens/name_input_screen.dart';

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
    {'email': 'admin@admin.com', 'password': '12341234!'},
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
      context.pushReplacement(RoutePaths.main);
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

  @override
  Widget build(BuildContext context) {
    final isFormFilled =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: JusicoolColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 112.h),
              JusicoolImage.logo(width: 220.w, height: 32.h),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Text(
                  'jusicool로 간단하게 모의투자부터',
                  style: JusicoolTypography.bodySmall.copyWith(
                    color: JusicoolColor.gray600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 74.h),
              buildInputField(
                label: '이메일',
                controller: _emailController,
                hint: '이메일을 입력해주세요',
                hasError: showEmailError || showLoginError,
                errorMessage: emailErrorMessage,
                onChanged: validateEmail,
              ),
              SizedBox(height: 32.h),
              buildInputField(
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
              SizedBox(height: 120.h),
              SizedBox(
                width: FORM_WIDTH.w,
                child: AppButtonMedium(
                  text: '로그인',
                  onPressed: handleLogin,
                  backgroundColor:
                      isFormFilled ? JusicoolColor.main : JusicoolColor.gray300,
                  textColor:
                      isFormFilled
                          ? JusicoolColor.white
                          : JusicoolColor.gray600,
                  borderColor:
                      isFormFilled ? JusicoolColor.main : JusicoolColor.gray300,
                ),
              ),
              SizedBox(height: 32.h),
              Center(
                child: Text(
                  '아직 계정이 없으신가요?',
                  style: JusicoolTypography.bodySmall.copyWith(
                    fontSize: 14.sp,
                    color: JusicoolColor.gray300,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
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
                    style: JusicoolTypography.bodySmall.copyWith(
                      fontSize: 16.sp,
                      color: JusicoolColor.main,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  // buildInputField에서 Positioned 제거
  Widget buildInputField({
    // required double top, // top 파라미터 제거
    required String label,
    required TextEditingController controller,
    required String hint,
    required bool hasError,
    required String errorMessage,
    bool obscureText = false,
    required Function(String) onChanged,
  }) {
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
            decoration: getInputDecoration(hint, hasError || showLoginError),
          ),
        ),
        if (hasError && errorMessage.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: SizedBox(
              width: FORM_WIDTH.w,
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
