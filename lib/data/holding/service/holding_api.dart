import 'package:dio/dio.dart';
import 'package:jusicool_ios/data/holding/dto/remote/response/my_holding_response_dto.dart';
import 'package:retrofit/http.dart';

part 'holding_api.g.dart';

@RestApi()
abstract class HoldingApi {

  factory HoldingApi(Dio dio,{String baseUrl}) = _HoldingApi;

  @GET('/holding/my')
  Future<MyHoldingResponseDto> fetchMyHolding();

}