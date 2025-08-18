import 'package:jusicool_ios/data/stock/data_sources/stock_data_source.dart';
import 'package:jusicool_ios/data/stock/dto/remote/response/stock_candles_minutes_response_dto.dart';
import 'package:jusicool_ios/data/stock/service/up_bit_api.dart';

class StockDataSourceImpl implements StockDataSource {
  final UpBitApi _stockApiClient;

  StockDataSourceImpl(this._stockApiClient);

  @override
  Future<List<StockCandlesMinutesResponseDto>> fetchStockCandlesMinutes({
    required String market,
    required int count,
  }) {
    return _stockApiClient.getMinuteCandles(market: market, count: count);
  }
}
