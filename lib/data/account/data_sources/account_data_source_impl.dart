import 'package:jusicool_ios/data/account/api/account_api.dart';
import 'package:jusicool_ios/data/account/data_sources/account_data_source.dart';
import 'package:jusicool_ios/data/account/dto/remote/response/my_account_response_dto.dart';

class AccountDataSourceImpl extends AccountDataSource {
  final AccountApi _accountApi;

  AccountDataSourceImpl(this._accountApi);

  @override
  Future<MyAccountResponseDto> getMyAccount() async {
    return await _accountApi.getMyAccount();
  }
}
