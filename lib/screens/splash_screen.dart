import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_ios/screens/community_screens/community_post_write_screen.dart';

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WritePostScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          buildPositionedRow(
            top: 132.h,
            left: 24.w,
            text: '스마트한',
            textStyle: AppTypography.titleLarge.copyWith(
              color: AppColor.black,
              fontSize: 48.sp,
            ),
            imagePath: 'assets/images/Cards.png',
            imageWidth: 62.w,
            imageHeight: 62.h,
            isImageFirst: false,
          ),
          buildPositionedRow(
            top: 210.h,
            left: 24.w,
            text: '투자의 시작',
            textStyle: AppTypography.titleLarge.copyWith(
              color: AppColor.black,
              fontSize: 48.sp,
            ),
            imagePath: 'assets/images/Graphic.png',
            imageWidth: 62.w,
            imageHeight: 62.h,
            isImageFirst: true,
          ),
          buildPositionedRow(
            top: 298.h,
            left: 24.w,
            text: null,
            textStyle: null,
            imagePath: 'assets/images/JUSICOOL.png',
            imageWidth: 220.w,
            imageHeight: 32.h,
            trailingImagePath: 'assets/images/Cloud.png',
            trailingImageWidth: 56.w,
            trailingImageHeight: 56.h,
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
    required String imagePath,
    required double imageWidth,
    required double imageHeight,
    String? trailingImagePath,
    double? trailingImageWidth,
    double? trailingImageHeight,
    bool isImageFirst = false,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isImageFirst)
            Image.asset(
              imagePath,
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.cover,
            ),
          if (isImageFirst) SizedBox(width: 10.w),
          if (text != null) Text(text, style: textStyle),
          if (!isImageFirst) SizedBox(width: 10.w),
          if (!isImageFirst)
            Image.asset(
              imagePath,
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.cover,
            ),
          if (trailingImagePath != null) SizedBox(width: 10.w),
          if (trailingImagePath != null)
            Image.asset(
              trailingImagePath,
              width: trailingImageWidth,
              height: trailingImageHeight,
              fit: BoxFit.cover,
            ),
        ],
      ),
    );
  }
}
