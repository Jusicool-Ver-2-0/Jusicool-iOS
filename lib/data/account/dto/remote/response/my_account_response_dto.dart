import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_account_response_dto.freezed.dart';

part 'my_account_response_dto.g.dart';

@freezed
abstract class MyAccountResponseDto with _$MyAccountResponseDto {
  const factory MyAccountResponseDto({
    required int id,
    @JsonKey(name: 'krw_balance') required int krwBalance,
    @JsonKey(name: 'usd_balance') required double usdBalance,
  }) = _MyAccountResponseDto;

  factory MyAccountResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MyAccountResponseDtoFromJson(json);
}
