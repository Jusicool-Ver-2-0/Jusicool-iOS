import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_ios/presentation/candle_stick_chart/controller/candle_stick_chart_widget_controller.dart';

class CandleStickItem extends StatefulWidget {
  final int index;

  const CandleStickItem({super.key, required this.index});

  @override
  _CandleStickItemState createState() => _CandleStickItemState();
}

class _CandleStickItemState extends State<CandleStickItem>
    with AutomaticKeepAliveClientMixin {
  final state = Get.find<CandleStickChartWidgetController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          if (widget.index < state.start.value ||
              widget.index >= state.end.value) {
            return const SizedBox();
          }

          final item = state.data[widget.index];
          final changes = item.tradePrice - item.openingPrice;
          final color =
              changes == 0
                  ? JusicoolColor.gray300
                  : changes > 0
                  ? JusicoolColor.mainChartDown
                  : JusicoolColor.mainChartUp;

          final height = constraints.maxHeight;
          final priceRange = state.high.value - state.low.value;
          final ratio =
              (priceRange == 0 || height == 0) ? 1 : priceRange / height;

          final lowMargin = max(0.0, item.lowPrice - state.low.value);
          final bodyBottom = max(
            1.0,
            min(item.openingPrice, item.tradePrice) - state.low.value,
          );
          final double bodyHeight = max(1, (changes.abs()) / ratio);
          final wickHeight = (item.highPrice - item.lowPrice) / ratio;

          return Padding(
            padding: const EdgeInsets.all(1),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedContainer(
                  curve: Curves.easeOutCubic,
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(bottom: lowMargin / ratio),
                  width: 1,
                  height: wickHeight,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                AnimatedContainer(
                  curve: Curves.easeOutCubic,
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(bottom: bodyBottom / ratio),
                  height: bodyHeight,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
