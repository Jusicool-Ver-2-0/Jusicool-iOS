import 'package:jusicool_ios/data/order/dto/remote/request/reserve_order_request_dto.dart';
import 'package:jusicool_ios/domain/order/entities/reserve_order_entity.dart';

class ReserveOrderMapper {
  static ReserveOrderRequestDto toDto(ReserveOrderEntity entity) =>
      ReserveOrderRequestDto(quantity: entity.quantity, price: entity.price);
  static ReserveOrderEntity toEntity(ReserveOrderRequestDto dto) =>
      ReserveOrderEntity(quantity: dto.quantity, price: dto.price);
}