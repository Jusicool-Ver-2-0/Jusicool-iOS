import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';

import '../login_screen.dart';

class SchoolInfo {
  final String name;
  final String address;

  SchoolInfo({required this.name, required this.address});

  Map<String, String> toMap() => {"name": name, "address": address};
}

class FindSchoolScreen extends StatefulWidget {
  const FindSchoolScreen({super.key});

  @override
  State<FindSchoolScreen> createState() => _FindSchoolScreenState();
}

class _FindSchoolScreenState extends State<FindSchoolScreen> {
  final TextEditingController schoolNameController = TextEditingController();
  bool isSearchButtonPressed = false;
  List<SchoolInfo> filteredSchools = [];
  SchoolInfo? selectedSchool;

  static const Color SELECTED_BORDER_COLOR = Color(0xFF2756F1);
  static const double SELECTED_BORDER_OPACITY = 0.5;
  static const double HORIZONTAL_PADDING = 24.0;
  static const double SEARCH_BUTTON_LEFT_OFFSET = 282.0;
  static const double BOTTOM_PADDING = 24.0;
  static const double BUTTON_HEIGHT = 54.0;
  static const double BUTTON_WIDTH = 312.0;

  final List<SchoolInfo> schools = [
    SchoolInfo(name: "대충중학교", address: "대충남도 대충시 대충면 대충로 1-2"),
    SchoolInfo(name: "대충고등학교", address: "대충남도 대충시 대충면 대충로 3-4"),
    SchoolInfo(name: "가나초등학교", address: "대충남도 대충시 가나동 가나로 5-6"),
    SchoolInfo(name: "다라중학교", address: "대충남도 대충시 다라동 다라로 7-8"),
  ];

  @override
  void initState() {
    super.initState();
    filteredSchools = [];

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
    schoolNameController.dispose();
    super.dispose();
  }

  void onSearch() {
    final searchQuery = schoolNameController.text.trim();
    setState(() {
      if (searchQuery.isNotEmpty) {
        filteredSchools =
            schools
                .where(
                  (school) => school.name.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ),
                )
                .toList();
        print('검색된 학교: $filteredSchools');
      } else {
        filteredSchools = [];
        selectedSchool = null;
      }
    });
  }

  void onStart() {
    if (selectedSchool != null) {
      print('선택된 학교: ${selectedSchool!.name}');
      print('주소: ${selectedSchool!.address}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  Widget buildSchoolInfoBox({
    required SchoolInfo school,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedSchool == school) {
            selectedSchool = null;
          } else {
            selectedSchool = school;
          }
        });
        onTap();
      },
      child: Container(
        width: BUTTON_WIDTH.w,
        height: 79.h,
        decoration: BoxDecoration(
          color: JusicoolColor.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color:
                isSelected
                    ? SELECTED_BORDER_COLOR.withValues(
                      alpha: SELECTED_BORDER_OPACITY,
                    )
                    : JusicoolColor.gray300,
            width: 1.w,
          ),
        ),
        child: Stack(
          children: [
            buildLabelBox(
              top: 14.h,
              left: 16.w,
              width: 62.w,
              label: '학교명',
              paddingLeft: 15.w,
            ),
            buildLabelBox(
              top: 43.h,
              left: 16.w,
              width: 62.w,
              label: '주소',
              paddingLeft: 21.w,
            ),
            buildText(top: 17.h, left: 90.w, text: school.name),
            buildText(top: 46.h, left: 90.w, text: school.address),
          ],
        ),
      ),
    );
  }

  Widget buildLabelBox({
    required double top,
    required double left,
    required double width,
    required String label,
    required double paddingLeft,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        height: 22.h,
        decoration: BoxDecoration(
          color: JusicoolColor.gray100,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 3.h, left: paddingLeft),
          child: Text(
            label,
            style: JusicoolTypography.bodySmall.copyWith(
              fontSize: 12.sp,
              color: JusicoolColor.gray600,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildText({
    required double top,
    required double left,
    required String text,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Text(
        text,
        style: JusicoolTypography.bodySmall.copyWith(
          fontSize: 12.sp,
          color: JusicoolColor.black,
        ),
      ),
    );
  }

  Widget buildSearchButton() {
    return Positioned(
      top: 92.h,
      left: SEARCH_BUTTON_LEFT_OFFSET.w,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => isSearchButtonPressed = true);
        },
        onTapUp: (_) {
          setState(() => isSearchButtonPressed = false);
          onSearch();
        },
        onTapCancel: () {
          setState(() => isSearchButtonPressed = false);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 54.w,
          height: 54.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color:
                isSearchButtonPressed
                    ? JusicoolColor.gray100
                    : JusicoolColor.white,
          ),
          child: Image.asset('assets/images/Search.png', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildTextField() {
    return Positioned(
      top: 92.h,
      left: HORIZONTAL_PADDING.w,
      child: SizedBox(
        width: 246.w,
        height: 54.h,
        child: TextField(
          controller: schoolNameController,
          onChanged: (value) => onSearch(),
          decoration: InputDecoration(
            hintText: '학교명을 입력해주세요',
            hintStyle: JusicoolTypography.bodySmall.copyWith(
              color: JusicoolColor.gray100,
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
    );
  }

  Widget buildNoResultsMessage() {
    return Center(
      child: Text(
        '검색 결과가 없습니다.',
        style: JusicoolTypography.bodyMedium.copyWith(
          fontSize: 16.sp,
          color: JusicoolColor.gray600,
        ),
      ),
    );
  }

  Widget buildStartButton({
    required bool isSchoolSelected,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: BUTTON_WIDTH.w,
      height: BUTTON_HEIGHT.h,
      child: ElevatedButton(
        onPressed: isSchoolSelected ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSchoolSelected ? JusicoolColor.main : JusicoolColor.gray300,
          foregroundColor:
              isSchoolSelected ? JusicoolColor.white : JusicoolColor.gray600,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
              color:
                  isSchoolSelected ? JusicoolColor.main : JusicoolColor.gray100,
            ),
          ),
          minimumSize: Size(BUTTON_WIDTH.w, BUTTON_HEIGHT.h),
          animationDuration: const Duration(milliseconds: 100),
        ),
        child: Text(
          '시작하기',
          style: JusicoolTypography.bodyMedium.copyWith(
            color:
                isSchoolSelected ? JusicoolColor.white : JusicoolColor.gray600,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSchoolSelected = selectedSchool != null;

    return Scaffold(
      backgroundColor: JusicoolColor.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: const BackButton(),
        backgroundColor: JusicoolColor.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: JusicoolColor.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: JusicoolColor.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10.h,
              left: HORIZONTAL_PADDING.w,
              child: Text(
                '현재 재학 중인 학교 이름을 입력해주세요',
                style: JusicoolTypography.subTitle.copyWith(
                  fontSize: 18.sp,
                  color: JusicoolColor.black,
                ),
              ),
            ),
            Positioned(
              top: 66.h,
              left: HORIZONTAL_PADDING.w,
              child: Text(
                '학교명',
                style: JusicoolTypography.bodySmall.copyWith(
                  fontSize: 16.sp,
                  color: JusicoolColor.black,
                ),
              ),
            ),
            buildTextField(),
            buildSearchButton(),
            Positioned(
              top: 172.h,
              left: HORIZONTAL_PADDING.w,
              right: HORIZONTAL_PADDING.w,
              bottom: (BUTTON_HEIGHT + BOTTOM_PADDING).h,
              child:
                  filteredSchools.isEmpty
                      ? buildNoResultsMessage()
                      : ListView.separated(
                        itemCount: filteredSchools.length,
                        separatorBuilder:
                            (context, index) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final school = filteredSchools[index];
                          final isSelected =
                              selectedSchool != null &&
                              selectedSchool!.name == school.name;
                          return buildSchoolInfoBox(
                            school: school,
                            isSelected: isSelected,
                            onTap: () => print("${school.name} 클릭됨!"),
                          );
                        },
                      ),
            ),
            Positioned(
              bottom: BOTTOM_PADDING.h,
              left: HORIZONTAL_PADDING.w,
              child: buildStartButton(
                isSchoolSelected: isSchoolSelected,
                onPressed: onStart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
