import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

class RevenueCard extends StatelessWidget {
  final String imagePath;
  final String companyName;
  final int amount;
  final int changeValue;
  final double changePercentage;

  const RevenueCard({
    super.key,
    required this.imagePath,
    required this.companyName,
    required this.amount,
    required this.changeValue,
    required this.changePercentage,
  });

  String getFormattedAmount() {
    final numberFormat = NumberFormat("#,###", "en_US");
    final sign = changeValue < 0 ? "-" : "+";
    return "$sign${numberFormat.format(amount)}";
  }

  Color getChangeColor() {
    if (changeValue > 0) {
      return JusicoolColor.error;
    } else if (changeValue < 0) {
      return JusicoolColor.main;
    } else {
      return JusicoolColor.gray400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedAmount = getFormattedAmount();
    final changeColor = getChangeColor();

    return SizedBox(
      width: 312.w,
      height: 48.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12.w, // 이미지와 다음 요소 사이 간격
        children: [
          Image.network(
            imagePath,
            width: 40.w,
            height: 40.h,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  companyName,
                  style: JusicoolTypography.bodySmall.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 22 / 16,
                    color: JusicoolColor.black,
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 2.h, // 수익 금액과 퍼센트 사이 간격
                  children: [
                    Text(
                      formattedAmount,
                      style: JusicoolTypography.bodySmall.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 22 / 16,
                        color: changeColor,
                      ),
                    ),
                    Text(
                      "(${changePercentage.toStringAsFixed(1)}%)",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 16 / 12,
                        color: changeColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
