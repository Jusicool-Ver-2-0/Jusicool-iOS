import 'package:flutter/material.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

class StockIntroductionWidget extends StatelessWidget {
  const StockIntroductionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '마이크로소프트(Microsoft Corporation)는 미국의 다국적 기술 기업으로, 소프트웨어, 서비스, 디바이스 및 솔루션을 개발하고 지원합니다. 대표적인 제품으로는 Windows 운영 체제, Microsoft 365 생산성 응용 프로그램 제품군, Edge 웹 브라우저, Xbox 비디오 게임 콘솔, Surface 터치스크린 개인용 컴퓨터 등이 있습니다',
      style: JusicoolTypography.bodySmall,
    );
  }
}
