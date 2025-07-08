import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_school_state.freezed.dart';

@freezed
abstract class SignUpSchoolState with _$SignUpSchoolState {
  const factory SignUpSchoolState({
    @Default(null) SchoolInfoState? selectedSchool,
    @Default([]) List<SchoolInfoState> filteredSchools,
  }) = _SignUpSchoolState;
}

@freezed
abstract class SchoolInfoState with _$SchoolInfoState {
  const factory SchoolInfoState({
    @Default('') String schoolName,
    @Default('') String schoolAddress,
  }) = _SchoolInfoState;
}
