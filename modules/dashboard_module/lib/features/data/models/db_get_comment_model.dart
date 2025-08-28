import 'package:dashboard_module/features/domain/entities/db_get_comment_entity.dart';

class DbGetCommentModel extends DbGetCommentEntity {
  const DbGetCommentModel({
    required super.status,
    required super.statusCode,
    required super.message,
    required super.data,
  });

  factory DbGetCommentModel.fromJson(Map<String, dynamic> json) =>
      DbGetCommentModel(
        status: json["status"] ?? "",
        statusCode: json["status_code"] ?? "",
        message: json["message"] ?? "",
        data: json["data"] == []
            ? []
            : List<DbGetCommentDataModel>.from(
                json["data"].map((x) => DbGetCommentDataModel.fromJson(x))),
      );
}

class DbGetCommentDataModel extends DbGetCommentDataEntity {
  const DbGetCommentDataModel({
    required super.commentDetails,
  });

  factory DbGetCommentDataModel.fromJson(Map<String, dynamic> json) =>
      DbGetCommentDataModel(
        commentDetails: CommentDetails.fromJson(json["comment_details"] ?? {}),
      );
}

class CommentDetails extends CommentDetailsEntity {
  const CommentDetails({
    required super.cName,
    required super.cImageUrl,
    required super.cComments,
    required super.cKey,
    required super.cPostStatus,
  });

  factory CommentDetails.fromJson(Map<String, dynamic> json) => CommentDetails(
        cName: json["c_name"] ?? "",
        cImageUrl: json["c_image_url"] ?? "",
        cComments: json["c_comments"] ?? "",
        cKey: json["c_key"] ?? "",
        cPostStatus: json["c_post_status"] ?? "",
      );
}
