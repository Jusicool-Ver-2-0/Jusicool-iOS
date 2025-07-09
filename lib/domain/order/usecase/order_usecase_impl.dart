import 'package:jusicool_ios/domain/enum/share/order/reserve_type.dart';
import 'package:jusicool_ios/domain/order/entities/month_order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/month_rate_entity.dart';
import 'package:jusicool_ios/domain/order/entities/my_order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/reservation_order_entity.dart';
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
  Future<MyOrderEntity> fetchMyorders(List<ReserveType> type) async {
    return await _repository.fetchMyorders(type);
  }

  @override
  Future<ReservationOrderEntity> fetchReservationOrder() async {
    return await _repository.fetchReservationOrder();
  }

  @override
  Future<int> order(double quantity) async {
    return await _repository.order(quantity);
  }
}