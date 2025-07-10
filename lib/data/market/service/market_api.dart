import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:jusicool_ios/data/market/dto/remote/response/market_response_dto.dart';
import 'package:jusicool_ios/data/market/dto/remote/request/market_request_dto.dart';
import 'package:jusicool_ios/data/market/dto/remote/request/market_search_request_dto.dart';

part 'market_api.g.dart';

@RestApi()
abstract class MarketApi {
  factory MarketApi(Dio dio, {String baseUrl}) = _MarketApi;

  @GET('/market/list')
  Future<List<MarketResponseDto>> fetchMarkets(@Body() MarketRequestDto request);

  @GET('/market/search')
  Future<List<MarketResponseDto>> searchMarkets(@Query('query') String query);
} 