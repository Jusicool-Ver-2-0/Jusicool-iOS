import 'package:jusicool_ios/domain/holding/entities/my_holding_entity.dart';

abstract class HoldingRepository {
  Future<MyHoldingEntity> fetchMyholding();
}