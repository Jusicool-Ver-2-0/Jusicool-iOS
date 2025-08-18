import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import '../../../core/config/widget/base_appbar.dart';
import '../../../core/config/widget/base_scaffold.dart';

class CandlestickChartScaffold extends BaseScaffold {
  const CandlestickChartScaffold({
    super.key,
    required this.stockName,
    required this.stockPriceWidget,
    required this.candlestickChartWidget,
    required this.buyStockButtonWidget,
    required this.stocksInfoTabBar,
    required this.stocksInfoTabBarView,
  });

  final String stockName;
  final Widget stockPriceWidget;
  final Widget candlestickChartWidget;
  final Widget buyStockButtonWidget;
  final Widget stocksInfoTabBar;
  final Widget stocksInfoTabBarView;

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          spacing: 24,
          children: [
            stockPriceWidget,
            SizedBox(height: 400, child: Row(
              children: [
                Expanded(child: candlestickChartWidget),
                Text('data')
              ],
            )),
            buyStockButtonWidget,
            stocksInfoTabBar,
            stocksInfoTabBarView,
          ],
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return BaseAppbar(
      title: stockName,
      backButton: true,
      actionWidgets: [
        IconButton(
          onPressed: () {},
          icon: JusicoolIcon.setting(
            width: 24.w,
            height: 24.h,
            color: JusicoolColor.black,
          ),
        ),
      ],
    );
  }
}
