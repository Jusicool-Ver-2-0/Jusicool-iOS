import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';

class OrderItem extends StatelessWidget {
  final String companyName;
  final int amount;
  final String statusText;

  const OrderItem({
    super.key,
    required this.companyName,
    required this.amount,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,###", "en_US");
    final formattedAmount = numberFormat.format(amount.abs());
    final changeColor = amount >= 0 ? AppColor.error : AppColor.main;

    return Container(
      width: 312.w,
      height: 40.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            companyName,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.black,
            ),
          ),
          Text(
            "$formattedAmount원 $statusText",
            style: AppTypography.label.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: changeColor,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _generateDummyCompletedOrders() {
    final companies = [
      "애플",
      "삼성",
      "테슬라",
      "구글",
      "아마존",
      "마이크로소프트",
      "페이스북",
      "넷플릭스",
      "엔비디아",
      "인텔",
    ];
    final List<Map<String, dynamic>> orders = [];
    for (int i = 0; i < 20; i++) {
      final companyIndex = i % companies.length;
      final amount = (i % 2 == 0 ? 1 : -1) * (37250 + i * 1000);
      orders.add({'companyName': companies[companyIndex], 'amount': amount});
    }

    return orders.length > 100 ? orders.sublist(0, 100) : orders;
  }

  List<Map<String, dynamic>> _generateDummyReservedOrders() {
    final companies = [
      "애플",
      "삼성",
      "테슬라",
      "구글",
      "아마존",
      "마이크로소프트",
      "페이스북",
      "넷플릭스",
      "엔비디아",
      "인텔",
    ];
    final List<Map<String, dynamic>> orders = [];
    for (int i = 0; i < 20; i++) {
      final companyIndex = i % companies.length;
      final amount = (i % 2 == 0 ? 1 : -1) * (37250 + i * 1000);
      orders.add({'companyName': companies[companyIndex], 'amount': amount});
    }

    return orders;
  }

  @override
  Widget build(BuildContext context) {
    final dummyCompletedOrders = _generateDummyCompletedOrders();
    final dummyReservedOrders = _generateDummyReservedOrders();

    final statusBarHeight = MediaQuery.of(context).padding.top;

    const appBarHeight = kToolbarHeight;

    const tabBarHeight = 48.0;

    final adjustedTopPadding =
        (176.h - statusBarHeight - appBarHeight - tabBarHeight) > 0
            ? (176.h - statusBarHeight - appBarHeight - tabBarHeight)
            : 0.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        centerTitle: true,
        title: Text("주문내역", style: AppTypography.subTitle),
        bottom: TabBar(
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
            return states.contains(WidgetState.focused) ? null : AppColor.white;
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
          tabs: const [Tab(text: "완료된 주문"), Tab(text: "주문 예약")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: AppColor.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: adjustedTopPadding,
                  left: 24.sp,
                  bottom: 24.sp,
                ),
                child: Column(
                  children: List.generate(dummyCompletedOrders.length, (index) {
                    final order = dummyCompletedOrders[index];
                    return Column(
                      children: [
                        OrderItem(
                          companyName: order['companyName'] as String,
                          amount: order['amount'] as int,
                          statusText: "판매 완료",
                        ),
                        if (index < dummyCompletedOrders.length - 1)
                          SizedBox(height: 24.h),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),

          Container(
            color: AppColor.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: adjustedTopPadding,
                  left: 24.sp,
                  bottom: 24.sp,
                ),
                child: Column(
                  children: List.generate(dummyReservedOrders.length, (index) {
                    final order = dummyReservedOrders[index];
                    return Column(
                      children: [
                        OrderItem(
                          companyName: order['companyName'] as String,
                          amount: order['amount'] as int,
                          statusText: "구매 예약",
                        ),
                        if (index < dummyReservedOrders.length - 1)
                          SizedBox(height: 24.h),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
