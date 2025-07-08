import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:go_router/go_router.dart';
import 'package:jusicool_ios/presentation/sign_up/controller/sign_up_name_controller.dart';

import '../../../core/config/di/dependencies.dart';
import '../../../core/config/router/router.dart';

class NameInputScreen extends ConsumerWidget {
  const NameInputScreen({super.key});

  Widget buildButton({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    final isEnabled = onPressed != null && !isLoading;

    return Semantics(
      button: true,
      label: label,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            backgroundColor:
                isEnabled ? JusicoolColor.main : JusicoolColor.gray300,
            foregroundColor:
                isEnabled ? JusicoolColor.white : JusicoolColor.gray600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
          ),
          child:
              isLoading
                  ? const CircularProgressIndicator(color: JusicoolColor.white)
                  : Text(
                    label,
                    style: JusicoolTypography.bodyMedium.copyWith(
                      color:
                          isEnabled
                              ? JusicoolColor.white
                              : JusicoolColor.gray600,
                    ),
                  ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CookieJar cookieJar = di.get<CookieJar>();
    cookieJar.deleteAll(); // 쿠키 삭제
    final provider = ref.watch(nameControllerProvider.notifier);
    final state = ref.watch(nameControllerProvider);
    return Scaffold(
      backgroundColor: JusicoolColor.white,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15.w, top: 20.h),
          child: const BackButton(),
        ),
        elevation: 0,
        backgroundColor: JusicoolColor.white,
        foregroundColor: JusicoolColor.black,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 56.h),
        child: Column(
          spacing: 40.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이름을 적어 주세요', style: JusicoolTypography.subTitle),
            Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('이름', style: JusicoolTypography.bodySmall),
                DefaultTextField(
                  controller: provider.controller,
                  hintText: '실명을 적어주세요',
                  errorText: state.errorMessage,
                  validator: (String) {
                    return null;
                  },
                ),
              ],
            ),
            const Spacer(),
            buildButton(
              label: '다음',
              onPressed:
                  state.enableButton
                      ? () {
                        if (provider.validateUsername()) {
                          context.push(RoutePaths.emailAuth);
                        }
                      }
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
