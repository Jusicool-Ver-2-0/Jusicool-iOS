import 'package:jusicool_ios/domain/market/entities/market_entity.dart';

abstract class MarketRepository {
  Future<List<MarketEntity>> fetchMarkets(String type);
  Future<List<MarketEntity>> searchMarkets(String query);
} 