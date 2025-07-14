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

  static const List<_NavRoute> _navItems = [
    _NavRoute(label: '자산', icon: 'capital', path: '/capital'),
    _NavRoute(label: '차트', icon: 'chart', path: '/chart'),
    _NavRoute(label: '뉴스', icon: 'news', path: '/news'),
    _NavRoute(label: '마이 페이지', icon: 'account', path: '/account'),
  ];

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return _navItems.indexWhere((item) => location.startsWith(item.path));
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);

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
                            iconName: _navItems[index].icon,
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

class _NavRoute {
  final String label;
  final String icon;
  final String path;

  const _NavRoute({
    required this.label,
    required this.icon,
    required this.path,
  });
}
