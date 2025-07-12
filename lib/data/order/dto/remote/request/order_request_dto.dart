import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_request_dto.g.dart';

part 'order_request_dto.freezed.dart';


@freezed
abstract class OrderRequestDto with _$OrderRequestDto {
  factory OrderRequestDto({
    required double quantity,
  }) = _SignInRequestDto;

  factory OrderRequestDto.fromJson(Map<String,dynamic> json) => 
      _$OrderRequestDtoFromJson(json);
}