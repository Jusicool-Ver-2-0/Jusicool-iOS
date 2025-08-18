import 'package:jusicool_ios/domain/candle_stick_chart/entity/candle_stick_chart_entity.dart';
import 'package:jusicool_ios/presentation/candle_stick_chart/state/candle_stick_chart_widget_state.dart';

class CandleStickChartMapper {
  static List<StockCandleStickChartWidgetData> toData(
    List<CandleStickChartEntity> entity,
  ) {
    return entity
        .map(
          (e) => StockCandleStickChartWidgetData(
            candleDateTimeUtc: e.candleDateTimeUtc,
            candleDateTimeKst: e.candleDateTimeKst,
            openingPrice: e.openingPrice,
            highPrice: e.highPrice,
            lowPrice: e.lowPrice,
            tradePrice: e.tradePrice,
            timestamp: e.timestamp,
            candleAccTradePrice: e.candleAccTradePrice,
            candleAccTradeVolume: e.candleAccTradeVolume,
            unit: e.unit,
          ),
        )
        .toList();
  }
}
