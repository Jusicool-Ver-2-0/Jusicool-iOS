import 'package:jusicool_ios/data/exchange/dto/remote/request/exchange_request_dto.dart';

abstract class ExchangeDataSource {
  Future<void> exchangeKRW(ExchangeRequestDto body);

  Future<void> exchangeUSD(ExchangeRequestDto body);
}