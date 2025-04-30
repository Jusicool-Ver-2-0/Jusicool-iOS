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

  bool _showEmailError = false;
  String _emailErrorMessage = '';

  bool _showPasswordError = false;
  String _passwordErrorMessage = '';

  bool _showLoginError = false;
  String _loginErrorMessage = '';

  static const double FIELD_HEIGHT = 56.0;

  final List<Map<String, String>> _database = [
    {'email': 's24001@gsm.hs.kr', 'password': '12345678!'},
  ];

  InputDecoration _getInputDecoration(String hint, bool hasError) {
    return InputDecoration(
      hintText: hint,
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

  void _validateEmail(String email) {
    if (email.isEmpty) {
      setState(() {
        _showEmailError = false;
        _emailErrorMessage = '';
      });
      return;
    }

    if (!EmailValidator.validate(email)) {
      setState(() {
        _showEmailError = true;
        _emailErrorMessage = '유효한 이메일 주소를 입력해주세요.';
      });
    } else {
      setState(() {
        _showEmailError = false;
        _emailErrorMessage = '';
      });
    }
  }

  void _validatePassword(String password) {
    if (password.isEmpty) {
      setState(() {
        _showPasswordError = false;
        _passwordErrorMessage = '';
      });
      return;
    }

    if (!isValidPassword(password)) {
      setState(() {
        _showPasswordError = true;
        _passwordErrorMessage = '영문, 숫자, 특수문자 중 2개 이상 조합으로 8글자 이상.';
      });
    } else {
      setState(() {
        _showPasswordError = false;
        _passwordErrorMessage = '';
      });
    }
  }

  void _handleLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      _showEmailError = false;
      _emailErrorMessage = '';
      _showPasswordError = false;
      _passwordErrorMessage = '';
      _showLoginError = false;
      _loginErrorMessage = '';
    });

    if (!EmailValidator.validate(email)) {
      setState(() {
        _showEmailError = true;
        _emailErrorMessage = '유효한 이메일 주소를 입력해주세요.';
      });
      return;
    }

    if (!isValidPassword(password)) {
      setState(() {
        _showPasswordError = true;
        _passwordErrorMessage = '영문, 숫자, 특수문자 중 2개 이상 조합으로 8글자 이상.';
      });
      return;
    }

    final user = _database.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        _showLoginError = true;
        _loginErrorMessage = '아이디와 비밀번호를 다시 한 번 확인해주세요';
      });
    }
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
          Positioned(
            top: 234.h,
            left: 24.w,
            child: Text(
              '이메일',
              style: AppTypography.bodySmall.copyWith(
                fontSize: 16.sp,
                color: AppColor.black,
              ),
            ),
          ),
          Positioned(
            top: 260.h,
            left: 24.w,
            child: SizedBox(
              width: 312.w,
              height: FIELD_HEIGHT.h + (_showEmailError ? 16.h : 0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  TextFormField(
                    controller: _emailController,
                    onChanged: (value) {
                      _validateEmail(value);
                      if (_showLoginError) {
                        setState(() {
                          _showLoginError = false;
                          _loginErrorMessage = '';
                        });
                      }
                    },
                    decoration: _getInputDecoration(
                      '이메일을 입력해주세요',
                      _showEmailError || _showLoginError,
                    ),
                  ),
                  if (_showEmailError)
                    Positioned(
                      top: FIELD_HEIGHT.h + 4.h,
                      right: 24.w,
                      child: Text(
                        _emailErrorMessage,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColor.error,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 330.h,
            left: 24.w,
            child: Text(
              '비밀번호',
              style: AppTypography.bodySmall.copyWith(
                fontSize: 16.sp,
                color: AppColor.black,
              ),
            ),
          ),
          Positioned(
            top: 360.h,
            left: 24.w,
            child: SizedBox(
              width: 312.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: FIELD_HEIGHT.h + (_showPasswordError ? 16.h : 0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        TextFormField(
                          controller: _passwordController,
                          onChanged: (value) {
                            _validatePassword(value);
                            if (_showLoginError) {
                              setState(() {
                                _showLoginError = false;
                                _loginErrorMessage = '';
                              });
                            }
                          },
                          obscureText: true,
                          decoration: _getInputDecoration(
                            '비밀번호를 입력해주세요',
                            _showPasswordError || _showLoginError,
                          ),
                        ),
                        if (_showPasswordError)
                          Positioned(
                            top: FIELD_HEIGHT.h + 4.h,
                            right: 24.w,
                            child: Text(
                              _passwordErrorMessage,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColor.error,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (_showLoginError)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        _loginErrorMessage,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColor.error,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 614.h,
            left: 24.w,
            child: SizedBox(
              width: 312.w,
              child: AppButtonMedium(
                text: '로그인',
                onPressed: _handleLogin,
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
