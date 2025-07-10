import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

class StockCards extends StatelessWidget {
  final String companyName;
  final String logoUrl;
  final String price;
  final String priceChange;
  final String share;
  final bool isPositive;

  const StockCards({
    super.key,
    required this.companyName,
    required this.logoUrl,
    required this.price,
    required this.priceChange,
    required this.share,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: JusicoolColor.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 14.w,
            children: [
              SizedBox(
                width: 40.w,
                height: 40.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(logoUrl, fit: BoxFit.cover),
                ),
              ),
              Column(
                spacing: 2.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(companyName, style: JusicoolTypography.bodyMedium),
                  Text(
                    share,
                    style: JusicoolTypography.label.copyWith(
                      color: JusicoolColor.gray500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            spacing: 2.h,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: JusicoolTypography.bodyMedium),
              Text(
                priceChange,
                style: JusicoolTypography.label.copyWith(
                  color: isPositive ? JusicoolColor.main : JusicoolColor.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
