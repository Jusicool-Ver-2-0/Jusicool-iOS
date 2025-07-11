import 'package:jusicool_ios/data/community/dto/remote/response/community_post_detail_response_dto.dart';
import 'package:jusicool_ios/domain/community/enitites/community_post_detail_entity.dart';

class CommentResponseMapper {
  static CommentDto toDto(CommentEntity entity) =>
      CommentDto(id: entity.id, email: entity.email, comment: entity.comment);
  static CommentEntity toEntity(CommentDto dto) =>
      CommentEntity(id: dto.id, email: dto.email, comment: dto.comment);
}