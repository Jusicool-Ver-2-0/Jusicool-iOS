import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jusicool_ios/domain/enum/status_type.dart';

part 'my_order_query_type_request_dto.g.dart';

part 'my_order_query_type_request_dto.freezed.dart';

@freezed
abstract class MyOrderQueryTypeRequestDto with _$MyOrderQueryTypeRequestDto {
  const factory MyOrderQueryTypeRequestDto({
    required StatusType type,
  }) = _MyOrderQueryTypeRequestDto;

  factory MyOrderQueryTypeRequestDto.fromJson(Map<String,dynamic> json) =>
      _$MyOrderQueryTypeRequestDtoFromJson(json);
}