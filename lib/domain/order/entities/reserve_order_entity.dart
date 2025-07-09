import 'package:freezed_annotation/freezed_annotation.dart';

part 'reserve_order_entity.freezed.dart';

@freezed
abstract class ReserveOrderEntity with _$ReserveOrderEntity {
  factory ReserveOrderEntity({
    required int price,
  }) = _ReserveOrderEntity;
} 