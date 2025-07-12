import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_response_entity.freezed.dart';

@freezed
abstract class OrderResponseEntity with _$OrderResponseEntity {
  factory OrderResponseEntity({
    required int price,
  }) = _OrderEntity;
} 