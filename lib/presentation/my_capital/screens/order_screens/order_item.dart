import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';

class OrderItem extends StatelessWidget {
  final String companyName;
  final int amount;
  final String statusText;

  const OrderItem({
    super.key,
    required this.companyName,
    required this.amount,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,###", "en_US");
    final formattedAmount = numberFormat.format(amount.abs());
    final changeColor = amount >= 0 ? JusicoolColor.error : JusicoolColor.main;

    return Container(
      width: 312.w,
      height: 40.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            companyName,
            style: JusicoolTypography.bodySmall.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: JusicoolColor.black,
            ),
          ),
          Text(
            "$formattedAmount원 $statusText",
            style: JusicoolTypography.label.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: changeColor,
            ),
          ),
        ],
      ),
    );
  }
}
