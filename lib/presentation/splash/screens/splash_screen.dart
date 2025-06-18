import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.pushReplacement('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JusicoolColor.white,
      body: Stack(
        children: [
          buildPositionedRow(
            top: 132.h,
            left: 24.w,
            text: '스마트한',
            textStyle: JusicoolTypography.titleLarge.copyWith(
              color: JusicoolColor.black,
              fontSize: 48.sp,
            ),
            image: JusicoolImage.card(width: 62.w, height: 62.h),
            isImageFirst: false,
          ),
          buildPositionedRow(
            top: 210.h,
            left: 24.w,
            text: '투자의 시작',
            textStyle: JusicoolTypography.titleLarge.copyWith(
              color: JusicoolColor.black,
              fontSize: 48.sp,
            ),
            image: JusicoolImage.graphic(width: 62.w, height: 62.h),
            isImageFirst: true,
          ),
          buildPositionedRow(
            top: 298.h,
            left: 24.w,
            text: null,
            textStyle: null,
            image: JusicoolImage.logo(width: 220.w, height: 32.h),
            trailingImage: JusicoolImage.cloud(width: 56.w, height: 56.h),
            isImageFirst: false,
          ),
        ],
      ),
    );
  }

  Widget buildPositionedRow({
    required double top,
    required double left,
    String? text,
    TextStyle? textStyle,
    required Widget image,
    Widget? trailingImage,
    bool isImageFirst = false,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isImageFirst) image,
          if (isImageFirst) SizedBox(width: 10.w),
          if (text != null) Text(text, style: textStyle),
          if (!isImageFirst) SizedBox(width: 10.w),
          if (!isImageFirst) image,
          if (trailingImage != null) SizedBox(width: 10.w),
          if (trailingImage != null) trailingImage,
        ],
      ),
    );
  }
}
