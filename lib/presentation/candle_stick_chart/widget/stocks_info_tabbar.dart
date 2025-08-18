import 'package:flutter/material.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

class StocksInfoTabBar extends StatelessWidget {
  const StocksInfoTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      padding: EdgeInsets.symmetric(horizontal: 24),
      labelPadding: EdgeInsets.zero,
      tabAlignment: TabAlignment.fill,
      labelStyle: JusicoolTypography.subTitle,
      unselectedLabelColor: JusicoolColor.gray400,
      indicator: BoxDecoration(),
      dividerHeight: 0,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      tabs: [
        Tab(text: '종목 정보'),
        Tab(text: '시세'),
        Tab(text: '뉴스'),
        Tab(text: '커뮤니티'),
      ],
    );
  }
}
