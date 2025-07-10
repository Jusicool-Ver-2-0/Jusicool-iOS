import 'package:jusicool_ios/domain/holding/entities/my_holding_entity.dart';

abstract class HoldingUsecase {
  Future<MyHoldingEntity> fetchMyholding();
}