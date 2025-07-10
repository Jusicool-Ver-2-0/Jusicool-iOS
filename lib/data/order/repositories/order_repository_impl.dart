import 'package:jusicool_ios/data/order/data_sources/order_data_source.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/order_request_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/reserve_order_request_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/order_response_dto.dart';
import 'package:jusicool_ios/data/order/mapper/remote/request/order_request_mapper.dart';
import 'package:jusicool_ios/data/order/mapper/remote/request/reserve_order_mapper.dart';
import 'package:jusicool_ios/data/order/mapper/remote/response/month_order_response_mapper.dart';
import 'package:jusicool_ios/data/order/mapper/remote/response/month_rate_response_mapper.dart';
import 'package:jusicool_ios/data/order/mapper/remote/response/my_order_response_mapper.dart';
import 'package:jusicool_ios/domain/enum/share/order/status_type.dart';
import 'package:jusicool_ios/domain/order/entities/month_order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/month_rate_entity.dart';
import 'package:jusicool_ios/domain/order/entities/my_order_entity.dart';
import 'package:jusicool_ios/domain/order/entities/order_request_entity.dart';
import 'package:jusicool_ios/domain/order/entities/order_response_entity.dart';
import 'package:jusicool_ios/domain/order/entities/reserve_order_entity.dart';
import 'package:jusicool_ios/domain/order/repositories/order_repository.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/my_order_query_type_request_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/my_order_request_dto.dart';
import 'package:jusicool_ios/data/order/mapper/remote/response/order_response_mapper.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderDataSource _orderDataSource;

  OrderRepositoryImpl(this._orderDataSource);

  @override
  Future<List<MyOrderEntity>> fetchMyorders(StatusType type) async {
    final requestDto = MyOrderRequestDto(
      query: MyOrderQueryTypeRequestDto(type: type),
    );
    final response = await _orderDataSource.fetchMyOrder(requestDto);
    return response.map((e) => MyOrderResponseMapper.toEntity(e)).toList();
  }

  @override
  Future<MonthOrderEntity> fetchMonthOrder() async {
    final response = await _orderDataSource.fetchMonthOrder();
    return MonthOrderResponseMapper.toEntity(response);
  }

  @override
  Future<MonthRateEntity> fetchMonthRate() async {
    final response = await _orderDataSource.fetchMonthRate();
    return MonthRateResponseMapper.toEntity(response);
  }

  @override
  Future<OrderResponseEntity> buyOrder(OrderRequestEntity body, String marketCode) async {
    final requestDto = OrderRequestMapper.toDto(body);
    final response = await _orderDataSource.buyOrder(requestDto, marketCode);
    return OrderResponseMapper.toEntity(response);
  }

    @override
  Future<OrderResponseEntity> sellOrder(OrderRequestEntity body, String marketCode) async {
    final OrderRequestDto requestDto = OrderRequestMapper.toDto(body);
    final OrderResponseDto response = await _orderDataSource.buyOrder(requestDto, marketCode);
    return OrderResponseMapper.toEntity(response);
  }
  
  @override
  Future<void> reserveBuyOrder(ReserveOrderEntity body, String marketCode) async {
    final ReserveOrderRequestDto request = ReserveOrderMapper.toDto(body);
    return await _orderDataSource.reserveBuyOrder(request, marketCode);
  }
  
  @override
  Future<void> reserveSellOrder(ReserveOrderEntity body, String marketCode) async {
    final ReserveOrderRequestDto request = ReserveOrderMapper.toDto(body);
    return await _orderDataSource.reserveBuyOrder(request, marketCode);
  }
  
}