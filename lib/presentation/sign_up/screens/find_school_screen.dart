import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_ios/presentation/sign_up/controller/sign_up_email_controller.dart';
import '../../../core/config/router/router.dart';
import '../controller/sign_up_name_controller.dart';
import '../controller/sign_up_password_controller.dart';
import '../controller/sign_up_school_controller.dart';
import '../state/sign_up_school_state.dart';

class FindSchoolScreen extends ConsumerWidget {
  const FindSchoolScreen({super.key});

  Widget _labelChip(String text) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
    decoration: BoxDecoration(
      color: JusicoolColor.gray100,
      borderRadius: BorderRadius.circular(4.r),
    ),
    child: Text(
      text,
      style: JusicoolTypography.bodySmall.copyWith(
        fontSize: 12.sp,
        color: JusicoolColor.gray600,
      ),
    ),
  );

  Widget _schoolCard(
    SchoolInfoState school,
    SchoolInfoState? selectedSchool,
    VoidCallback onTap,
  ) {
    final isSelected = selectedSchool?.schoolName == school.schoolName;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: JusicoolColor.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? JusicoolColor.blueSky : JusicoolColor.gray300,
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _labelChip('학교명'),
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Text(
                    school.schoolName,
                    style: JusicoolTypography.bodySmall.copyWith(
                      fontSize: 12.sp,
                      color: JusicoolColor.black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Row(
                children: [
                  _labelChip('주소'),
                  Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Text(
                      school.schoolAddress,
                      style: JusicoolTypography.bodySmall.copyWith(
                        fontSize: 12.sp,
                        color: JusicoolColor.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchRow(
    TextEditingController schoolNameController,
    bool isSelect,
    Function onTap,
  ) => Row(
    children: [
      Expanded(
        child: TextField(
          controller: schoolNameController,
          decoration: InputDecoration(
            hintText: '학교명을 입력해주세요',
            hintStyle: JusicoolTypography.bodySmall.copyWith(
              color: JusicoolColor.gray400,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 18.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: JusicoolColor.gray300, width: 1.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: JusicoolColor.gray300, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: JusicoolColor.main, width: 2.w),
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 12.w),
        width: 54.w,
        height: 54.h,
        child: GestureDetector(
          onTap: () => onTap(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              color: isSelect ? JusicoolColor.gray100 : JusicoolColor.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: JusicoolColor.main.withValues(alpha: 0.5),
                  width: 1.sp,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: JusicoolIcon.search(
                height: 24.h,
                width: 24.w,
                color: JusicoolColor.main.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _startButton(bool enabled, Function onTap) => SizedBox(
    width: double.infinity,
    height: 54.h,
    child: ElevatedButton(
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? JusicoolColor.main : JusicoolColor.gray300,
        foregroundColor: enabled ? JusicoolColor.white : JusicoolColor.gray600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(
        '시작하기',
        style: JusicoolTypography.bodyMedium.copyWith(
          fontSize: 18.sp,
          color: enabled ? JusicoolColor.white : JusicoolColor.gray600,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(signupSchoolControllerProvider.notifier);
    final state = ref.watch(signupSchoolControllerProvider);
    final isSchoolSelected = state.selectedSchool != null;

    return Scaffold(
      backgroundColor: JusicoolColor.white,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 24.sp,
          padding: EdgeInsets.only(left: 24.sp, top: 20.h),
          icon: const Icon(Icons.arrow_back, color: JusicoolColor.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: JusicoolColor.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: JusicoolColor.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: JusicoolColor.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 26.h, 24.w, 56.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 30.h,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 29.h,
                    children: [
                      Text(
                        '현재 재학 중인 학교 이름을 입력해주세요',
                        style: JusicoolTypography.subTitle.copyWith(
                          fontSize: 18.sp,
                          color: JusicoolColor.black,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4.h,
                        children: [
                          Text(
                            '학교명',
                            style: JusicoolTypography.bodySmall.copyWith(
                              fontSize: 16.sp,
                              color: JusicoolColor.black,
                            ),
                          ),
                          _searchRow(
                            provider.schoolNameController,
                            state.selectedSchool != null,
                            provider.searchSchool,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child:
                    state.filteredSchools.isEmpty
                        ? Center(
                          child: Text(
                            '검색 결과가 없습니다.',
                            style: JusicoolTypography.bodyMedium.copyWith(
                              fontSize: 16.sp,
                              color: JusicoolColor.gray600,
                            ),
                          ),
                        )
                        : ListView.builder(
                          padding: EdgeInsets.only(top: 2.h),
                          itemCount: state.filteredSchools.length,
                          itemBuilder:
                              (_, index) => _schoolCard(
                                state.filteredSchools[index],
                                state.selectedSchool,
                                () => provider.selectSchool(
                                  state.filteredSchools[index],
                                ),
                              ),
                        ),
              ),
              Column(
                children: [
                  _startButton(isSchoolSelected, () {
                    final result = provider.start(
                      email: ref.watch(emailAuthControllerProvider).email,
                      password:
                          ref.watch(signupPasswordControllerProvider).password,
                      name: ref.watch(nameControllerProvider).username,
                    );
                    if (result) {
                      context.pushReplacement(RoutePaths.main);
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
