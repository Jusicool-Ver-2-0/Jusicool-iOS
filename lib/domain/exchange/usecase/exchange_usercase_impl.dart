import 'package:jusicool_ios/domain/exchange/entities/exchange_entity.dart';
import 'package:jusicool_ios/domain/exchange/repositories/exchange_repository.dart';
import 'package:jusicool_ios/domain/exchange/usecase/exchange_usecase.dart';

class ExchangeUsercaseImpl extends ExchangeUsecase {

  final ExchangeRepository _repository;

  ExchangeUsercaseImpl(this._repository);

  @override
  Future<void> exchangeKRW(ExchangeEntity entity) async { 
    await _repository.exchangeKRW(entity);
  }
  
  @override
  Future<void> exchangeUSD(ExchangeEntity entity) async {
    await _repository.exchangeUSD(entity);
  }
}