import 'package:jusicool_ios/data/user/dto/remote/response/sign_up_search_school_response_dto.dart';
import 'package:jusicool_ios/domain/sign_up/entity/sign_up_search_school_entity.dart';

class SignUpSearchSchoolResponseMapper {
  static SignUpSearchSchoolResponseEntity toEntity(
    SignUpSearchSchoolResponseDto dto,
  ) {
    return SignUpSearchSchoolResponseEntity(
      schoolInfo:
          dto.schoolInfo.map((infoDto) {
            return SchoolInfoEntity(
              head: infoDto.head,
              row:
                  infoDto.row?.map((rowDto) {
                    return SchoolRowEntity(
                      schoolName: rowDto.schoolName,
                      schoolAddress: rowDto.schoolAddress,
                    );
                  }).toList(),
            );
          }).toList(),
    );
  }
}
