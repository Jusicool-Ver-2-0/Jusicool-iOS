import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_ios/presentation/sign_in/screens/widgets/input_field.dart';
import '../../sign_up/screens/name_input_screen.dart';
import '../controller/sign_in_controller.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInControllerProvider);
    final provider = ref.watch(signInControllerProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: JusicoolColor.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 112.h, 24.w, 84.h),
        child: Column(
          spacing: 60.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              spacing: 8.h,
              children: [
                JusicoolImage.logo(width: 220.w, height: 32.h),
                Text(
                  'jusicool로 간단하게 모의투자부터',
                  style: JusicoolTypography.bodySmall.copyWith(
                    color: JusicoolColor.gray600,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            Column(
              spacing: 24.h,
              children: [
                InputField(
                  label: '이메일',
                  controller: provider.emailController,
                  hint: '이메일을 입력해주세요',
                  hasError: state.hasError,
                  obscureText: false,
                ),
                InputField(
                  label: '비밀번호',
                  controller: provider.passwordController,
                  hint: '비밀번호를 입력해주세요',
                  errorMessage: state.errorMessage,
                  hasError: state.hasError,
                  obscureText: true,
                ),
              ],
            ),
            Spacer(),
            Column(
              spacing: 8.h,
              children: [
                AppButtonMedium(
                  text: '로그인',
                  onPressed: () => provider.signIn(context),
                  backgroundColor:
                      state.enableButton
                          ? JusicoolColor.main
                          : JusicoolColor.gray300,
                  textColor:
                      state.enableButton
                          ? JusicoolColor.white
                          : JusicoolColor.gray600,
                  borderColor:
                      state.enableButton
                          ? JusicoolColor.main
                          : JusicoolColor.gray300,
                ),
                Text(
                  '아직 계정이 없으신가요?',
                  style: JusicoolTypography.bodySmall.copyWith(
                    fontSize: 14.sp,
                    color: JusicoolColor.gray300,
                  ),
                ),
                GestureDetector(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
