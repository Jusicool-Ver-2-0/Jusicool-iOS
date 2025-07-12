import 'package:jusicool_ios/data/order/dto/remote/response/month_order_response_dto.dart';
import 'package:jusicool_ios/domain/order/entities/month_order_entity.dart';

class MonthOrderResponseMapper {
  static MonthOrderResponseDto toDto(MonthOrderEntity entity) =>
      MonthOrderResponseDto(rate: entity.rate, orderCount: entity.orderCount);
  static MonthOrderEntity toEntity(MonthOrderResponseDto dto) =>
      MonthOrderEntity(rate: dto.rate, orderCount: dto.orderCount);
}