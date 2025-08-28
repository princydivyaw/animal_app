import 'package:equatable/equatable.dart';

class DbGetCommentEntity extends Equatable {
  final String status;
  final int statusCode;
  final String message;
  final List<DbGetCommentDataEntity> data;

  const DbGetCommentEntity({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
        status,
        statusCode,
        message,
        data,
      ];
}

class DbGetCommentDataEntity extends Equatable {
  final CommentDetailsEntity commentDetails;

  const DbGetCommentDataEntity({
    required this.commentDetails,
  });

  @override
  List<Object?> get props => [
        commentDetails,
      ];
}

class CommentDetailsEntity extends Equatable {
  final String cName;
  final String cImageUrl;
  final String cComments;
  final String cKey;
  final String cPostStatus;

  const CommentDetailsEntity({
    required this.cName,
    required this.cImageUrl,
    required this.cComments,
    required this.cKey,
    required this.cPostStatus,
  });

  @override
  List<Object?> get props => [
        cName,
        cImageUrl,
        cComments,
        cKey,
        cPostStatus,
      ];
}
