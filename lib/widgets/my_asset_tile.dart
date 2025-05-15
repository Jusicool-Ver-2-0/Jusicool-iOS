import 'package:flutter/material.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';

class MyAssetTile extends StatelessWidget {
  final String stockName; // 종목명 (예: AMDL)
  final String stockPrice; // 가격 (예: 268,540원)
  final String percentage; // 변동률 (예: 65.7%)
  final Color iconColor; // <-- 이 줄 추가! 아이콘 색상을 직접 지정할 수 있게 함

  const MyAssetTile({
    super.key,
    required this.stockName,
    required this.stockPrice,
    required this.percentage,
    required this.iconColor, // <-- 이 줄 추가! 생성자로 색상 값을 받음
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // 왼쪽 원형 아이콘
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor, // <-- 여기서 위에서 받은 iconColor 변수 사용
              ),
            ),
            const SizedBox(width: 12), // 간격
            // 종목명과 가격
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stockName, style: AppTypography.subTitle),
                Text(
                  stockPrice,
                  style: AppTypography.label.copyWith(color: AppColor.black),
                ),
              ],
            ),
          ],
        ),
        // 오른쪽 변동률
        Text(percentage, style: AppTypography.subTitle),
      ],
    );
  }
}
