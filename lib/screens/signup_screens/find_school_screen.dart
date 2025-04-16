import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_design_system/src/ui/widgets/button/button_medium.dart';

// 학교 정보 데이터 모델
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
  final TextEditingController _schoolNameController = TextEditingController();
  bool _isSearchButtonPressed = false;
  List<SchoolInfo> _filteredSchools = [];
  SchoolInfo? _selectedSchool;

  static const Color _selectedBorderColor = Color(0xFF2756F1);
  static const double _selectedBorderOpacity = 0.5;
  static const double _horizontalPadding = 24.0;
  static const double _searchButtonLeftOffset = 282.0;
  static const double _bottomPadding = 24.0;
  static const double _buttonHeight = 54.0;

  // 학교 데이터 (예시 데이터)
  final List<SchoolInfo> _schools = [
    SchoolInfo(name: "대충중학교", address: "대충남도 대충시 대충면 대충로 1-2"),
    SchoolInfo(name: "대충고등학교", address: "대충남도 대충시 대충면 대충로 3-4"),
    SchoolInfo(name: "가나초등학교", address: "대충남도 대충시 가나동 가나로 5-6"),
    SchoolInfo(name: "다라중학교", address: "대충남도 대충시 다라동 다라로 7-8"),
  ];

  @override
  void initState() {
    super.initState();
    _filteredSchools = [];
  }

  void _onSearch() {
    final searchQuery = _schoolNameController.text.trim();
    setState(() {
      if (searchQuery.isNotEmpty) {
        _filteredSchools =
            _schools
                .where(
                  (school) => school.name.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ),
                )
                .toList();
        print('검색된 학교: $_filteredSchools');
      } else {
        _filteredSchools = [];
      }
    });
  }

  void _onStart() {
    if (_selectedSchool != null) {
      print('선택된 학교: ${_selectedSchool!.name}');
      print('주소: ${_selectedSchool!.address}');
    }
  }

  Widget _buildSchoolInfoBox({
    required SchoolInfo school,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSchool = school;
        });
        onTap();
      },
      child: Container(
        width: 312.w,
        height: 79.h,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color:
                isSelected
                    ? _selectedBorderColor.withOpacity(_selectedBorderOpacity)
                    : AppColor.gray300,
            width: 1.w,
          ),
        ),
        child: Stack(
          children: [
            _buildLabelBox(
              top: 14.h,
              left: 16.w,
              width: 62.w,
              label: '학교명',
              paddingLeft: 15.w,
            ),
            _buildLabelBox(
              top: 43.h,
              left: 16.w,
              width: 62.w,
              label: '주소',
              paddingLeft: 21.w,
            ),
            _buildText(top: 17.h, left: 90.w, text: school.name),
            _buildText(top: 46.h, left: 90.w, text: school.address),
          ],
        ),
      ),
    );
  }

  // 라벨 박스 빌드 메서드
  Widget _buildLabelBox({
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
          color: AppColor.gray100,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 3.h, left: paddingLeft),
          child: Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 12.sp,
              color: AppColor.gray600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText({
    required double top,
    required double left,
    required String text,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Text(
        text,
        style: AppTypography.bodySmall.copyWith(
          fontSize: 12.sp,
          color: AppColor.black,
        ),
      ),
    );
  }

  Widget _buildSearchButton(bool isFieldNotEmpty) {
    return Positioned(
      top: 194.h,
      left: _searchButtonLeftOffset.w,
      child: GestureDetector(
        onTapDown: (_) {
          if (isFieldNotEmpty) {
            setState(() => _isSearchButtonPressed = true);
          }
        },
        onTapUp: (_) {
          if (isFieldNotEmpty) {
            setState(() => _isSearchButtonPressed = false);
            _onSearch();
          }
        },
        onTapCancel: () {
          setState(() => _isSearchButtonPressed = false);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 54.w,
          height: 54.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color:
                isFieldNotEmpty
                    ? (_isSearchButtonPressed
                        ? AppColor.gray100
                        : AppColor.white)
                    : AppColor.gray200,
          ),
          child: Image.asset(
            'assets/images/Search.png',
            fit: BoxFit.cover,
            color: isFieldNotEmpty ? null : AppColor.gray400,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Positioned(
      top: 194.h,
      left: _horizontalPadding.w,
      child: SizedBox(
        width: 246.w,
        height: 54.h,
        child: TextField(
          controller: _schoolNameController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: '학교명을 입력해주세요',
            hintStyle: AppTypography.bodySmall.copyWith(
              color: AppColor.gray100,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 18.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColor.gray300, width: 1.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColor.gray300, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColor.main, width: 2.w),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoResultsMessage() {
    return Center(
      child: Text(
        '검색 결과가 없습니다.',
        style: AppTypography.bodyMedium.copyWith(
          fontSize: 16.sp,
          color: AppColor.gray600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFieldNotEmpty = _schoolNameController.text.isNotEmpty;
    final isSchoolSelected = _selectedSchool != null;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 112.h,
              left: _horizontalPadding.w,
              child: Text(
                '현재 재학 중인 학교 이름을 입력해주세요',
                style: AppTypography.titleMedium.copyWith(
                  fontSize: 18.sp,
                  color: AppColor.black,
                ),
              ),
            ),
            Positioned(
              top: 168.h,
              left: _horizontalPadding.w,
              child: Text(
                '학교명',
                style: AppTypography.bodySmall.copyWith(
                  fontSize: 16.sp,
                  color: AppColor.black,
                ),
              ),
            ),
            _buildTextField(),
            _buildSearchButton(isFieldNotEmpty),
            Positioned(
              top: 274.h,
              left: _horizontalPadding.w,
              right: _horizontalPadding.w,
              bottom: (_buttonHeight + _bottomPadding).h,
              child:
                  _filteredSchools.isEmpty
                      ? _buildNoResultsMessage()
                      : ListView.separated(
                        itemCount: _filteredSchools.length,
                        separatorBuilder:
                            (context, index) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final school = _filteredSchools[index];
                          final isSelected =
                              _selectedSchool != null &&
                              _selectedSchool!.name == school.name;
                          return _buildSchoolInfoBox(
                            school: school,
                            isSelected: isSelected,
                            onTap: () => print("${school.name} 클릭됨!"),
                          );
                        },
                      ),
            ),
            Positioned(
              bottom: _bottomPadding.h,
              left: _horizontalPadding.w,
              child: AppButtonMedium(
                onPressed: isSchoolSelected ? _onStart : null,
                backgroundColor:
                    isSchoolSelected ? AppColor.main : AppColor.gray300,
                textColor: isSchoolSelected ? AppColor.white : AppColor.gray600,
                borderColor:
                    isSchoolSelected ? AppColor.main : AppColor.gray100,
                text: '시작하기',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
