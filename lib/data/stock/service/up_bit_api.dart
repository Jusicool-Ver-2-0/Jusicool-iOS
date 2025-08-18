import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/remote/response/stock_candles_minutes_response_dto.dart';

part 'up_bit_api.g.dart';

@RestApi()
abstract class UpBitApi {
  factory UpBitApi(Dio dio, {String baseUrl}) = _UpBitApi;

  @GET('/candles/minutes/1')
  Future<List<StockCandlesMinutesResponseDto>> getMinuteCandles({
    @Query('market') required String market,
    @Query('count') int count = 100,
    @Query('to') String? to,
  });
}
