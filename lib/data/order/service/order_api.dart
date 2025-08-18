import 'package:dio/dio.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/order_request_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/request/reserve_order_request_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/month_order_response_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/month_rate_response_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/my_order_response_dto.dart';
import 'package:jusicool_ios/data/order/dto/remote/response/order_response_dto.dart';
import 'package:retrofit/http.dart';

part 'order_api.g.dart';

@RestApi()
abstract class OrderApi {

  factory OrderApi(Dio dio,{String baseUrl}) = _OrderApi;

  @GET('/order/my')
  Future<List<MyOrderResponseDto>> fetchMyOrder(
    @Query('type') String type
  );

  @GET('/order/month')
  Future<MonthOrderResponseDto> fetchMonthOrder();

  @GET('/order/month/rate')
  Future<MonthRateResponseDto> fetchMonthRate();

  @POST('order/buy/{marketCode}')
  Future<OrderResponseDto> buyOrder(
    @Path('marketCode') String marketCode,
    @Body() OrderRequestDto body,
  );

  @POST('order/sell/{marketCode}')
  Future<OrderResponseDto> sellOrder(
    @Path('marketCode') String marketCode,
    @Body() OrderRequestDto body,
  );

  @POST('order/buy/reserve/{marketCode}')
  Future<void> reserveBuyOrder(
    @Path('marketCode') String marketCode,
    @Body() ReserveOrderRequestDto body,
  );

  @POST('order/sell/reserve/{marketCode}')
  Future<void> reserveSellOrder(
    @Path('marketCode') String marketCode,
    @Body() ReserveOrderRequestDto body,
  );
}