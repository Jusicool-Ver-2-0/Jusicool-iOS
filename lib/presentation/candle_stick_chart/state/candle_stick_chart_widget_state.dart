import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'candle_stick_chart_widget_state.freezed.dart';

@freezed
abstract class StockCandleStickChartWidgetData
    with _$StockCandleStickChartWidgetData {
  const factory StockCandleStickChartWidgetData({
    required DateTime candleDateTimeUtc,
    required DateTime candleDateTimeKst,
    required double openingPrice,
    required double highPrice,
    required double lowPrice,
    required double tradePrice,
    required int timestamp,
    required double candleAccTradePrice,
    required double candleAccTradeVolume,
    required int unit,
  }) = _StockCandleStickChartWidgetData;
}
