import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_ios/screens/login_screen.dart';
import 'package:jusicool_ios/screens/mycapital_screens/monthlyrevenue_screen.dart';
import 'package:jusicool_ios/screens/mycapital_screens/order_detail.dart';

class StockCard extends StatelessWidget {
  final String imagePath;
  final String companyName;
  final String stockCount;
  final String amount;
  final int changeValue;
  final double changePercentage;

  const StockCard({
    Key? key,
    required this.imagePath,
    required this.companyName,
    required this.stockCount,
    required this.amount,
    required this.changeValue,
    required this.changePercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,###", "en_US");
    String changeSign = changeValue >= 0 ? "+" : "-";
    String formattedChangeValue = numberFormat.format(changeValue.abs());
    String changeText =
        "$changeSign$formattedChangeValue (${changePercentage.toStringAsFixed(1)}%)";
    Color changeColor;
    if (changeValue > 0) {
      changeColor = AppColor.error;
    } else if (changeValue < 0) {
      changeColor = AppColor.main;
    } else {
      changeColor = AppColor.gray400;
    }

    return Container(
      width: 312.w,
      height: 48.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 40.w, height: 40.h, fit: BoxFit.cover),
          SizedBox(width: 14.w),
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
              SizedBox(height: 2.h),
              Text(
                stockCount,
                style: AppTypography.bodySmall.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 22 / 16,
                  letterSpacing: 0,
                  color: AppColor.gray400,
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
                  amount,
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 22 / 16,
                    letterSpacing: 0,
                    color: AppColor.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  changeText,
                  style: AppTypography.label.copyWith(
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

class CoinCard extends StatelessWidget {
  final String imagePath;
  final String companyName;
  final String stockCount;
  final String amount;
  final int changeValue;
  final double changePercentage;

  const CoinCard({
    Key? key,
    required this.imagePath,
    required this.companyName,
    required this.stockCount,
    required this.amount,
    required this.changeValue,
    required this.changePercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,###", "en_US");
    String changeSign = changeValue >= 0 ? "+" : "-";
    String formattedChangeValue = numberFormat.format(changeValue.abs());
    String changeText =
        "$changeSign$formattedChangeValue (${changePercentage.toStringAsFixed(1)}%)";
    Color changeColor;
    if (changeValue > 0) {
      changeColor = AppColor.error;
    } else if (changeValue < 0) {
      changeColor = AppColor.main;
    } else {
      changeColor = AppColor.gray400;
    }

    return Container(
      width: 312.w,
      height: 48.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 40.w, height: 40.h, fit: BoxFit.cover),
          SizedBox(width: 14.w),
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
              SizedBox(height: 2.h),
              Text(
                stockCount,
                style: AppTypography.bodySmall.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 22 / 16,
                  letterSpacing: 0,
                  color: AppColor.gray400,
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
                  amount,
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 22 / 16,
                    letterSpacing: 0,
                    color: AppColor.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  changeText,
                  style: AppTypography.label.copyWith(
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

class MainCapitalScreen extends StatelessWidget {
  const MainCapitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int investmentValue = 123456789;
    final int changeValue = -6555778;
    final double changePercent = 4.0;

    final int monthlyOrderCount = 6;
    final String formattedOrderCount = NumberFormat(
      '#,###',
    ).format(monthlyOrderCount);
    final String monthlyOrderText = "이번달 ${formattedOrderCount}건";

    final int monthlyProfitValue = 111111111;
    final String formattedMonthlyProfit = NumberFormat(
      '#,###',
    ).format(monthlyProfitValue);
    final String monthlyProfit = "+$formattedMonthlyProfit원";

    final String formattedInvestmentValue = NumberFormat(
      '#,###',
    ).format(investmentValue);
    final String formattedChangeValue = NumberFormat(
      '#,###',
    ).format(changeValue.abs());

    String changeSign = changeValue >= 0 ? "+" : "-";
    String changeText =
        "$changeSign$formattedChangeValue원 (${changePercent.toStringAsFixed(1)}%)";
    Color changeColor;
    if (changeValue > 0) {
      changeColor = AppColor.error;
    } else if (changeValue < 0) {
      changeColor = AppColor.main;
    } else {
      changeColor = AppColor.gray400;
    }

    final List<Map<String, dynamic>> stockData = [
      {
        'imagePath': 'assets/images/stock.png',
        'companyName': '애플',
        'stockCount': '123주',
        'amount': '$formattedInvestmentValue원',
        'changeValue': changeValue,
        'changePercentage': changePercent,
      },
      {
        'imagePath': 'assets/images/stock.png',
        'companyName': '삼성',
        'stockCount': '456주',
        'amount': '$formattedInvestmentValue원',
        'changeValue': 1000000,
        'changePercentage': 2.5,
      },
    ];

    final List<Map<String, dynamic>> coinData = [
      {
        'imagePath': 'assets/images/stock.png',
        'companyName': '비트코인',
        'stockCount': '0.5코인',
        'amount': '$formattedInvestmentValue원',
        'changeValue': 500000,
        'changePercentage': 1.8,
      },
      {
        'imagePath': 'assets/images/stock.png',
        'companyName': '이더리움',
        'stockCount': '2코인',
        'amount': '$formattedInvestmentValue원',
        'changeValue': -200000,
        'changePercentage': 0.9,
      },
    ];

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72.h),
        child: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: AppColor.white,
          elevation: 0,
          leading: SizedBox.shrink(),
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 40.h, left: 24.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/JUSICOOL.png',
                width: 116.w,
                height: 16.81.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
