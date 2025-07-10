import 'package:jusicool_ios/data/order/dto/remote/response/order_response_dto.dart';
import 'package:jusicool_ios/domain/order/entities/order_response_entity.dart';

class OrderResponseMapper {
  static OrderResponseDto toDto(OrderResponseEntity entity) =>
      OrderResponseDto(price: entity.price);
  static OrderResponseEntity toEntity(OrderResponseDto dto) =>
      OrderResponseEntity(price: dto.price);
}