import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:go_router/go_router.dart';

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
      changeColor = JusicoolColor.error;
    } else if (changeValue < 0) {
      changeColor = JusicoolColor.main;
    } else {
      changeColor = JusicoolColor.gray400;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(imagePath, width: 40.w, height: 40.h, fit: BoxFit.cover),
        SizedBox(width: 14.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              companyName,
              style: JusicoolTypography.bodySmall.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 22 / 16,
                letterSpacing: 0,
                color: JusicoolColor.black,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              stockCount,
              style: JusicoolTypography.bodySmall.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 22 / 16,
                letterSpacing: 0,
                color: JusicoolColor.gray400,
              ),
            ),
          ],
        ),
        Expanded(child: SizedBox()),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              amount,
              style: JusicoolTypography.bodySmall.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 22 / 16,
                letterSpacing: 0,
                color: JusicoolColor.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              changeText,
              style: JusicoolTypography.label.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 16 / 12,
                letterSpacing: 0,
                color: changeColor,
              ),
            ),
          ],
        ),
      ],
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
      changeColor = JusicoolColor.error;
    } else if (changeValue < 0) {
      changeColor = JusicoolColor.main;
    } else {
      changeColor = JusicoolColor.gray400;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(imagePath, width: 40.w, height: 40.h, fit: BoxFit.cover),
        SizedBox(width: 14.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              companyName,
              style: JusicoolTypography.bodySmall.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 22 / 16,
                letterSpacing: 0,
                color: JusicoolColor.black,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              stockCount,
              style: JusicoolTypography.bodySmall.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 22 / 16,
                letterSpacing: 0,
                color: JusicoolColor.gray400,
              ),
            ),
          ],
        ),
        Expanded(child: SizedBox()),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              amount,
              style: JusicoolTypography.bodySmall.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 22 / 16,
                letterSpacing: 0,
                color: JusicoolColor.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              changeText,
              style: JusicoolTypography.label.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 16 / 12,
                letterSpacing: 0,
                color: changeColor,
              ),
            ),
          ],
        ),
      ],
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
      changeColor = JusicoolColor.error;
    } else if (changeValue < 0) {
      changeColor = JusicoolColor.main;
    } else {
      changeColor = JusicoolColor.gray400;
    }

    final List<Map<String, dynamic>> stockData = [
      {
        'imagePath':
            'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
        'companyName': '애플',
        'stockCount': '123주',
        'amount': '$formattedInvestmentValue원',
        'changeValue': changeValue,
        'changePercentage': changePercent,
      },
      {
        'imagePath':
            'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
        'companyName': '삼성',
        'stockCount': '456주',
        'amount': '$formattedInvestmentValue원',
        'changeValue': 1000000,
        'changePercentage': 2.5,
      },
    ];

    final List<Map<String, dynamic>> coinData = [
      {
        'imagePath':
            'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
        'companyName': '비트코인',
        'stockCount': '0.5코인',
        'amount': '$formattedInvestmentValue원',
        'changeValue': 500000,
        'changePercentage': 1.8,
      },
      {
        'imagePath':
            'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
        'companyName': '이더리움',
        'stockCount': '2코인',
        'amount': '$formattedInvestmentValue원',
        'changeValue': -200000,
        'changePercentage': 0.9,
      },
    ];

    return Scaffold(
      backgroundColor: JusicoolColor.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72.h),
        child: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: JusicoolColor.white,
          elevation: 0,
          leading: SizedBox.shrink(),
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 40.h, left: 24.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: JusicoolImage.logo(width: 116.w, height: 16.81.h),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                spacing: 24.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push('/login');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 4.w,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "내 자산",
                              style: JusicoolTypography.bodyMedium.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                height: 22 / 16,
                                letterSpacing: 0,
                                color: JusicoolColor.black,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15.w,
                              color: JusicoolColor.black,
                            ),
                          ],
                        ),
                        Text(
                          "$formattedInvestmentValue원",
                          style: JusicoolTypography.titleSmall.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            height: 31 / 24,
                            letterSpacing: 0,
                            color: JusicoolColor.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    spacing: 2.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "투자 자산",
                        style: JusicoolTypography.bodyMedium.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 22 / 16,
                          letterSpacing: 0,
                          color: JusicoolColor.black,
                        ),
                      ),
                      Text(
                        "$formattedInvestmentValue원",
                        style: JusicoolTypography.titleMedium.copyWith(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w600,
                          height: 43 / 36,
                          letterSpacing: 0,
                          color: JusicoolColor.black,
                        ),
                      ),
                      Text(
                        changeText,
                        style: JusicoolTypography.bodySmall.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          height: 22 / 16,
                          letterSpacing: 0,
                          color: changeColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 2.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: JusicoolColor.white,
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "보유 주식&코인",
                                style: JusicoolTypography.subTitle.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 27 / 18,
                                  letterSpacing: 0,
                                  color: JusicoolColor.black,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "주식",
                                style: JusicoolTypography.bodySmall.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 22 / 16,
                                  letterSpacing: 0,
                                  color: JusicoolColor.black,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              ...List.generate(stockData.length, (index) {
                                final stock = stockData[index];
                                return Column(
                                  children: [
                                    StockCard(
                                      imagePath: stock['imagePath'] as String,
                                      companyName:
                                          stock['companyName'] as String,
                                      stockCount: stock['stockCount'] as String,
                                      amount: stock['amount'] as String,
                                      changeValue: stock['changeValue'] as int,
                                      changePercentage:
                                          stock['changePercentage'] as double,
                                    ),
                                    if (index < stockData.length - 1)
                                      SizedBox(height: 4.h),
                                  ],
                                );
                              }),
                              SizedBox(height: 16.h),
                              Text(
                                "코인",
                                style: JusicoolTypography.bodySmall.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 22 / 16,
                                  letterSpacing: 0,
                                  color: JusicoolColor.black,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              ...List.generate(coinData.length, (index) {
                                final coin = coinData[index];
                                return Column(
                                  children: [
                                    CoinCard(
                                      imagePath: coin['imagePath'] as String,
                                      companyName:
                                          coin['companyName'] as String,
                                      stockCount: coin['stockCount'] as String,
                                      amount: coin['amount'] as String,
                                      changeValue: coin['changeValue'] as int,
                                      changePercentage:
                                          coin['changePercentage'] as double,
                                    ),
                                    if (index < coinData.length - 1)
                                      SizedBox(height: 4.h),
                                  ],
                                );
                              }),
                              SizedBox(height: 20.h),
                              Container(
                                height: 1.h,
                                width: 312.w,
                                color: JusicoolColor.gray400,
                              ),
                              SizedBox(height: 20.h),
                              Container(
                                width: 312.w,
                                height: 60.h,
                                color: JusicoolColor.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 312.w,
                                      height: 26.h,
                                      color: JusicoolColor.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "주문내역",
                                            style: JusicoolTypography.bodySmall
                                                .copyWith(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                  height: 22 / 16,
                                                  letterSpacing: 0,
                                                  color: JusicoolColor.black,
                                                ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              context.push('/order-detail');
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  monthlyOrderText,
                                                  style: JusicoolTypography
                                                      .bodySmall
                                                      .copyWith(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 16 / 14,
                                                        letterSpacing: 0,
                                                        color:
                                                            JusicoolColor
                                                                .gray600,
                                                      ),
                                                ),
                                                JusicoolIcon.forwardArrow(
                                                  width: 24.w,
                                                  height: 24.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      width: 312.w,
                                      height: 26.h,
                                      color: JusicoolColor.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "이번달 수익",
                                            style: JusicoolTypography.bodySmall
                                                .copyWith(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                  height: 22 / 16,
                                                  letterSpacing: 0,
                                                  color: JusicoolColor.black,
                                                ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              context.push('/monthly-revenue');
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  monthlyProfit,
                                                  style: JusicoolTypography
                                                      .bodySmall
                                                      .copyWith(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 16 / 14,
                                                        letterSpacing: 0,
                                                        color:
                                                            JusicoolColor
                                                                .gray600,
                                                      ),
                                                ),
                                                JusicoolIcon.forwardArrow(
                                                  width: 24.w,
                                                  height: 24.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 24.h,
              color: JusicoolColor.gray100,
            ),
            Container(
              width: 360.w,
              height: 361.h,
              padding: EdgeInsets.only(
                top: 16.h,
                right: 24.w,
                bottom: 16.h,
                left: 24.w,
              ),
              color: JusicoolColor.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "보유 종목 뉴스",
                    style: JusicoolTypography.subTitle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: JusicoolColor.black,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      context.push('/login');
                    },
                    child: Container(
                      width: 312.w,
                      height: 244.h,
                      padding: EdgeInsets.zero,
                      color: JusicoolColor.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 312.w,
                            height: 156.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Image.network(
                              'https://gongu.copyright.or.kr/gongu/wrt/cmmn/wrtFileImageView.do?wrtSn=11288734&filePath=L2Rpc2sxL25ld2RhdGEvMjAxNS8wMi9DTFM2OS9OVVJJXzAwMV8wMjIwX251cmltZWRpYV8yMDE1MTIwMw==&thumbAt=Y&thumbSe=b_tbumb&wrtTy=10006',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "애플, 사상 최고가... 올해 세계경제 2.6% 성장 전망",
                            style: JusicoolTypography.bodyMedium.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: JusicoolColor.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "이데일리",
                            style: JusicoolTypography.label.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: JusicoolColor.gray400,
                            ),
                          ),
                        ],
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
}
