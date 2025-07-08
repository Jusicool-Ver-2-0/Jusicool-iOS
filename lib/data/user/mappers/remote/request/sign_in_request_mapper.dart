import 'package:jusicool_ios/data/user/dto/remote/request/sign_in_request_dto.dart';
import 'package:jusicool_ios/domain/sign_in/entity/sign_in_entity.dart';

class SignInRequestMapper {
  static SignInRequestDto toDto(SignInEntity entity) =>
      SignInRequestDto(email: entity.email, password: entity.password);

  static SignInEntity toEntity(SignInRequestDto dto) =>
      SignInEntity(email: dto.email, password: dto.password);
}
