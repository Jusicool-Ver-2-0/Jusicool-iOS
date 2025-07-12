import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/my_order_query_type_request_dto.dart';

part 'my_order_request_dto.g.dart';

part 'my_order_request_dto.freezed.dart';

@freezed
abstract class MyOrderRequestDto with _$MyOrderRequestDto {
  factory MyOrderRequestDto({
    required MyOrderQueryTypeRequestDto query,
  }) = _MyOrderRequestDto;

  factory MyOrderRequestDto.fromJson(Map<String,dynamic> json) =>
      _$MyOrderRequestDtoFromJson(json);
}