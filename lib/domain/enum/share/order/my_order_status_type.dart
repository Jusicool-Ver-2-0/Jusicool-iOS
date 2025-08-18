
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_order_status_type.g.dart';
part 'my_order_status_type.freezed.dart';

@freezed
abstract class MyOrderStatusType with _$MyOrderStatusType {
  const factory MyOrderStatusType.completed() = _Completed;
  const factory MyOrderStatusType.pending() = _Pending;
  const factory MyOrderStatusType.canceled() = _canceled;

  factory MyOrderStatusType.fromJson(Map<String, dynamic> json) =>
      _$MyOrderStatusTypeFromJson(json);
}