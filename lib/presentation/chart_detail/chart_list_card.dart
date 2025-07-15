import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:intl/intl.dart';

class ChartListCard extends StatelessWidget {
  final String imageUrl;
  final String chartName;
  final int price;
  final int changeValue;
  final double changePercent;

  const ChartListCard({
    super.key,
    required this.imageUrl,
    required this.chartName,
    required this.price,
    required this.changeValue,
    required this.changePercent,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');
    final String priceText = numberFormat.format(price);
    final String changeSign = changeValue >= 0 ? '+' : '-';
    final String changeValueText = numberFormat.format(changeValue.abs());
    final String percentText = changePercent.toStringAsFixed(1);
    final Color changeColor =
        changeValue > 0
            ? JusicoolColor.error
            : changeValue < 0
            ? JusicoolColor.main
            : JusicoolColor.gray400;

    return Container(
      width: 312.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: JusicoolColor.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: Image.network(
              imageUrl,
              width: 32.w,
              height: 32.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 7.h),
            child: Text(
              chartName,
              style: JusicoolTypography.subTitle.copyWith(
                color: JusicoolColor.black,
              ),
            ),
          ),
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$priceText 원',
                style: JusicoolTypography.bodySmall.copyWith(
                  color: JusicoolColor.black,
                  height: 1.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(
                  '$changeSign$changeValueText ($percentText%)',
                  style: JusicoolTypography.label.copyWith(
                    color: changeColor,
                    height: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}