import 'package:dio/dio.dart';
import 'package:jusicool_ios/data/exchange/dto/remote/request/exchange_request_dto.dart';
import 'package:retrofit/http.dart';

part 'exchange_api.g.dart';

@RestApi()
abstract class ExchangeApi {

  factory ExchangeApi(Dio dio, {String baseUrl}) = _ExchangeApi;

  @POST('/exchange/KRW')
  Future<void> exchangeKRW(@Body() ExchangeRequestDto body);

  @POST('/exchange/USD')
  Future<void> exchangeUSD(@Body() ExchangeRequestDto body);
}