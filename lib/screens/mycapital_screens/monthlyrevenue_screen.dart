import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';

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

  Map<String, dynamic> _generateDummyRevenue() {
    final revenue = -10000;
    final percentage = 0.5;
    return {'revenue': revenue, 'percentage': percentage};
  }

  @override
  Widget build(BuildContext context) {
    final dummyRevenue = _generateDummyRevenue();
    final revenue = dummyRevenue['revenue'] as int;
    final percentage = dummyRevenue['percentage'] as double;

    final numberFormat = NumberFormat("#,###", "en_US");
    final formattedRevenue = numberFormat.format(revenue.abs());

    final revenueText =
        revenue >= 0
            ? "+$formattedRevenue원 (+$percentage%)"
            : "-$formattedRevenue원 (-$percentage%)";
    final revenueColor =
        revenue > 0
            ? AppColor.error
            : revenue < 0
            ? AppColor.main
            : AppColor.gray400;

    final statusBarHeight = MediaQuery.of(context).padding.top;

    const appBarHeight = kToolbarHeight;

    final adjustedTextTopPadding =
        (117.h - statusBarHeight - appBarHeight) > 0
            ? (117.h - statusBarHeight - appBarHeight)
            : 0.0;
    final adjustedTabBarTopPadding =
        (164.h - statusBarHeight - appBarHeight) > 0
            ? (164.h - statusBarHeight - appBarHeight)
            : 0.0;

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Container(
        decoration: const BoxDecoration(color: AppColor.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
            SizedBox(height: 16.h),
            Container(
              color: AppColor.white,
              child: TabBar(
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
                tabs: const [Tab(text: "전체"), Tab(text: "주식"), Tab(text: "코인")],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    color: AppColor.white,
                    child: Center(
                      child: Text("전체 내용", style: AppTypography.bodySmall),
                    ),
                  ),

                  Container(
                    color: AppColor.white,
                    child: Center(
                      child: Text("주식 내용", style: AppTypography.bodySmall),
                    ),
                  ),

                  Container(
                    color: AppColor.white,
                    child: Center(
                      child: Text("코인 내용", style: AppTypography.bodySmall),
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
