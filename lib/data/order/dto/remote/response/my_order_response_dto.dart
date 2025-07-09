import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jusicool_ios/domain/enum/share/order/my_order_status_type.dart';
import 'package:jusicool_ios/domain/enum/share/order/order_type.dart';
import 'package:jusicool_ios/domain/enum/share/order/reserve_type.dart';

part 'my_order_response_dto.g.dart';

part 'my_order_response_dto.freezed.dart';

@freezed
abstract class MyOrderResponseDto with _$MyOrderResponseDto {
  factory MyOrderResponseDto({
    required int id,
    required String market,
    required OrderType order_type,
    required ReserveType reserve_type,
    required int quantity,
    required int? execute_price,
    required int? reserve_price,
    required MyOrderStatusType status
  }) = _MyOrderResponseDto;

  factory MyOrderResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MyOrderResponseDtoFromJson(json);
}