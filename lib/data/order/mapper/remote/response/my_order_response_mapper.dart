import 'package:jusicool_ios/data/order/dto/remote/response/my_order_response_dto.dart';
import 'package:jusicool_ios/domain/order/entities/my_order_entity.dart';

class MyOrderResponseMapper {
  static MyOrderResponseDto toDto(MyOrderEntity entity) =>
      MyOrderResponseDto(
        id: entity.id, 
        market: entity.market, 
        orderType: entity.orderType, 
        reserveType: entity.reserveType, 
        quantity: entity.quantity, 
        status: entity.status,
      );
  
  static MyOrderEntity toEntity(MyOrderResponseDto dto) =>
      MyOrderEntity(
        id: dto.id, 
        market: dto.market, 
        orderType: dto.orderType, 
        reserveType: dto.reserveType,
         quantity: dto.quantity, 
         status: dto.status,
      );
}