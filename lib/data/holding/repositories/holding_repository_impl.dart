import 'package:jusicool_ios/data/holding/data_source/holding_data_source.dart';
import 'package:jusicool_ios/data/holding/mappers/remote/response/my_holding_response_mapper.dart';
import 'package:jusicool_ios/domain/holding/entities/my_holding_entity.dart';
import 'package:jusicool_ios/domain/holding/repositories/holding_repository.dart';

class HoldingRepositoryImpl extends HoldingRepository {

  final HoldingDataSource _holdingDataSource;
  HoldingRepositoryImpl(this._holdingDataSource);

  @override
  Future<MyHoldingEntity> fetchMyholding() async {
    final response = await _holdingDataSource.fetchMyHolding();
    return MyHoldingResponseMapper.toEntity(response);
  }

}