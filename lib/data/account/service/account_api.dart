import 'package:dio/dio.dart';
import 'package:jusicool_ios/data/account/dto/remote/response/my_account_response_dto.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'account_api.g.dart';

@RestApi()
abstract class AccountApi {
  factory AccountApi(Dio dio, {String baseUrl}) = _AccountApi;

  @GET('/account/my')
  Future<MyAccountResponseDto> getMyAccount();
}
