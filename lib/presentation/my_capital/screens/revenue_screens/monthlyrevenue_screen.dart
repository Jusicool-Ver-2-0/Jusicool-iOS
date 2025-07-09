import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_ios/presentation/my_capital/screens/revenue_screens/revenuecard.dart';
import 'package:go_router/go_router.dart';

const double adjustedTopPadding = 16.0;

class MonthlyRevenueScreen extends StatefulWidget {
  const MonthlyRevenueScreen({super.key});

  @override
  State<MonthlyRevenueScreen> createState() => _MonthlyRevenueScreenState();
}

class _MonthlyRevenueScreenState extends State<MonthlyRevenueScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> revenueData = [
    {
      'date': '1월 31일',
      'imagePath':
          'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
      'companyName': '애플',
      'amount': 123456789,
      'changeValue': -1000000,
      'changePercentage': 4.0,
      'isStock': true,
    },
    {
      'date': '1월 31일',
      'imagePath':
          'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
      'companyName': '삼성',
      'amount': 987654321,
      'changeValue': 2000000,
      'changePercentage': 2.5,
      'isStock': true,
    },
    {
      'date': '1월 31일',
      'imagePath':
          'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
      'companyName': '비트코인',
      'amount': 123456789,
      'changeValue': 0,
      'changePercentage': 1.8,
      'isStock': false,
    },
    {
      'date': '1월 30일',
      'imagePath':
          'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
      'companyName': '테슬라',
      'amount': 333333333,
      'changeValue': -500000,
      'changePercentage': 0.0,
      'isStock': true,
    },
    {
      'date': '1월 30일',
      'imagePath':
          'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
      'companyName': '구글',
      'amount': 444444444,
      'changeValue': 3000000,
      'changePercentage': 7.9,
      'isStock': true,
    },
    {
      'date': '1월 30일',
      'imagePath':
          'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
      'companyName': '이더리움',
      'amount': 777777777,
      'changeValue': 1500000,
      'changePercentage': 7.9,
      'isStock': false,
    },
  ];

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

  Map<String, dynamic> _calculateTotalRevenue() {
    final numberFormat = NumberFormat("#,###", "en_US");

    final totalChange = revenueData.fold<int>(
      0,
      (sum, item) => sum + (item['changeValue'] as int),
    );

    final totalAmount = revenueData.fold<int>(
      0,
      (sum, item) => sum + (item['amount'] as int),
    );

    final weightedPercentage =
        revenueData.fold<double>(
          0.0,
          (sum, item) =>
              sum +
              ((item['amount'] as int) * (item['changePercentage'] as double)),
        ) /
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
            ? JusicoolColor.error
            : totalChange < 0
            ? JusicoolColor.main
            : JusicoolColor.gray400;

    List<Map<String, dynamic>> filteredData = switch (_tabController.index) {
      1 => revenueData.where((item) => item['isStock'] == true).toList(),
      2 => revenueData.where((item) => item['isStock'] == false).toList(),
      _ => revenueData,
    };

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: JusicoolColor.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.only(left: 24.sp),
          icon: const Icon(Icons.arrow_back, color: JusicoolColor.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "이번 달 수익",
          style: JusicoolTypography.subTitle.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: JusicoolColor.black,
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder:
            (context, _) => [
              SliverToBoxAdapter(
                child: Container(
                  color: JusicoolColor.white,
                  padding: EdgeInsets.only(top: 9.h, left: 24.sp, bottom: 16.h),
                  child: Text(
                    revenueText,
                    style: JusicoolTypography.titleSmall.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: revenueColor,
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverJusicoolBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: JusicoolColor.black,
                    unselectedLabelColor: JusicoolColor.gray400,
                    padding: EdgeInsets.symmetric(horizontal: 24.sp),
                    indicatorColor: JusicoolColor.black,
                    indicator: const BoxDecoration(
                      color: JusicoolColor.white,
                      border: Border(
                        bottom: BorderSide(
                          color: JusicoolColor.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    indicatorWeight: 1.0,
                    indicatorPadding: EdgeInsets.zero,
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    labelStyle: JusicoolTypography.bodyMedium,
                    unselectedLabelStyle: JusicoolTypography.bodySmall,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(text: "전체"),
                      Tab(text: "주식"),
                      Tab(text: "코인"),
                    ],
                    onTap: (_) => setState(() {}),
                  ),
                ),
              ),
            ],
        body: Container(
          color: JusicoolColor.white,
          child: Padding(
            padding: EdgeInsets.only(left: 24.sp, top: adjustedTopPadding.h),
            child: ListView.separated(
              itemCount: filteredData.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final item = filteredData[index];
                final date = item['date'] as String;
                final isNewDate =
                    index == 0 || filteredData[index - 1]['date'] != date;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    if (isNewDate)
                      Text(
                        date,
                        style: JusicoolTypography.bodySmall.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: JusicoolColor.black,
                        ),
                      ),
                    RevenueCard(
                      imagePath: item['imagePath'] as String,
                      companyName: item['companyName'] as String,
                      amount: item['amount'] as int,
                      changeValue: item['changeValue'] as int,
                      changePercentage: item['changePercentage'] as double,
                    ),
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

class _SliverJusicoolBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverJusicoolBarDelegate(this._tabBar);

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
    return Container(color: JusicoolColor.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(covariant _SliverJusicoolBarDelegate oldDelegate) => false;
}
