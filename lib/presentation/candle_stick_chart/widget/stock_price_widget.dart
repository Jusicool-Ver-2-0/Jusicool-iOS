import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

class StockPriceWidget extends StatelessWidget {
  const StockPriceWidget({super.key, required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedDigitWidget(
          value: price,
          enableSeparator: true,
          textStyle: JusicoolTypography.titleMedium,
        ),
        Text('원', style: JusicoolTypography.titleMedium),
      ],
    );
  }
}
