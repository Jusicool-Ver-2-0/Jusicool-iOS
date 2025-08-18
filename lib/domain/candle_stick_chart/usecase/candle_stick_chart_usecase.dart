import '../entity/candle_stick_chart_entity.dart';

abstract class CandleStickChartUseCase {
  Future<List<CandleStickChartEntity>> fetchCandlestickChartData({
    required String market,
    int count = 100,
    String? to,
  });
}
