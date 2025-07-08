import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_request_dto.dart';
import 'package:jusicool_ios/domain/sign_up/entity/sign_up_entity.dart';

class SignUpRequestMapper {
  static SignUpRequestDto toDto(SignUpEntity entity) => SignUpRequestDto(
    email: entity.email,
    password: entity.password,
    username: entity.name,
    school: entity.school,
  );

  static SignUpEntity toEntity(SignUpRequestDto dto) => SignUpEntity(
    email: dto.email,
    password: dto.password,
    name: dto.username,
    school: dto.school,
  );
}
