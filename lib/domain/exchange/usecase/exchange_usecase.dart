import 'package:jusicool_ios/domain/exchange/entity/exchange_entity.dart';

abstract class ExchangeUsecase {
  Future<void> exchangeKRW(ExchangeEntity exchange);
  
  Future<void> exchangeUSD(ExchangeEntity exchange);
}