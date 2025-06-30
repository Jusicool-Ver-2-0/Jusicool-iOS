import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isFormFilled = false;
  bool _isPasswordValid = true;
  bool _isPasswordMatched = true;

  static final TextStyle _titleStyle = JusicoolTypography.bodyMedium.copyWith(
    fontSize: 18.sp,
    color: JusicoolColor.black,
  );
  static final TextStyle _labelStyle = JusicoolTypography.bodySmall.copyWith(
    fontSize: 16.sp,
    color: JusicoolColor.black,
  );

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);

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
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    _validatePassword(_passwordController.text);
    _updateFormState();
    _checkPasswordsMatch();
  }

  void _onConfirmPasswordChanged() {
    _updateFormState();
    _checkPasswordsMatch();
  }

  void _updateFormState() {
    setState(() {
      _isFormFilled =
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  void _validatePassword(String password) {
    setState(() {
      _isPasswordValid = _isValidPassword(password);
    });
  }

  void _checkPasswordsMatch() {
    setState(() {
      _isPasswordMatched =
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  bool _isValidPassword(String password) {
    if (password.length < 8 || password.length > 13) return false;

    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    final hasNumber = RegExp(r'\d').hasMatch(password);
    final hasSpecial = RegExp(r'[@$!%*?&]').hasMatch(password);

    final count = [hasLetter, hasNumber, hasSpecial].where((e) => e).length;
    return count >= 2;
  }

  void _onNextButtonPressed() {
    context.push(
      '/find-school',
      extra: {
        'username': widget.username,
        'email': widget.email,
        'password': _passwordController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled =
        _isFormFilled && _isPasswordValid && _isPasswordMatched;

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
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 26.h, 24.w, 56.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 40.h,
            children: [
              Text('비밀번호를 입력해주세요', style: _titleStyle),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Text(
                    '비밀번호',
                    style: _labelStyle.copyWith(
                      color:
                          _isPasswordValid
                              ? JusicoolColor.black
                              : JusicoolColor.error,
                    ),
                  ),
                  DefaultTextField(
                    controller: _passwordController,
                    hintText: '비밀번호를 입력해주세요',
                    obscureText: true,
                    errorText:
                        _isPasswordValid
                            ? null
                            : '영문, 숫자, 특수문자 중 2개 이상 조합으로 8~13자',
                    validator: (value) {
                      final pwd = value ?? '';
                      if (pwd.isEmpty) {
                        return '비밀번호를 입력해주세요';
                      }
                      if (!_isValidPassword(pwd)) {
                        return '영문, 숫자, 특수문자 중 2개 이상 조합으로 8~13자';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Text(
                    '비밀번호 재 입력',
                    style: _labelStyle.copyWith(
                      color:
                          _isPasswordMatched
                              ? JusicoolColor.black
                              : JusicoolColor.error,
                    ),
                  ),
                  DefaultTextField(
                    controller: _confirmPasswordController,
                    hintText: '비밀번호를 다시 입력해주세요',
                    obscureText: true,
                    errorText: _isPasswordMatched ? null : '비밀번호가 일치하지 않아요',
                    validator: (value) {
                      final confirmPwd = value ?? '';
                      if (confirmPwd.isEmpty) {
                        return '비밀번호를 다시 입력해주세요';
                      }
                      if (confirmPwd != _passwordController.text) {
                        return '비밀번호가 일치하지 않아요';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: isButtonEnabled ? _onNextButtonPressed : null,
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
            ],
          ),
        ),
      ),
    );
  }
}
