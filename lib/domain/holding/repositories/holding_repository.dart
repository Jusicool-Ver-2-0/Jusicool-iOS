import 'package:jusicool_ios/domain/holding/entities/holding_entity.dart';

abstract class HoldingRepository {
  Future<HoldingEntity> fetchMyholding();
}