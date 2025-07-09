import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jusicool_ios/domain/sign_up/entity/sign_up_entity.dart';
import 'package:jusicool_ios/domain/sign_up/usecase/sign_up_usecase.dart';
import 'package:jusicool_ios/presentation/sign_up/mapper/sign_up_search_school_mapper.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/config/di/dependencies.dart';
import '../state/sign_up_school_state.dart';

final signupSchoolControllerProvider =
    StateNotifierProvider<SignupSchoolController, SignUpSchoolState>(
      (ref) => SignupSchoolController(di.get<SignUpUseCase>()),
    );

class SignupSchoolController extends StateNotifier<SignUpSchoolState> {
  final SignUpUseCase _signUpUseCase;
  final _schoolNameSubject = PublishSubject<String>();

  SignupSchoolController(this._signUpUseCase)
    : super(const SignUpSchoolState()) {
    _schoolNameController.addListener(() {
      _schoolNameSubject.add(_schoolNameController.text);
    });

    _schoolNameSubject.debounceTime(const Duration(milliseconds: 500)).listen((
      _,
    ) {
      searchSchool();
    });
  }

  final TextEditingController _schoolNameController = TextEditingController();

  TextEditingController get schoolNameController => _schoolNameController;

  void searchSchool() {
    _signUpUseCase
        .searchSchool(_schoolNameController.text)
        .then((result) {
          if (result.schoolInfo.isNotEmpty) {
            state = state.copyWith(
              filteredSchools: SignUpSearchSchoolMapper.toState(result),
            );
          } else {
            state = state.copyWith(filteredSchools: []);
          }
        })
        .catchError((error) {
          state = state.copyWith(filteredSchools: []);
        });
  }

  void selectSchool(SchoolInfoState school) {
    state = state.copyWith(selectedSchool: school);
  }

  bool start({
    required String email,
    required String password,
    required String name,
  }) {
    final String? schoolName = state.selectedSchool?.schoolName;
    if (schoolName == null) {
      return false;
    } else {
      _signUpUseCase
          .signUp(
            SignUpEntity(
              email: email,
              password: password,
              name: name,
              school: schoolName,
            ),
          )
          .then((value) {
            return true;
          })
          .catchError((error) {
            return false;
          });
      return false;
    }
  }

  @override
  void dispose() {
    _schoolNameSubject.close();
    _schoolNameController.dispose();
    super.dispose();
  }
}
