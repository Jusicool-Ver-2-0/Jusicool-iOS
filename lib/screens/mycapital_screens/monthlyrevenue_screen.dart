import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';

// RevenueCard 위젯 정의
class RevenueCard extends StatelessWidget {
  final String imagePath;
  final String companyName;
  final String amount;
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

// MonthlyRevenueScreen 정의
class MonthlyRevenueScreen extends StatefulWidget {
  const MonthlyRevenueScreen({super.key});

  @override
  _MonthlyRevenueScreenState createState() => _MonthlyRevenueScreenState();
}

class _MonthlyRevenueScreenState extends State<MonthlyRevenueScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 더미 데이터 (3개 날짜, 각 날짜당 10개 카드)
  final List<Map<String, dynamic>> revenueData = [
    // 1월 31일 (최신)
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '애플',
      'amount': 123456789,
      'changeValue': -6555778,
      'changePercentage': 4.0,
      'isStock': true,
    },
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '삼성',
      'amount': 987654321,
      'changeValue': 1000000,
      'changePercentage': 2.5,
      'isStock': true,
    },
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '테슬라',
      'amount': 456789123,
      'changeValue': -2000000,
      'changePercentage': 1.5,
      'isStock': true,
    },
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '구글',
      'amount': 789123456,
      'changeValue': 1500000,
      'changePercentage': 3.0,
      'isStock': true,
    },
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': 'MS',
      'amount': 654321987,
      'changeValue': -500000,
      'changePercentage': 0.8,
      'isStock': true,
    },
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '비트코인',
      'amount': 123456789,
      'changeValue': 500000,
      'changePercentage': 1.8,
      'isStock': false,
    },
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '이더리움',
      'amount': 987654321,
      'changeValue': -200000,
      'changePercentage': 0.9,
      'isStock': false,
    },
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '리플',
      'amount': 456789123,
      'changeValue': 300000,
      'changePercentage': 2.0,
      'isStock': false,
    },
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '카르다노',
      'amount': 789123456,
      'changeValue': -100000,
      'changePercentage': 0.5,
      'isStock': false,
    },
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '솔라나',
      'amount': 321654987,
      'changeValue': 400000,
      'changePercentage': 1.2,
      'isStock': false,
    },
    // 1월 30일
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '애플',
      'amount': 111111111,
      'changeValue': 1111816,
      'changePercentage': 7.9,
      'isStock': true,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '삼성',
      'amount': 222222222,
      'changeValue': -1111816,
      'changePercentage': 7.9,
      'isStock': true,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '테슬라',
      'amount': 333333333,
      'changeValue': 0,
      'changePercentage': 0.0,
      'isStock': true,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '구글',
      'amount': 444444444,
      'changeValue': 1111816,
      'changePercentage': 7.9,
      'isStock': true,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': 'MS',
      'amount': 555555555,
      'changeValue': -1111816,
      'changePercentage': 7.9,
      'isStock': true,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '비트코인',
      'amount': 666666666,
      'changeValue': 1111816,
      'changePercentage': 7.9,
      'isStock': false,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '이더리움',
      'amount': 777777777,
      'changeValue': -1111816,
      'changePercentage': 7.9,
      'isStock': false,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '리플',
      'amount': 888888888,
      'changeValue': 0,
      'changePercentage': 0.0,
      'isStock': false,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '카르다노',
      'amount': 999999999,
      'changeValue': 1111816,
      'changePercentage': 7.9,
      'isStock': false,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '솔라나',
      'amount': 101010101,
      'changeValue': -1111816,
      'changePercentage': 7.9,
      'isStock': false,
    },
    // 1월 29일
    {
      'date': '1월 29일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '애플',
      'amount': 121212121,
      'changeValue': 1111816,
      'changePercentage': 7.9,
      'isStock': true,
    },
    {
      'date': '1월 29일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '삼성',
      'amount': 131313131,
      'changeValue': -1111816,
      'changePercentage': 7.9,
      'isStock': true,
    },
    {
      'date': '1월 29일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '테슬라',
      'amount': 141414141,
      'changeValue': 0,
      'changePercentage': 0.0,
      'isStock': true,
    },
    {
      'date': '1월 29일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '구글',
      'amount': 151515151,
      'changeValue': 1111816,
      'changePercentage': 7.9,
      'isStock': true,
    },
    {
      'date': '1월 29일',
      'imagePath': 'assets/images/stock.png',
      'companyName': 'MS',
      'amount': 161616161,
      'changeValue': -1111816,
      'changePercentage': 7.9,
      'isStock': true,
    },
    {
      'date': '1월 29일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '비트코인',
      'amount': 171717171,
      'changeValue': 1111816,
      'changePercentage': 7.9,
      'isStock': false,
    },
    {
      'date': '1월 29일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '이더리움',
      'amount': 181818181,
      'changeValue': -1111816,
      'changePercentage': 7.9,
      'isStock': false,
    },
    {
      'date': '1월 29일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '리플',
      'amount': 191919191,
      'changeValue': 0,
      'changePercentage': 0.0,
      'isStock': false,
    },
    {
      'date': '1월 29일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '카르다노',
      'amount': 202020202,
      'changeValue': 1111816,
      'changePercentage': 7.9,
      'isStock': false,
    },
    {
      'date': '1월 29일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '솔라나',
      'amount': 212121212,
      'changeValue': -1111816,
      'changePercentage': 7.9,
      'isStock': false,
    },
  ];

  // 이번 달 전체 수익 및 가중 평균 퍼센트 계산
  Map<String, dynamic> _calculateTotalRevenue() {
    final numberFormat = NumberFormat("#,###", "en_US");
    int totalChange = revenueData.fold(
      0,
      (sum, item) => sum + (item['changeValue'] as int),
    );
    int totalAmount = revenueData.fold(
      0,
      (sum, item) => sum + (item['amount'] as int),
    );

    // 가중 평균 퍼센트 계산: (amount * changePercentage) / totalAmount
    double weightedPercentage =
        revenueData.fold(0.0, (sum, item) {
          return sum +
              ((item['amount'] as int) * (item['changePercentage'] as double));
        }) /
        (totalAmount != 0 ? totalAmount : 1);

    return {
      'totalChange': totalChange,
      'weightedPercentage': weightedPercentage.abs(),
      'formattedChange': numberFormat.format(totalChange.abs()),
    };
  }

  @override
  Widget build(BuildContext context) {
    final revenueCalc = _calculateTotalRevenue();
    final totalChange = revenueCalc['totalChange'] as int;
    final weightedPercentage = revenueCalc['weightedPercentage'] as double;
    final formattedChange = revenueCalc['formattedChange'] as String;

    final revenueText =
        totalChange >= 0
            ? "+$formattedChange원 (+${weightedPercentage.toStringAsFixed(1)}%)"
            : "-$formattedChange원 (-${weightedPercentage.toStringAsFixed(1)}%)";
    final revenueColor =
        totalChange > 0
            ? AppColor.error
            : totalChange < 0
            ? AppColor.main
            : AppColor.gray400;

    final statusBarHeight = MediaQuery.of(context).padding.top;
    const appBarHeight = kToolbarHeight;

    final adjustedTextTopPadding =
        (117.h - statusBarHeight - appBarHeight) > 0
            ? (117.h - statusBarHeight - appBarHeight)
            : 0.0;

    // 현재 선택된 탭에 따라 데이터 필터링
    List<Map<String, dynamic>> filteredData = revenueData;
    if (_tabController.index == 1) {
      filteredData =
          revenueData.where((item) => item['isStock'] == true).toList();
    } else if (_tabController.index == 2) {
      filteredData =
          revenueData.where((item) => item['isStock'] == false).toList();
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "이번 달 수익",
          style: AppTypography.subTitle.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                color: AppColor.white, // 수익 텍스트 배경색 변경
                padding: EdgeInsets.only(
                  top: adjustedTextTopPadding,
                  left: 24.sp,
                ),
                child: Text(
                  revenueText,
                  style: AppTypography.titleSmall.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: revenueColor,
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppColor.black,
                  unselectedLabelColor: AppColor.gray400,
                  padding: EdgeInsets.symmetric(horizontal: 24.sp),
                  indicatorColor: AppColor.black,
                  automaticIndicatorColorAdjustment: true,
                  indicatorWeight: 1.0,
                  indicatorPadding: EdgeInsets.zero,
                  overlayColor: WidgetStateProperty.resolveWith<Color?>((
                    Set<WidgetState> states,
                  ) {
                    return states.contains(WidgetState.focused)
                        ? null
                        : AppColor.white;
                  }),
                  splashFactory: NoSplash.splashFactory,
                  indicator: BoxDecoration(
                    color: AppColor.white,
                    border: Border(
                      bottom: BorderSide(color: AppColor.black, width: 1.0),
                    ),
                  ),
                  labelStyle: AppTypography.bodyMedium,
                  unselectedLabelStyle: AppTypography.bodySmall,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: "전체"),
                    Tab(text: "주식"),
                    Tab(text: "코인"),
                  ],
                  onTap: (index) {
                    setState(() {}); // 탭 변경 시 UI 갱신
                  },
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: AppColor.white,
          child: Padding(
            padding: EdgeInsets.only(left: 24.sp, top: 16.h),
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                final date = item['date'] as String;
                final isNewDate =
                    index == 0 || filteredData[index - 1]['date'] != date;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isNewDate)
                      Text(
                        date,
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.black,
                        ),
                      ),
                    if (isNewDate) SizedBox(height: 4.h),
                    RevenueCard(
                      imagePath: item['imagePath'] as String,
                      companyName: item['companyName'] as String,
                      amount:
                          NumberFormat(
                            "#,###",
                            "en_US",
                          ).format(item['amount']) +
                          "원",
                      changeValue: item['changeValue'] as int,
                      changePercentage: item['changePercentage'] as double,
                    ),
                    if (index < filteredData.length - 1) SizedBox(height: 4.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// SliverPersistentHeader를 위한 Delegate 클래스
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColor.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
