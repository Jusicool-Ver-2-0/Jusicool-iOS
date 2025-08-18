import 'package:jusicool_ios/data/stock/dto/remote/response/stock_candles_minutes_response_dto.dart';
import '../../../../../domain/candle_stick_chart/entity/candle_stick_chart_entity.dart';

class StockCandlesMinutesResponseMapper {
  static Future<List<CandleStickChartEntity>> toEntity(
    List<StockCandlesMinutesResponseDto> dto,
  ) async {
    return dto.map((e) {
      return CandleStickChartEntity(
        candleDateTimeUtc: e.candleDateTimeUtc,
        market: e.market,
        candleDateTimeKst: e.candleDateTimeKst,
        openingPrice: e.openingPrice,
        highPrice: e.highPrice,
        lowPrice: e.lowPrice,
        tradePrice: e.tradePrice,
        timestamp: e.timestamp,
        candleAccTradePrice: e.candleAccTradePrice,
        candleAccTradeVolume: e.candleAccTradeVolume,
        unit: e.unit,
      );
    }).toList();
  }
}
