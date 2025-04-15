import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jusicool_ios/main.dart';
import 'package:tes/src/core/theme/colors/color_palette.dart';
import 'package:tes/src/core/theme/texts/typography.dart';

double leftPadding = 24;
double textPadding = 10;
double titleSize = 48;

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
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          _buildPositionedRow(
            top: 132,
            left: leftPadding,
            text: '스마트한',
            textStyle: AppTypography.titleLarge.copyWith(
              color: AppColor.black,
              fontSize: titleSize,
            ),
            imagePath: 'assets/images/Cards.png',
            imageWidth: 62,
            imageHeight: 62,
            isImageFirst: false,
          ),
          _buildPositionedRow(
            top: 210,
            left: leftPadding,
            text: '투자의 시작',
            textStyle: AppTypography.titleLarge.copyWith(
              color: AppColor.black,
              fontSize: titleSize,
            ),
            imagePath: 'assets/images/Graphic.png',
            imageWidth: 62,
            imageHeight: 62,
            isImageFirst: true,
          ),
          _buildPositionedRow(
            top: 298,
            left: leftPadding,
            text: null,
            textStyle: null,
            imagePath: 'assets/images/JUSICOOL.png',
            imageWidth: 220,
            imageHeight: 32,
            trailingImagePath: 'assets/images/Cloud.png',
            trailingImageWidth: 56,
            trailingImageHeight: 56,
            isImageFirst: false,
          ),
        ],
      ),
    );
  }

  Widget _buildPositionedRow({
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
            Image.asset(imagePath, width: imageWidth, height: imageHeight),
          if (isImageFirst) SizedBox(width: textPadding),
          if (text != null) Text(text, style: textStyle),
          if (!isImageFirst) SizedBox(width: textPadding),
          if (!isImageFirst)
            Image.asset(imagePath, width: imageWidth, height: imageHeight),
          if (trailingImagePath != null) SizedBox(width: textPadding),
          if (trailingImagePath != null)
            Image.asset(
              trailingImagePath,
              width: trailingImageWidth,
              height: trailingImageHeight,
            ),
        ],
      ),
    );
  }
}
