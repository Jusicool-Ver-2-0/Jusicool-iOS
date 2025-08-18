import 'package:jusicool_ios/data/stock/data_sources/stock_data_source.dart';
import 'package:jusicool_ios/data/stock/dto/remote/response/stock_candles_minutes_response_dto.dart';
import '../../../domain/candle_stick_chart/entity/candle_stick_chart_entity.dart';
import '../../../domain/candle_stick_chart/repositories/candle_stick_chart_repository.dart';
import '../mapper/remote/response/stock_candles_minutes_response_mapper.dart';

class StockRepositoryImpl implements CandleStickChartRepository {
  final StockDataSource _stockDataSource;

  StockRepositoryImpl(this._stockDataSource);

  @override
  Future<List<CandleStickChartEntity>> fetchCandlestickChartData({
    required String market,
    int count = 100,
    String? to,
  }) async {
    final List<StockCandlesMinutesResponseDto> response = await _stockDataSource
        .fetchStockCandlesMinutes(market: market, count: count);
    return StockCandlesMinutesResponseMapper.toEntity(response);
  }
}
