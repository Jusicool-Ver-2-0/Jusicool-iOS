import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

class RecentlySearchBlock extends StatelessWidget {
  final String chartName;
  final int changeValue;
  final double changePercent;
  final VoidCallback? onRemove;
  const RecentlySearchBlock({
    super.key,
    required this.chartName,
    required this.changeValue,
    required this.changePercent,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final String percentText = changePercent.abs().toStringAsFixed(1);
    String sign;
    Color percentColor;
    if (changePercent == 0) {
      sign = '+';
      percentColor = JusicoolColor.gray400;
    } else if (changePercent > 0) {
      sign = '+';
      percentColor = JusicoolColor.error;
    } else {
      sign = '-';
      percentColor = JusicoolColor.main;
    }
    return Container(
      constraints: BoxConstraints(minHeight: 32.h, minWidth: 60.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: JusicoolColor.gray100,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              chartName,
              overflow: TextOverflow.ellipsis,
              style: JusicoolTypography.label.copyWith(
                color: JusicoolColor.gray600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              '$sign$percentText%',
              style: JusicoolTypography.label.copyWith(
                color: percentColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (onRemove != null)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.close,
                  size: 16.w,
                  color: JusicoolColor.gray600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}