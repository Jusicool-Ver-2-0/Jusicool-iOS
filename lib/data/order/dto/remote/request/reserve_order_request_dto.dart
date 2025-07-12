import 'package:freezed_annotation/freezed_annotation.dart';

part 'reserve_order_request_dto.g.dart';
part 'reserve_order_request_dto.freezed.dart';

@freezed
abstract class ReserveOrderRequestDto with _$ReserveOrderRequestDto {
  factory ReserveOrderRequestDto({
    required int quantity,
    required int price,
  }) = _ReserveOrderRequestDto;

  factory ReserveOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ReserveOrderRequestDtoFromJson(json);
}