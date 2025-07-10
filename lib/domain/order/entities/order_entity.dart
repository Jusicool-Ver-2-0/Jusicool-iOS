import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_entity.freezed.dart';

@freezed
abstract class OrderEntity with _$OrderEntity {
  factory OrderEntity({
    required int price,
    required double quantity,
  }) = _OrderEntity;
} 