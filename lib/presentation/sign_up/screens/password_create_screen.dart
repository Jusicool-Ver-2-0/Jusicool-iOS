import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import '../controller/sign_up_password_controller.dart';

class PasswordCreateScreen extends ConsumerWidget {
  const PasswordCreateScreen({super.key});

  static final TextStyle _titleStyle = JusicoolTypography.bodyMedium.copyWith(
    fontSize: 18.sp,
    color: JusicoolColor.black,
  );
  static final TextStyle _labelStyle = JusicoolTypography.bodySmall.copyWith(
    fontSize: 16.sp,
    color: JusicoolColor.black,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signupPasswordControllerProvider);
    final provider = ref.watch(signupPasswordControllerProvider.notifier);
    final isButtonEnabled =
        state.isFormFilled && state.isPasswordValid && state.isPasswordMatched;

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
                          state.isPasswordValid
                              ? JusicoolColor.black
                              : JusicoolColor.error,
                    ),
                  ),
                  DefaultTextField(
                    controller: provider.passwordController,
                    hintText: '비밀번호를 입력해주세요',
                    obscureText: true,
                    errorText:
                        !state.isPasswordValid
                            ? '영문, 숫자, 특수문자 중 2개 이상 조합으로 8~13자'
                            : null,
                    validator: (String? value) => null,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Text(
                    '비밀번호 재입력',
                    style: _labelStyle.copyWith(
                      color:
                          state.isPasswordMatched
                              ? JusicoolColor.black
                              : JusicoolColor.error,
                    ),
                  ),
                  DefaultTextField(
                    controller: provider.confirmPasswordController,
                    hintText: '비밀번호를 다시 입력해주세요',
                    obscureText: true,
                    errorText:
                        !state.isPasswordMatched ? '비밀번호가 일치하지 않아요' : null,
                    validator: (String? value) => null,
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: () {
                    final password = provider.passwordController.text.trim();

                    provider.validatePassword(password);
                    provider.checkPasswordsMatch();

                    final newState = ref.read(signupPasswordControllerProvider);
                    final isValid =
                        newState.isFormFilled &&
                        newState.isPasswordValid &&
                        newState.isPasswordMatched;

                    if (isValid) {
                      provider.onNextButtonPressed(context);
                    }
                  },
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
