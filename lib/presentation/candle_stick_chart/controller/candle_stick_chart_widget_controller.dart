import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../state/candle_stick_chart_widget_state.dart';
import '../widget/candle_stick_chart/candle_stick_chart_widget.dart';

class CandleStickChartWidgetController extends GetxController {
  late final CandleStickChartWidget widget;
  final data = <StockCandleStickChartWidgetData>[].obs;
  final scrollView = ScrollController();
  final itemWidth = 12.0.obs;
  final high = 0.0.obs;
  final low = double.infinity.obs;
  final start = 0.obs;
  final end = 0.obs;
  var maxWidth = 0.0;
  var scale = 0.0;
  var previousItemWidth = 0.0;
  var previousOffset = 0.0;

  void updateOffset(double offset) {
    if (offset < 0) return;
    final start = offset ~/ itemWidth.value;
    final end = min(
      ((offset + maxWidth) / itemWidth.value).ceil(),
      data.length,
    );

    if (this.start.value == start && this.end.value == end) return;

    this.start.value = start;
    this.end.value = end;

    var high = 0.0;
    var low = double.infinity;
    for (var i = start; i < end; i += 1) {
      final item = data[i];
      if (item.highPrice > high) high = item.highPrice;
      if (item.lowPrice < low) low = item.lowPrice;
    }
    this.high.value = high;
    this.low.value = low;
  }

  void onScaleStart(ScaleStartDetails event) {
    previousItemWidth = itemWidth.value;
    previousOffset = scrollView.offset;
    scale = 0;
  }

  void onScaleUpdate(ScaleUpdateDetails event) {
    var scale = event.scale;
    if (this.scale == 0) {
      this.scale = scale;
      return;
    }
    scale /= this.scale;
    var itemWidth = previousItemWidth * scale;
    itemWidth = max(min(itemWidth, 10), 3);
    scale = itemWidth / previousItemWidth;
    this.itemWidth.value = itemWidth;
    final offset = min(
      previousOffset * scale,
      data.length * itemWidth - maxWidth - 1e-2,
    );
    scrollView.jumpTo(offset);
  }
}
