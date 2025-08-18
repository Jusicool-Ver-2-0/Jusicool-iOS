import 'package:jusicool_ios/data/community/dto/remote/response/community_post_response_dto.dart';
import 'package:jusicool_ios/domain/community/enitites/community_post_entity.dart';

class CommunityPostResponseMapper {
  static CommunityPostResponseDto toDto(CommunityPostEntity entity) =>
      CommunityPostResponseDto(
        id: entity.id, 
        email: entity.email, 
        market: entity.market, 
        title: entity.title, 
        content: entity.content, 
        commentCount: entity.commentCount, 
        likeCount: entity.likeCount, 
        isLiked: entity.isLiked,
      );
  static CommunityPostEntity toEntity(CommunityPostResponseDto dto) =>
      CommunityPostEntity(
        id: dto.id, 
        email: dto.email, 
        market: dto.market, 
        title: dto.title, 
        content: dto.content, 
        commentCount: dto.commentCount, 
        likeCount: dto.likeCount, 
        isLiked: dto.isLiked,
      );
}