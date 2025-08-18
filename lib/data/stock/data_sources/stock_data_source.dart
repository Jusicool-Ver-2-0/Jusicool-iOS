import 'package:jusicool_ios/data/stock/dto/remote/response/stock_candles_minutes_response_dto.dart';

abstract class StockDataSource {
  Future<List<StockCandlesMinutesResponseDto>> fetchStockCandlesMinutes({
    required String market,
    required int count,
  });
}
