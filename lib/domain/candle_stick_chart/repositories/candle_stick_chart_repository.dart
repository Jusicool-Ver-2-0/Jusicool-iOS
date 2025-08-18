import '../entity/candle_stick_chart_entity.dart';

abstract class CandleStickChartRepository {
  Future<List<CandleStickChartEntity>> fetchCandlestickChartData({
    required String market,
    int count = 100,
    String? to,
  });
}
