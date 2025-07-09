import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_type.g.dart';
part 'order_type.freezed.dart';

@freezed
abstract class OrderType with _$OrderType {
  const factory OrderType.sell() = _Sell;
  const factory OrderType.buy() = _Buy;

  factory OrderType.fromJson(Map<String, dynamic> json) =>
      _$OrderTypeFromJson(json);
}