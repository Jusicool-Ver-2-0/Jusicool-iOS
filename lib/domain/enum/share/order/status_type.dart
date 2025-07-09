import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_type.freezed.dart';
part 'status_type.g.dart'; 

@freezed
abstract class StatusType with _$StatusType {
  const factory StatusType.reserve() = _Reserve;
  const factory StatusType.completed() = _Completed;

  factory StatusType.fromJson(Map<String, dynamic> json) => 
      _$StatusTypeFromJson(json);
}
