import 'package:jusicool_ios/data/market/data_source/market_data_source.dart';
import 'package:jusicool_ios/data/market/dto/remote/response/market_response_dto.dart';
import 'package:jusicool_ios/data/market/dto/remote/request/market_request_dto.dart';
import 'package:jusicool_ios/data/market/service/market_api.dart';

class MarketDataSourceImpl extends MarketDataSource {
  final MarketApi _api;
  MarketDataSourceImpl(this._api);

  @override
  Future<List<MarketResponseDto>> fetchMarkets(MarketRequestDto request) async {
    return await _api.fetchMarkets(request);
  }

  @override
  Future<List<MarketResponseDto>> searchMarkets(String query) async {
    return await _api.searchMarkets(query);
  }
} 