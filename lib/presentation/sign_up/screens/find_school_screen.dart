import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:go_router/go_router.dart';

class SchoolInfo {
  final String name;
  final String address;

  SchoolInfo({required this.name, required this.address});

  Map<String, String> toMap() => {"name": name, "address": address};
}

class FindSchoolScreen extends StatefulWidget {
  final String username;
  final String email;
  final String password;

  const FindSchoolScreen({
    super.key,
    required this.username,
    required this.email,
    required this.password,
  });

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

  /// ====================================
  final List<SchoolInfo> schools = [
    SchoolInfo(name: "대충중학교", address: "대충남도 대충시 대충면 대충로 1-2"),
    SchoolInfo(name: "대충고등학교", address: "대충남도 대충시 대충면 대충로 3-4"),
    SchoolInfo(name: "가나초등학교", address: "대충남도 대충시 가나동 가나로 5-6"),
    SchoolInfo(name: "다라중학교", address: "대충남도 대충시 다라동 다라로 7-8"),
  ];

  /// ====================================
  @override
  void initState() {
    super.initState();
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
    final q = schoolNameController.text.trim();
    setState(() {
      if (q.isEmpty) {
        filteredSchools = [];
        selectedSchool = null;
      } else {
        filteredSchools =
            schools
                .where((s) => s.name.toLowerCase().contains(q.toLowerCase()))
                .toList();
      }
    });
  }

  void onStart() {
    if (selectedSchool != null) {
      context.go('/main-capital');
    }
  }

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

  Widget _schoolCard(SchoolInfo school) {
    final isSelected = selectedSchool?.name == school.name;
    return GestureDetector(
      onTap:
          () => setState(() {
            selectedSchool = isSelected ? null : school;
          }),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: JusicoolColor.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color:
                isSelected
                    ? SELECTED_BORDER_COLOR.withOpacity(SELECTED_BORDER_OPACITY)
                    : JusicoolColor.gray300,
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
                    school.name,
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
                      school.address,
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

  Widget _searchRow() => Row(
    children: [
      Expanded(
        child: TextField(
          controller: schoolNameController,
          onChanged: (_) => onSearch(),
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
          onTapDown: (_) => setState(() => isSearchButtonPressed = true),
          onTapUp: (_) {
            setState(() => isSearchButtonPressed = false);
            onSearch();
          },
          onTapCancel: () => setState(() => isSearchButtonPressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              color:
                  isSearchButtonPressed
                      ? JusicoolColor.gray100
                      : JusicoolColor.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: JusicoolIcon.search(),
          ),
        ),
      ),
    ],
  );

  Widget _startButton(bool enabled) => Container(
    width: double.infinity,
    height: 54.h,
    child: ElevatedButton(
      onPressed: enabled ? onStart : null,
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
  Widget build(BuildContext context) {
    final isSchoolSelected = selectedSchool != null;

    return Scaffold(
      backgroundColor: JusicoolColor.white,
      appBar: AppBar(
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  '현재 재학 중인 학교 이름을 입력해주세요',
                  style: JusicoolTypography.subTitle.copyWith(
                    fontSize: 18.sp,
                    color: JusicoolColor.black,
                  ),
                ),
              ),
              // 라벨
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: Text(
                  '학교명',
                  style: JusicoolTypography.bodySmall.copyWith(
                    fontSize: 16.sp,
                    color: JusicoolColor.black,
                  ),
                ),
              ),
              // 검색 입력 & 버튼
              Padding(padding: EdgeInsets.only(top: 12.h), child: _searchRow()),
              // 검색 결과 리스트
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 32.h),
                  child:
                      filteredSchools.isEmpty
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
                            itemCount: filteredSchools.length,
                            itemBuilder:
                                (_, index) =>
                                    _schoolCard(filteredSchools[index]),
                          ),
                ),
              ),
              // 시작하기 버튼
              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: _startButton(isSchoolSelected),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
