import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_ios/screens/mycapital_screens/revenuecard.dart';

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

  final List<Map<String, dynamic>> revenueData = [
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '애플',
      'amount': 123456789,
      'changeValue': -1000000,
      'changePercentage': 4.0,
      'isStock': true,
    },
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '삼성',
      'amount': 987654321,
      'changeValue': 2000000,

      'changePercentage': 2.5,
      'isStock': true,
    },
    {
      'date': '1월 31일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '비트코인',
      'amount': 123456789,
      'changeValue': 0,
      'changePercentage': 1.8,
      'isStock': false,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '테슬라',
      'amount': 333333333,
      'changeValue': -500000,
      'changePercentage': 0.0,
      'isStock': true,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '구글',
      'amount': 444444444,
      'changeValue': 3000000,
      'changePercentage': 7.9,
      'isStock': true,
    },
    {
      'date': '1월 30일',
      'imagePath': 'assets/images/stock.png',
      'companyName': '이더리움',
      'amount': 777777777,
      'changeValue': 1500000,
      'changePercentage': 7.9,
      'isStock': false,
    },
  ];

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
            ? "+$formattedChange원 (${weightedPercentage.toStringAsFixed(1)}%)"
            : "-$formattedChange원 (${weightedPercentage.toStringAsFixed(1)}%)";
    final revenueColor =
        totalChange > 0
            ? AppColor.error
            : totalChange < 0
            ? AppColor.main
            : AppColor.gray400;

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
                color: AppColor.white,
                padding: EdgeInsets.only(top: 9.h, left: 24.sp, bottom: 16.h),
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
                    setState(() {});
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
                      amount: item['amount'] as int,
                      changeValue: item['changeValue'] as int,
                      changePercentage: item['changePercentage'] as double,
                    ),
                    if (index < filteredData.length - 1) SizedBox(height: 16.h),
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
