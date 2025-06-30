import 'package:jusicool_ios/data/account/data_sources/account_data_source.dart';
import 'package:jusicool_ios/data/account/dto/remote/response/my_account_response_dto.dart';
import 'package:jusicool_ios/data/account/repositories/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final AccountDataSource _accountDataSource;

  AccountRepositoryImpl(this._accountDataSource);

  @override
  Future<MyAccountResponseDto> getMyAccount() async {
    return await _accountDataSource.getMyAccount();
  }
}
