import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_order_request_dto.g.dart';
part 'reservation_order_request_dto.freezed.dart';

@freezed
abstract class ReservationOrderRequestDto with _$ReservationOrderRequestDto {
  factory ReservationOrderRequestDto({
    required int quantity,
    required int price,
  }) = _ReservationOrderRequestDto;

  factory ReservationOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ReservationOrderRequestDtoFromJson(json);
}