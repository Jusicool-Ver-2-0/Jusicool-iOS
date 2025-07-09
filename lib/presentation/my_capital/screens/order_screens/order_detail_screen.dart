import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_ios/presentation/my_capital/screens/order_screens/order_item.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const double _appBarHeight = kToolbarHeight;
  static const double _tabBarHeight = 48.0;
  static const double _totalHeaderHeight = 176.0;

  final List<Map<String, dynamic>> _completedOrders = _generateDummyOrders(
    "판매 완료",
  );
  final List<Map<String, dynamic>> _reservedOrders = _generateDummyOrders(
    "구매 예약",
  );

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

  //=====================
  static List<Map<String, dynamic>> _generateDummyOrders(String type) {
    const companies = [
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
    return List.generate(20, (i) {
      final company = companies[i % companies.length];
      final amount = (i % 2 == 0 ? 1 : -1) * (37250 + i * 1000);
      return {'companyName': company, 'amount': amount, 'statusText': type};
    });
  }
  //=====================

  double _calculateTopPadding(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final totalUsedHeight = statusBarHeight + _appBarHeight + _tabBarHeight;
    final remainingHeight = _totalHeaderHeight.h - totalUsedHeight;
    return remainingHeight > 0 ? remainingHeight : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = _calculateTopPadding(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: JusicoolColor.white,
        elevation: 0,
        centerTitle: true,
        title: Text("주문내역", style: JusicoolTypography.subTitle),
        bottom: _buildTabBar(),
        leading: IconButton(
          padding: EdgeInsets.only(left: 24.sp),
          icon: const Icon(Icons.arrow_back, color: JusicoolColor.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderListView(topPadding: topPadding, orders: _completedOrders),
          _buildOrderListView(topPadding: topPadding, orders: _reservedOrders),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: JusicoolColor.black,
      unselectedLabelColor: JusicoolColor.gray400,
      padding: EdgeInsets.symmetric(horizontal: 24.sp),
      indicatorColor: JusicoolColor.black,
      indicatorWeight: 1.0,
      indicatorPadding: EdgeInsets.zero,
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (states) =>
            states.contains(WidgetState.focused) ? null : JusicoolColor.white,
      ),
      splashFactory: NoSplash.splashFactory,
      indicator: const BoxDecoration(
        color: JusicoolColor.white,
        border: Border(
          bottom: BorderSide(color: JusicoolColor.black, width: 1.0),
        ),
      ),
      labelStyle: JusicoolTypography.bodyMedium,
      unselectedLabelStyle: JusicoolTypography.bodySmall,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: const [Tab(text: "완료된 주문"), Tab(text: "주문 예약")],
    );
  }

  Widget _buildOrderListView({
    required double topPadding,
    required List<Map<String, dynamic>> orders,
  }) {
    return Container(
      color: JusicoolColor.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: topPadding, left: 24.sp, bottom: 24.sp),
          child: Column(
            spacing: 24.h,
            children:
                orders.map((order) {
                  return OrderItem(
                    companyName: order['companyName'] as String,
                    amount: order['amount'] as int,
                    statusText: order['statusText'] as String,
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
