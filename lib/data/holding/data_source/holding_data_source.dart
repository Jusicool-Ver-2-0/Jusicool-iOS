import 'package:jusicool_ios/data/holding/dto/remote/response/my_holding_response_dto.dart';

abstract class HoldingDataSource {
  Future<MyHoldingResponseDto> fetchMyHolding();
}