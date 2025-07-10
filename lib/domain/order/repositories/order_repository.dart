import 'package:jusicool_ios/domain/enum/share/order/status_type.dart';
import 'package:jusicool_ios/domain/order/entities/month_order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/month_rate_entity.dart';
import 'package:jusicool_ios/domain/order/entities/my_order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/order_request_entity.dart';
import 'package:jusicool_ios/domain/order/entities/order_response_entity.dart';
import 'package:jusicool_ios/domain/order/entities/reserve_order_entity.dart';

abstract class OrderRepository {
  Future<MyOrderEntity> fetchMyorders(StatusType type);

  Future<MonthOrderEntity> fetchMonthOrder();

  Future<MonthRateEntity> fetchMonthRate();

  Future<OrderResponseEntity> buyOrder(OrderRequestEntity quantity, String marketCode);

  Future<OrderResponseEntity> sellOrder(OrderRequestEntity quantity, String marketCode);

  Future<ReserveOrderEntity> reserveBuyOrder();

  Future<ReserveOrderEntity> reserveSellOrder();
}