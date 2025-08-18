import '../entity/candle_stick_chart_entity.dart';
import '../repositories/candle_stick_chart_repository.dart';
import 'candle_stick_chart_usecase.dart';

class CandleStickChartUseCaseImpl extends CandleStickChartUseCase {
  final CandleStickChartRepository _candleStickChartRepository;

  CandleStickChartUseCaseImpl(this._candleStickChartRepository);

  @override
  Future<List<CandleStickChartEntity>> fetchCandlestickChartData({
    required String market,
    int count = 100,
    String? to,
  }) {
    return _candleStickChartRepository.fetchCandlestickChartData(
      market: market,
      count: count,
      to: to,
    );
  }
}
