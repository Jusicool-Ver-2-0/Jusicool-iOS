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
  bool _showErrorMessage = false;
  String _errorMessage = '';

  // 테스트용 임시 계정
  final List<Map<String, String>> _database = [
    {'email': 's24001@gsm.hs.kr', 'password': '12345678!'},
  ];

  final RegExp _passwordRegex = RegExp(
    r'^(?=(?:.*[A-Za-z].*[0-9])|(?:.*[A-Za-z].*[@$!%*?&])|(?:.*[0-9].*[@$!%*?&]))[A-Za-z\d@$!%*?&]{8,}$',
  );

  InputDecoration _getInputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: _showErrorMessage ? AppColor.error : AppColor.gray600,
      ),
      hintText: hint,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: _showErrorMessage ? AppColor.error : AppColor.gray300,
          width: 1.w,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: _showErrorMessage ? AppColor.error : AppColor.main,
          width: 2.w,
        ),
      ),
    );
  }

  void _handleLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      _showErrorMessage = false;
      _errorMessage = '';
    });

    if (!EmailValidator.validate(email)) {
      setState(() {
        _showErrorMessage = true;
        _errorMessage = '유효한 이메일 주소를 입력해주세요.';
      });
      return;
    }

    if (!_passwordRegex.hasMatch(password)) {
      setState(() {
        _showErrorMessage = true;
        _errorMessage = '비밀번호는 영문, 숫자, 특수문자 중 2개 이상 조합으로 8글자 이상이어야 합니다.';
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
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      setState(() {
        _showErrorMessage = true;
        _errorMessage = '아이디와 비밀번호를 다시 한 번 확인해주세요';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFormFilled =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Stack(
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
              top: 260.h,
              left: 24.w,
              child: SizedBox(
                width: 312.w,
                child: TextFormField(
                  controller: _emailController,
                  onChanged: (_) => setState(() => _showErrorMessage = false),
                  decoration: _getInputDecoration('이메일', '이메일을 입력해주세요'),
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
                    TextFormField(
                      controller: _passwordController,
                      onChanged:
                          (_) => setState(() => _showErrorMessage = false),
                      obscureText: true,
                      decoration: _getInputDecoration('비밀번호', '비밀번호를 입력해주세요'),
                    ),
                    if (_showErrorMessage)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          _errorMessage,
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
      ),
    );
  }
}
