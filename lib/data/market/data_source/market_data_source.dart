import 'package:jusicool_ios/data/market/dto/remote/response/market_response_dto.dart';
import 'package:jusicool_ios/data/market/dto/remote/request/market_request_dto.dart';

abstract class MarketDataSource {
  Future<List<MarketResponseDto>> fetchMarkets(MarketRequestDto request);
  Future<List<MarketResponseDto>> searchMarkets(String query);
} 