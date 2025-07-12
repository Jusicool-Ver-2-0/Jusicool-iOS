import 'package:jusicool_ios/data/exchange/dto/remote/request/exchange_request_dto.dart';
import 'package:jusicool_ios/domain/exchange/entities/exchange_entity.dart';

class ExchangeRequestMapper {
  static ExchangeRequestDto toDto(ExchangeEntity entity) => 
      ExchangeRequestDto(amount: entity.amount);
  static ExchangeEntity toEntity(ExchangeRequestDto dto) =>
      ExchangeEntity(amount: dto.amount);
}