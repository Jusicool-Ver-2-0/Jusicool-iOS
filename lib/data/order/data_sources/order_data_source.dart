import 'package:jusicool_ios/data/order/dto/remote/request/my_order_request_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/order_request_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/reserve_order_request_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/month_order_response_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/month_rate_response_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/my_order_response_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/order_response_dto.dart';

abstract class OrderDataSource {
  Future<MyOrderResponseDto> fetchMyOrder(MyOrderRequestDto body);

  Future<MonthOrderResponseDto> fetchMonthOrder();

  Future<MonthRateResponseDto> fetchMonthRate();

  Future<OrderResponseDto> buyOrder(OrderRequestDto body, String marketCode);

  Future<OrderResponseDto> sellOrder(OrderRequestDto body, String marketCode);

  Future<void> reserveBuyOrder(ReserveOrderRequestDto body, String marketCode);

  Future<void> reserveSellOrder(ReserveOrderRequestDto body, String marketCode);
}