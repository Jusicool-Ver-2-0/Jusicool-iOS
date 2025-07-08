import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_search_school_request_dto.dart';

class SignUpSearchSchoolRequestMapper {
  static SignUpSearchSchoolRequestDto toDto(String entity) {
    return SignUpSearchSchoolRequestDto(schoolName: entity);
  }
}
