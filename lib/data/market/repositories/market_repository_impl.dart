import 'package:jusicool_ios/domain/market/entities/market_entity.dart';
import 'package:jusicool_ios/domain/market/repositories/market_repository.dart';
import 'package:jusicool_ios/data/market/data_source/market_data_source.dart';
import 'package:jusicool_ios/data/market/dto/remote/request/market_request_dto.dart';
import 'package:jusicool_ios/data/market/mapper/remote/response/market_response_mapper.dart';

class MarketRepositoryImpl extends MarketRepository {
  final MarketDataSource _dataSource;
  MarketRepositoryImpl(this._dataSource);

  @override
  Future<List<MarketEntity>> fetchMarkets(String type) async {
    final request = MarketRequestDto(type: type);
    final response = await _dataSource.fetchMarkets(request);
    return response.map((e) => MarketResponseMapper.toEntity(e)).toList();
  }

  @override
  Future<List<MarketEntity>> searchMarkets(String query) async {
    final response = await _dataSource.searchMarkets(query);
    return response.map((e) => MarketResponseMapper.toEntity(e)).toList();
  }
} 