import 'package:dio/dio.dart';
import 'package:jusicool_ios/data/community/dto/remote/request/edit_community_post_request_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/request/write_community_comment_request_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/request/write_community_post_request_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/response/community_post_detail_response_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/response/community_post_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'community_api.g.dart';

@RestApi()
abstract class CommunityApi {

  factory CommunityApi(Dio dio,{String baseUrl}) = _CommunityApi;

  @GET('/community/{market}')
  Future<List<CommunityPostResponseDto>> fetchCommunity(
    @Path('market') String market
  );

  @POST('/community/{market}')
  Future<void> writeCommunityPost(
    @Path('market') String market,
    @Body() WriteCommunityPostRequestDto body
  );

  @GET('/community/{market}/{board_id}')
  Future<CommunityPostDetailResponseDto> getCommunityPost(
    @Path('market') String market,
    @Path('board_id') int boardId,
  );

  @POST('/community/{market}/{board_id}')
  Future<void> writeComment(
    @Path('market') String market,
    @Path('board_id') int boardId,
    @Body() WriteCommunityCommentRequestDto body,
  );

  @PUT('/community/{market}/{board_id}')
  Future<void> editPost(
    @Path('market') String market,
    @Path('board_id') int boardId,
    @Body() EditCommunityPostRequestDto body
  );

  @PATCH('/community/{market}/{board_id}')
  Future<void> likePost(
    @Path('market') String market,
    @Path('board_id') int boardId,
  );

  @DELETE('/community/{market}/{board_id}')
  Future<void> deletePost(
    @Path('market') String market,
    @Path('board_id') int boardId,
  );
  
}