import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/remote/response/sign_up_search_school_response_dto.dart';

part 'neis_api.g.dart';

@RestApi()
abstract class NeisApi {
  factory NeisApi(Dio dio, {String baseUrl}) = _NeisApi;

  @GET('/')
  Future<SignUpSearchSchoolResponseDto> fetchSchools(
    @Query('SCHUL_NM') String schoolName,
  );
}
