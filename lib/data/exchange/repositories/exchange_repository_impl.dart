import 'package:jusicool_ios/data/exchange/data_sources/exchange_data_source.dart';
import 'package:jusicool_ios/data/exchange/dto/remote/request/exchange_request_dto.dart';
import 'package:jusicool_ios/data/exchange/mappers/remote/request/exchange_request_mapper.dart';
import 'package:jusicool_ios/domain/exchange/entity/exchange_entity.dart';
import 'package:jusicool_ios/domain/exchange/repositories/exchange_repository.dart';

class ExchangeRepositoryImpl extends ExchangeRepository {
  final ExchangeDataSource _exchangeDataSource;

  ExchangeRepositoryImpl(this._exchangeDataSource);

  @override
  Future<void> exchangeKRW(ExchangeEntity body) async {
    final ExchangeRequestDto request = ExchangeRequestMapper.toDto(body);
    return await _exchangeDataSource.exchangeKRW(request);
  }

  @override
  Future<void> exchangeUSD(ExchangeEntity body) async {
    final ExchangeRequestDto request = ExchangeRequestMapper.toDto(body);
    return await _exchangeDataSource.exchangeUSD(request);
  }
  
}