import 'package:jusicool_ios/data/order/data_sources/order_data_source.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/my_order_request_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/order_request_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/reserve_order_request_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/month_order_response_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/month_rate_response_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/my_order_response_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/order_response_dto.dart';
import 'package:jusicool_ios/data/order/service/order_api.dart';

class OrderDataSourceImpl extends OrderDataSource {

  final OrderApi _orderApi;

  OrderDataSourceImpl(this._orderApi);

  @override
  Future<List<MyOrderResponseDto>> fetchMyOrder(MyOrderRequestDto body) async {
    return await _orderApi.fetchMyOrder(body.query.type.toString());
  }

  @override
  Future<MonthOrderResponseDto> fetchMonthOrder() async {
    return await _orderApi.fetchMonthOrder();
  }

  @override
  Future<MonthRateResponseDto> fetchMonthRate() async {
    return await _orderApi.fetchMonthRate();
  }


  @override
  Future<OrderResponseDto> buyOrder(OrderRequestDto body, String marketCode) async {
    return await _orderApi.buyOrder(marketCode, body);
  }

    @override
  Future<OrderResponseDto> sellOrder(OrderRequestDto body, String marketCode) async {
    return await _orderApi.sellOrder(marketCode, body);
  }

  @override
  Future<void> reserveBuyOrder(ReserveOrderRequestDto body, String marketCode) async {
    return await _orderApi.reserveBuyOrder(marketCode, body);
  }

  @override
  Future<void> reserveSellOrder(ReserveOrderRequestDto body, String marketCode) async {
    return await _orderApi.reserveSellOrder(marketCode, body);
  }

}