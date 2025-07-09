import 'package:jusicool_ios/domain/enum/share/order/reserve_type.dart';
import 'package:jusicool_ios/domain/order/entities/month_order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/month_rate_entity.dart';
import 'package:jusicool_ios/domain/order/entities/my_order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/reserve_order_entity.dart';

abstract class OrderRepository {
  Future<MyOrderEntity> fetchMyorders(List<ReserveType> type);

  Future<MonthOrderEntity> fetchMonthOrder();

  Future<MonthRateEntity> fetchMonthRate();

  Future<OrderEntity> order(double quantity, String merketCode);

  Future<ReserveOrderEntity> fetchReservationOrder();
}