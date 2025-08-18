import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_response_dto.g.dart';

part 'order_response_dto.freezed.dart';

@freezed
abstract class OrderResponseDto with _$OrderResponseDto {
  factory OrderResponseDto({
    required int price,
  }) = _OrderResponseDto;

  factory OrderResponseDto.fromJson(Map<String,dynamic> json) =>
      _$OrderResponseDtoFromJson(json);
}