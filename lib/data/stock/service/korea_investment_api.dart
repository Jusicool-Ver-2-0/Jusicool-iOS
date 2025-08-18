import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'korea_investment_api.g.dart';

@RestApi()
abstract class KoreaInvestmentApi {
  factory KoreaInvestmentApi(Dio dio, {String baseUrl}) = _KoreaInvestmentApi;
}
