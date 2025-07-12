import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jusicool_ios/domain/community/enitites/community_post_entity.dart';

part 'community_post_list_state.freezed.dart';

@freezed
abstract class CommunityPostListState with _$CommunityPostListState {
  factory CommunityPostListState({
    @Default([]) List<CommunityPostEntity> posts,
    @Default('') String selectedMarket,
    @Default(false) bool isLoading,
    @Default('') String errorMessage, 
  }) = _CommunityPostListState;
}