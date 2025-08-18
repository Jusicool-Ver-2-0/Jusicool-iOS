import 'package:flutter/material.dart';

class StocksInfoTabBarView extends StatelessWidget {
  const StocksInfoTabBarView({
    super.key,
    required this.tabController,
    required this.stockIntroductionWidget,
    required this.stockQuoteWidget,
    required this.stockNewsWidget,
    required this.stockCommunityWidget,
  });

  final TabController tabController;
  final Widget stockIntroductionWidget;
  final Widget stockQuoteWidget;
  final Widget stockNewsWidget;
  final Widget stockCommunityWidget;

  @override
  Widget build(BuildContext context) {
    switch (tabController.index) {
      case 0:
        return buildItems(stockIntroductionWidget);
      case 1:
        return buildItems(stockQuoteWidget);
      case 2:
        return buildItems(stockNewsWidget);
      case 3:
        return buildItems(stockCommunityWidget);
      default:
        return buildItems(stockIntroductionWidget);
    }
  }

  Widget buildItems(Widget widget) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: widget);
}
