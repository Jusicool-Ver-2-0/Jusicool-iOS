import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_candles_minutes_response_dto.freezed.dart';

part 'stock_candles_minutes_response_dto.g.dart';

@freezed
abstract class StockCandlesMinutesResponseDto
    with _$StockCandlesMinutesResponseDto {
  const factory StockCandlesMinutesResponseDto({
    required String market,
    @JsonKey(name: 'candle_date_time_utc') required DateTime candleDateTimeUtc,
    @JsonKey(name: 'candle_date_time_kst') required DateTime candleDateTimeKst,
    @JsonKey(name: 'opening_price') required double openingPrice,
    @JsonKey(name: 'high_price') required double highPrice,
    @JsonKey(name: 'low_price') required double lowPrice,
    @JsonKey(name: 'trade_price') required double tradePrice,
    required int timestamp,
    @JsonKey(name: 'candle_acc_trade_price')
    required double candleAccTradePrice,
    @JsonKey(name: 'candle_acc_trade_volume')
    required double candleAccTradeVolume,
    required int unit,
  }) = _StockCandlesMinutesResponseDto;

  factory StockCandlesMinutesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$StockCandlesMinutesResponseDtoFromJson(json);
}
