import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_ios/presentation/chart_detail/chart_list_page.dart';
import 'package:jusicool_ios/presentation/my_capital/screens/maincapital_screen.dart';

class ScreenConfig {
  ScreenConfig({required this.title, required this.widget});

  final String title;
  final Widget widget;
}

class ScreenList {
  static final List<ScreenConfig> configs = [
    ScreenConfig(title: '자산', widget: const MainCapitalScreen()),
    ScreenConfig(title: '차트', widget: const ChartListPage()),
    ScreenConfig(title: '뉴스', widget: const MainCapitalScreen()),
    ScreenConfig(title: '마이 페이지', widget: const MainCapitalScreen()),
  ];

  static Widget getScreen(int index) {
    if (index < 0 || index >= configs.length) {
      return configs[0].widget;
    }
    return configs[index].widget;
  }

  static String getTitle(int index) {
    if (index < 0 || index >= configs.length) {
      return configs[0].title;
    }
    return configs[index].title;
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.iconName,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String iconName;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  Widget _buildIcon() {
    final color = isSelected ? JusicoolColor.main : JusicoolColor.gray400;

    switch (iconName) {
      case 'capital':
        return JusicoolIcon.pieChart(width: 24.w, height: 24.h, color: color);
      case 'chart':
        return JusicoolIcon.chart(width: 24.w, height: 24.h, color: color);
      case 'news':
        return JusicoolIcon.news(width: 24.w, height: 24.h, color: color);
      case 'account':
        return JusicoolIcon.person(width: 24.w, height: 24.h, color: color);
      default:
        throw Exception('Unknown icon name: $iconName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'navi',
              fontWeight: FontWeight.w600,
              fontSize: 8.sp,
              color: isSelected ? JusicoolColor.main : JusicoolColor.gray400,
            ),
          ),
        ],
      ),
    );
  }
}

class MenuBottom extends StatefulWidget {
  const MenuBottom({super.key});

  @override
  _MenuBottomState createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuBottom> {
  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JusicoolColor.white,
      body: SafeArea(
        top: false,
        bottom: true,
        maintainBottomViewPadding: true,
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: List.generate(
                  ScreenList.configs.length,
                  (index) => ScreenList.getScreen(index),
                ),
              ),
            ),
            Container(
              height: 52.h,
              color: JusicoolColor.white,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: 360.w,
                      height: 1.h,
                      color: JusicoolColor.gray100,
                    ),
                  ),
                  Positioned(
                    left: 42.w,
                    top: 9.h,
                    child: SizedBox(
                      width: 277.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          _navItems.length,
                          (index) => NavBarItem(
                            iconName: _navItems[index]['image']!,
                            label: ScreenList.getTitle(index),
                            isSelected: selectedIndex == index,
                            onTap: () => onTap(index),
                          ),
                        ),
                      ),
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

  static const List<Map<String, String>> _navItems = [
    {'label': '자산', 'image': 'capital'},
    {'label': '차트', 'image': 'chart'},
    {'label': '뉴스', 'image': 'news'},
    {'label': '마이 페이지', 'image': 'account'},
  ];
}
