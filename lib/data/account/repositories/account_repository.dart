import '../dto/remote/response/my_account_response_dto.dart';

abstract class AccountRepository {
  Future<MyAccountResponseDto> getMyAccount();
}
