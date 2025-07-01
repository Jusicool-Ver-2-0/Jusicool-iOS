import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_ios/presentation/my_capital/screens/order_screens/order_item.dart';

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
  //====================================

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

  //====================================
  @override
  Widget build(BuildContext context) {
    final dummyCompletedOrders = _generateDummyCompletedOrders();
    final dummyReservedOrders = _generateDummyReservedOrders();

    final statusBarHeight = MediaQuery.of(context).padding.top;

    const JusicoolBarHeight = kToolbarHeight;

    const tabBarHeight = 48.0;

    final adjustedTopPadding =
        (176.h - statusBarHeight - JusicoolBarHeight - tabBarHeight) > 0
            ? (176.h - statusBarHeight - JusicoolBarHeight - tabBarHeight)
            : 0.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: JusicoolColor.white,
        elevation: 0,
        centerTitle: true,
        title: Text("주문내역", style: JusicoolTypography.subTitle),
        bottom: TabBar(
          controller: _tabController,
          labelColor: JusicoolColor.black,
          unselectedLabelColor: JusicoolColor.gray400,
          padding: EdgeInsets.symmetric(horizontal: 24.sp),
          indicatorColor: JusicoolColor.black,
          automaticIndicatorColorAdjustment: true,
          indicatorWeight: 1.0,
          indicatorPadding: EdgeInsets.zero,
          overlayColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            return states.contains(WidgetState.focused)
                ? null
                : JusicoolColor.white;
          }),
          splashFactory: NoSplash.splashFactory,
          indicator: BoxDecoration(
            color: JusicoolColor.white,
            border: Border(
              bottom: BorderSide(color: JusicoolColor.black, width: 1.0),
            ),
          ),
          labelStyle: JusicoolTypography.bodyMedium,
          unselectedLabelStyle: JusicoolTypography.bodySmall,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [Tab(text: "완료된 주문"), Tab(text: "주문 예약")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: JusicoolColor.white,
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
            color: JusicoolColor.white,
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
