import 'package:freezed_annotation/freezed_annotation.dart';

part 'month_order_entity.freezed.dart';

@freezed
abstract class MonthOrderEntity with _$MonthOrderEntity {
  factory MonthOrderEntity({
    required double rate,
    required int orderCount,
  }) = _MonthOrderEntity;
} 