import 'package:jusicool_ios/domain/enum/share/order/reserve_type.dart';
import 'package:jusicool_ios/domain/enum/share/order/status_type.dart';
import 'package:jusicool_ios/domain/order/entities/month_order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/month_rate_entity.dart';
import 'package:jusicool_ios/domain/order/entities/my_order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/reserve_order_entity.dart';
import 'package:jusicool_ios/domain/order/repositories/order_repository.dart';
import 'package:jusicool_ios/domain/order/usecase/order_usecase.dart';

class OrderUsecaseImpl extends OrderUsecase {

  final OrderRepository _repository;

  OrderUsecaseImpl(this._repository);

  @override
  Future<MonthOrderEntity> fetchMonthOrder() async {
    return await _repository.fetchMonthOrder();
  }

  @override
  Future<MonthRateEntity> fetchMonthRate() async {
    return await _repository.fetchMonthRate();
  }

  @override
  Future<MyOrderEntity> fetchMyorders(StatusType type) async {
    return await _repository.fetchMyorders(type);
  }

  @override
  Future<ReserveOrderEntity> fetchReservationOrder() async {
    return await _repository.fetchReservationOrder();
  }

  @override
  Future<OrderEntity> order(double quantity, String marketCode) async {
    return await _repository.order(quantity,marketCode);
  }
}