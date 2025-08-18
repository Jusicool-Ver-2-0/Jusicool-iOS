import 'package:freezed_annotation/freezed_annotation.dart';
import 'candle_stick_chart_widget_state.dart';

part 'candle_stick_chart_state.freezed.dart';
@freezed
abstract class CandleStickChartState with _$CandleStickChartState {
  const factory CandleStickChartState({
    @Default([]) List<StockCandleStickChartWidgetData> data,
    @Default(0) double stockPrice,
    @Default("") String stockName,
    @Default(12.0) double itemWidth,
    @Default(0) int start,
    @Default(0) int end,
    @Default(0.0) double high,
    @Default(double.infinity) double low,
  }) = _CandleStickChartState;
}