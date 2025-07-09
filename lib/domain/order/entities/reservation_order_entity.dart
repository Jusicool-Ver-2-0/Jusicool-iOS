import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_order_entity.freezed.dart';

@freezed
abstract class ReservationOrderEntity with _$ReservationOrderEntity {
  factory ReservationOrderEntity({
    required int price,
  }) = _ReservationOrderEntity;
} 