import 'package:freezed_annotation/freezed_annotation.dart';

part 'reserve_type.g.dart';
part 'reserve_type.freezed.dart';

@freezed
abstract class ReserveType with _$ReserveType {
  const factory ReserveType.immediate() = _Immediate;
  const factory ReserveType.reserve() = _Reserve;

  factory ReserveType.fromJson(Map<String, dynamic> json) =>
      _$ReserveTypeFromJson(json);
}