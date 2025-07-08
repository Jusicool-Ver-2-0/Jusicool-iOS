
import 'package:jusicool_ios/data/account/dto/remote/response/my_account_response_dto.dart';

abstract class AccountDataSource {
  Future<MyAccountResponseDto> getMyAccount();
}
