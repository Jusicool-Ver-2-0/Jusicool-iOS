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
    @JsonKey(name: 'order_type') required OrderType orderType,
    @JsonKey(name: 'reserve_type') required ReserveType reserveType,
    required int quantity,
    @JsonKey(name: 'execute_price') int? executePrice,
    @JsonKey(name: 'reserve_price') int? reservePrice,
    required MyOrderStatusType status
  }) = _MyOrderResponseDto;

  factory MyOrderResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MyOrderResponseDtoFromJson(json);
}