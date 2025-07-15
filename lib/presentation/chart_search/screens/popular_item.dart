import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

class PopularSearchItem extends StatelessWidget {
  final int rank;
  final String name;
  final double changePercent;

  const PopularSearchItem({
    super.key,
    required this.rank,
    required this.name,
    required this.changePercent,
  });

  @override
  Widget build(BuildContext context) {
    Color changeColor;
    String changeText;
    if (changePercent > 0) {
      changeColor = JusicoolColor.error;
      changeText = '+${changePercent.toStringAsFixed(1)}%';
    } else if (changePercent < 0) {
      changeColor = JusicoolColor.main;
      changeText = '${changePercent.toStringAsFixed(1)}%';
    } else {
      changeColor = JusicoolColor.gray400;
      changeText = '+0.0%';
    }
    return Container(
      height: 58.h,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Text(
            '$rank',
            style: JusicoolTypography.bodyMedium.copyWith(
              color: Colors.black,
            ),
          ),
          SizedBox(width: 50.w),
          Text(
            name,
            style: JusicoolTypography.bodySmall.copyWith(
              color: Colors.black,
            ),
          ),
          Spacer(),
          Text(
            changeText,
            style: JusicoolTypography.bodySmall.copyWith(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              height: 26 / 16,
              letterSpacing: 0,
              color: changeColor,
            ),
          ),
        ],
      ),
    );
  }
}