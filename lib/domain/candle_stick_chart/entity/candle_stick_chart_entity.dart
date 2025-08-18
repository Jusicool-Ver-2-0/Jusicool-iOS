import 'package:freezed_annotation/freezed_annotation.dart';

part 'candle_stick_chart_entity.freezed.dart';

@freezed
abstract class CandleStickChartEntity with _$CandleStickChartEntity {
  const factory CandleStickChartEntity({
    required String market,
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
  }) = _CandleStickChartEntity;
}
