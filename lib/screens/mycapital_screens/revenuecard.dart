import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';

class RevenueCard extends StatelessWidget {
  final String imagePath;
  final String companyName;
  final int amount;
  final int changeValue;
  final double changePercentage;

  const RevenueCard({
    Key? key,
    required this.imagePath,
    required this.companyName,
    required this.amount,
    required this.changeValue,
    required this.changePercentage,
  }) : super(key: key);

  String getFormattedAmount() {
    final numberFormat = NumberFormat("#,###", "en_US");
    if (changeValue > 0) {
      return "+${numberFormat.format(amount)}";
    } else if (changeValue < 0) {
      return "-${numberFormat.format(amount)}";
    } else {
      return "+${numberFormat.format(amount)}";
    }
  }

  Color getChangeColor() {
    if (changeValue > 0) {
      return AppColor.error;
    } else if (changeValue < 0) {
      return AppColor.main;
    } else {
      return AppColor.gray400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedAmount = getFormattedAmount();
    final Color changeColor = getChangeColor();

    return Container(
      width: 312.w,
      height: 48.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 40.w, height: 40.h, fit: BoxFit.cover),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                companyName,
                style: AppTypography.bodySmall.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 22 / 16,
                  letterSpacing: 0,
                  color: AppColor.black,
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Container(
            width: 160.w,
            height: 44.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedAmount,
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 22 / 16,
                    letterSpacing: 0,
                    color: changeColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "(${changePercentage.toStringAsFixed(1)}%)",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 16 / 12,
                    letterSpacing: 0,
                    color: changeColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
