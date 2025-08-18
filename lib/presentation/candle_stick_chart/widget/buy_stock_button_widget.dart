import 'package:flutter/material.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

class BuyStockButtonWidget extends StatelessWidget {
  const BuyStockButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButtonMedium(
      text: '구매 하기',
      onPressed: () {},
      backgroundColor: JusicoolColor.error,
      textColor: JusicoolColor.white,
      borderColor: Colors.transparent,
    );
  }
}
