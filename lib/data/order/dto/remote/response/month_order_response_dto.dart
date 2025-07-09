import 'package:freezed_annotation/freezed_annotation.dart';

part 'month_order_response_dto.g.dart';
part 'month_order_response_dto.freezed.dart';

@freezed
abstract class MonthOrderResponseDto with _$MonthOrderResponseDto {
  factory MonthOrderResponseDto({
    required double rate,
    @JsonKey(name: 'order_count') required int orderCount
  }) = _MonthOrderResponseDto;

  factory MonthOrderResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MonthOrderResponseDtoFromJson(json);
}