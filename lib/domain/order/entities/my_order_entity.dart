import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jusicool_ios/domain/enum/share/order/my_order_status_type.dart';
import 'package:jusicool_ios/domain/enum/share/order/order_type.dart';
import 'package:jusicool_ios/domain/enum/share/order/reserve_type.dart';

part 'my_order_entity.freezed.dart';

@freezed
abstract class MyOrderEntity with _$MyOrderEntity {
  factory MyOrderEntity({
    required int id,
    required String market,
    required OrderType orderType,
    required ReserveType reserveType,
    required int quantity,
    int? executePrice,
    int? reservePrice,
    required MyOrderStatusType status,
  }) = _MyOrderEntity;
}