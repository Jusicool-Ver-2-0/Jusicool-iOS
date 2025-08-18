import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_request_entity.freezed.dart';

@freezed
abstract class OrderRequestEntity with _$OrderRequestEntity {
  factory OrderRequestEntity({
    required double quantity,
  }) = _OrderEntity;
} 