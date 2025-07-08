import 'package:jusicool_ios/domain/sign_in/entity/sign_in_entity.dart';
import 'package:jusicool_ios/domain/sign_in/usecase/sign_in_usecase.dart';
import '../repositories/sign_in_repository.dart';

class SignInUseCaseImpl extends SignInUseCase {
  final SignInRepository _signInRepository;

  SignInUseCaseImpl(this._signInRepository);

  @override
  Future<void> signIn(SignInEntity entity) async {
    return await _signInRepository.signIn(entity);
  }
}
