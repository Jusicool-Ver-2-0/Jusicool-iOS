import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:go_router/go_router.dart';

class MainCapitalScreen extends StatelessWidget {
  const MainCapitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = NumberFormat('#,###');
    final int investmentValue = 123456789;
    final int changeValue = -6555778;
    final double changePercent = 4.0;
    final int monthlyOrderCount = 6;
    final int monthlyProfitValue = 111111111;

    final String formattedInvestmentValue = currencyFormat.format(
      investmentValue,
    );
    final String formattedChangeValue = currencyFormat.format(
      changeValue.abs(),
    );
    final String formattedMonthlyProfit = currencyFormat.format(
      monthlyProfitValue,
    );
    final String formattedOrderCount = currencyFormat.format(monthlyOrderCount);

    final String changeSign = changeValue >= 0 ? "+" : "-";
    final String changeText =
        "$changeSign$formattedChangeValue원 (${changePercent.toStringAsFixed(1)}%)";
    final Color changeColor =
        changeValue >= 0 ? JusicoolColor.error : JusicoolColor.main;
    final String monthlyOrderText = "이번달 $formattedOrderCount건";
    final String monthlyProfit = "+$formattedMonthlyProfit원";
    //===================
    final stockData = [
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

    final coinData = [
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
    //===================

    return Scaffold(
      backgroundColor: JusicoolColor.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          backgroundColor: JusicoolColor.white,
          elevation: 0,
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
          spacing: 8.h,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24.h,
                children: [
                  GestureDetector(
                    onTap: () => context.push('/login'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2.h,
                      children: [
                        Row(
                          spacing: 4.w,
                          children: [
                            Text(
                              "내 자산",
                              style: JusicoolTypography.bodyMedium.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                height: 22 / 16,
                                color: JusicoolColor.black,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
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
                            color: JusicoolColor.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 투자 자산
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2.h,
                    children: [
                      Text(
                        "투자 자산",
                        style: JusicoolTypography.bodyMedium.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 22 / 16,
                          color: JusicoolColor.black,
                        ),
                      ),
                      Text(
                        "$formattedInvestmentValue원",
                        style: JusicoolTypography.titleMedium.copyWith(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w600,
                          height: 43 / 36,
                          color: JusicoolColor.black,
                        ),
                      ),
                      Text(
                        changeText,
                        style: JusicoolTypography.bodySmall.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          height: 22 / 16,
                          color: changeColor,
                        ),
                      ),
                    ],
                  ),

                  /// 보유 주식 & 코인
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.h,
                    children: [
                      Text(
                        "보유 주식&코인",
                        style: JusicoolTypography.subTitle.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          height: 27 / 18,
                          color: JusicoolColor.black,
                        ),
                      ),
                      _buildAssetSection("주식", stockData, currencyFormat),
                      _buildAssetSection("코인", coinData, currencyFormat),
                    ],
                  ),

                  Divider(
                    height: 1.h,
                    thickness: 1.h,
                    color: JusicoolColor.gray400,
                  ),

                  Column(
                    spacing: 8.h,
                    children: [
                      _buildSummaryRow(
                        "주문내역",
                        monthlyOrderText,
                        () => context.push('/order-detail'),
                      ),
                      _buildSummaryRow(
                        "이번달 수익",
                        monthlyProfit,
                        () => context.push('/monthly-revenue'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              height: 24.h,
              color: JusicoolColor.gray100,
            ),

            /// 뉴스 카드
            Container(
              width: 360.w,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              color: JusicoolColor.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16.h,
                children: [
                  Text(
                    "보유 종목 뉴스",
                    style: JusicoolTypography.subTitle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: JusicoolColor.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/login'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.h,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            'https://gongu.copyright.or.kr/gongu/wrt/cmmn/wrtFileImageView.do?wrtSn=11288734&filePath=L2Rpc2sxL25ld2RhdGEvMjAxNS8wMi9DTFM2OS9OVVJJXzAwMV8wMjIwX251cmltZWRpYV8yMDE1MTIwMw==&thumbAt=Y&thumbSe=b_tbumb&wrtTy=10006',
                            width: 312.w,
                            height: 156.h,
                            fit: BoxFit.cover,
                          ),
                        ),
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
                        Text(
                          "2024.07.01",
                          style: JusicoolTypography.bodySmall.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: JusicoolColor.gray400,
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
    );
  }

  Widget _buildSummaryRow(String title, String value, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: JusicoolTypography.bodySmall.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: JusicoolColor.black,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            spacing: 1.w,
            children: [
              Text(
                value,
                style: JusicoolTypography.bodySmall.copyWith(
                  fontSize: 14.sp,
                  color: JusicoolColor.gray600,
                ),
              ),
              JusicoolIcon.forwardArrow(width: 24.w, height: 24.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAssetSection(
    String title,
    List<Map<String, dynamic>> dataList,
    NumberFormat currencyFormat,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(title, style: JusicoolTypography.bodySmall),
        ...dataList.map((item) {
          final isPositive = (item['changeValue'] as int) >= 0;
          final sign = isPositive ? "+" : "-";
          final changeValueStr = currencyFormat.format(
            (item['changeValue'] as int).abs(),
          );
          final priceChange =
              "$sign$changeValueStr원 (${(item['changePercentage'] as double).toStringAsFixed(1)}%)";

          return StockCard(
            companyName: item['companyName'] as String,
            logoUrl: item['imagePath'] as String,
            price: item['amount'] as String,
            priceChange: priceChange,
            share: item['stockCount'] as String,
            isPositive: isPositive,
          );
        }),
      ],
    );
  }
}
