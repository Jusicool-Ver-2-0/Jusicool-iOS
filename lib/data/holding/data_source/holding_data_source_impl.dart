import 'package:jusicool_ios/data/holding/data_source/holding_data_source.dart';
import 'package:jusicool_ios/data/holding/dto/remote/response/my_holding_response_dto.dart';
import 'package:jusicool_ios/data/holding/service/holding_api.dart';

class HoldingDataSourceImpl extends HoldingDataSource {

  final HoldingApi _holdingApi;

  HoldingDataSourceImpl(this._holdingApi);

  @override
  Future<MyHoldingResponseDto> fetchMyHolding() async {
    return await _holdingApi.fetchMyHolding();
  }
}