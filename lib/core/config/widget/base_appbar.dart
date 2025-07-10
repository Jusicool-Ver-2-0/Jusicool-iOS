import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

class BaseAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppbar({
    super.key,
    this.title = '',
    this.centerTitle = true,
    this.textStyle,
    this.backgroundColor,
    this.actionWidgets,
    this.backButton = false,
  });

  final String title;
  final bool centerTitle;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final bool backButton;
  final List<Widget>? actionWidgets;
  final double elevation = 0.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? JusicoolColor.white,
      elevation: elevation,
      scrolledUnderElevation: 0.0,
      titleTextStyle: textStyle ?? JusicoolTypography.subTitle,
      leading:
          backButton
              ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: JusicoolIcon.backArrow(
                  width: 24.w,
                  height: 24.h,
                  color: JusicoolColor.black,
                ),
              )
              : null,
      actionsPadding: EdgeInsets.only(right: 24),
      actions: actionWidgets ?? [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(57.h);
}
