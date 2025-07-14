import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
