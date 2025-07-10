import 'package:jusicool_ios/domain/holding/entities/my_holding_entity.dart';
import 'package:jusicool_ios/domain/holding/repositories/holding_repository.dart';
import 'package:jusicool_ios/domain/holding/usecase/holding_usecase.dart';

class HoldingUsecaseImpl extends HoldingUsecase {

  final HoldingRepository _repository;

  HoldingUsecaseImpl(this._repository);

  @override
  Future<MyHoldingEntity> fetchMyholding() async {
    return await _repository.fetchMyholding();
  }

}