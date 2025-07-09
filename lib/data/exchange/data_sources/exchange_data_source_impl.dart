import 'package:jusicool_ios/data/exchange/data_sources/exchange_data_source.dart';
import 'package:jusicool_ios/data/exchange/dto/remote/request/exchange_request_dto.dart';
import 'package:jusicool_ios/data/exchange/serivice/exchange_api.dart';

class ExchangeDataSourceImpl extends ExchangeDataSource {

  final ExchangeApi _exchangeApi;

  ExchangeDataSourceImpl(this._exchangeApi);

  @override
  Future<void> exchangeKRW(ExchangeRequestDto body) async {
    return await _exchangeApi.exchangeKRW(body);
  }

  @override
  Future<void> exchangeUSD(ExchangeRequestDto body) async {
    return await _exchangeApi.exchangeUSD(body);
  }
  
}