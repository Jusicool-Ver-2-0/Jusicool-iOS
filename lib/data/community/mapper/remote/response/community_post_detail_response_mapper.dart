import 'package:jusicool_ios/data/community/dto/remote/response/community_post_detail_response_dto.dart';
import 'package:jusicool_ios/domain/community/enitites/community_post_detail_entity.dart';
import 'package:jusicool_ios/data/community/mapper/remote/response/comment_response_mapper.dart';

class CommunityPostDetailResponseMapper {
  static CommunityPostDetailResponseDto toDto(CommunityPostDetailEntity entity) =>
      CommunityPostDetailResponseDto(
        id: entity.id,
        email: entity.email,
        market: entity.market,
        title: entity.title,
        content: entity.content,
        comment: entity.comment.map((e) => CommentResponseMapper.toDto(e)).toList(),
        likeCount: entity.likeCount,
      );

  static CommunityPostDetailEntity toEntity(CommunityPostDetailResponseDto dto) =>
      CommunityPostDetailEntity(
        id: dto.id,
        email: dto.email,
        market: dto.market,
        title: dto.title,
        content: dto.content,
        comment: dto.comment.map((e) => CommentResponseMapper.toEntity(e)).toList(),
        likeCount: dto.likeCount,
      );
}