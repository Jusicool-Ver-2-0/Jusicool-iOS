import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

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

class MenuBottom extends StatelessWidget {
  const MenuBottom({super.key, required this.child});
  final Widget child;

  static const List<_NavItemData> _navItems = [
    _NavItemData(path: '/main-capital', iconName: 'capital', label: '자산'),
    _NavItemData(path: '/main-capital', iconName: 'chart', label: '차트'),
    _NavItemData(path: '/news-list', iconName: 'news', label: '뉴스'),
    _NavItemData(path: '/main-capital', iconName: 'account', label: '마이 페이지'),
  ];

  int _locationToIndex(String location) {
    return _navItems.indexWhere((item) => location.startsWith(item.path));
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = _locationToIndex(location);

    return Scaffold(
      backgroundColor: JusicoolColor.white,
      body: SafeArea(
        top: false,
        bottom: true,
        maintainBottomViewPadding: true,
        child: Column(
          children: [
            Expanded(child: child),
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
                            iconName: _navItems[index].iconName,
                            label: _navItems[index].label,
                            isSelected: selectedIndex == index,
                            onTap: () {
                              if (selectedIndex != index) {
                                context.go(_navItems[index].path);
                              }
                            },
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
}

class _NavItemData {
  final String path;
  final String iconName;
  final String label;

  const _NavItemData({
    required this.path,
    required this.iconName,
    required this.label,
  });
}
