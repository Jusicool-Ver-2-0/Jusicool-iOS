import 'package:jusicool_ios/domain/market/entities/market_entity.dart';
import 'package:jusicool_ios/domain/market/repositories/market_repository.dart';
import 'package:jusicool_ios/domain/market/usecase/market_usecase.dart';

class MarketUsecaseImpl extends MarketUsecase {
  final MarketRepository _repository;
  MarketUsecaseImpl(this._repository);

  @override
  Future<List<MarketEntity>> fetchMarkets(String type) async {
    return await _repository.fetchMarkets(type);
  }

  @override
  Future<List<MarketEntity>> searchMarkets(String query) async {
    return await _repository.searchMarkets(query);
  }
  
  @override
  Future<void> prediction(String marketCode) async {
    return await _repository.prediction(marketCode);
  }
} 