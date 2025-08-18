import 'package:jusicool_ios/data/order/dto/remote/request/order_request_dto.dart';
import 'package:jusicool_ios/domain/order/entities/order_request_entity.dart';

class OrderRequestMapper {
  static OrderRequestDto toDto(OrderRequestEntity entity) =>
      OrderRequestDto(quantity: entity.quantity);
  static OrderRequestEntity toEntity(OrderRequestDto dto) =>
      OrderRequestEntity(quantity: dto.quantity);
}