import '../../../domain/sign_up/entity/sign_up_search_school_entity.dart';
import '../state/sign_up_school_state.dart';

class SignUpSearchSchoolMapper {
  static List<SchoolInfoState> toState(
    SignUpSearchSchoolResponseEntity entity,
  ) {
    return entity.schoolInfo
        .expand((info) => info.row ?? [])
        .map(
          (row) => SchoolInfoState(
            schoolName: row.schoolName,
            schoolAddress: row.schoolAddress,
          ),
        )
        .toList();
  }
}
