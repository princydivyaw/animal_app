import 'package:dashboard_module/features/domain/entities/db_sell_confirm_entity.dart';

class DbSellConfirmModel extends DbSellConfirmEntity {
  DbSellConfirmModel({
    required super.status,
    required super.statusCode,
    required super.message,
    required super.data,
  });

  factory DbSellConfirmModel.fromJson(Map<String, dynamic> json) =>
      DbSellConfirmModel(
        status: json["status"] ?? "",
        statusCode: json["status_code"] ?? "",
        message: json["message"] ?? "",
        data: json["data"] == []
            ? []
            : List<DbSellConfirmDataModel>.from(
                json["data"].map((x) => DbSellConfirmDataModel.fromJson(x))),
      );
}

class DbSellConfirmDataModel extends DbSellConfirmDataEntity {
  DbSellConfirmDataModel({
    required super.question,
    required super.widgetType,
    required super.label,
    required super.eventId,
    required super.optional,
    required super.fieldType,
    super.item,
  });

  factory DbSellConfirmDataModel.fromJson(Map<String, dynamic> json) =>
      DbSellConfirmDataModel(
        question: json["question"] ?? "",
        widgetType: json["widget_type"] ?? "",
        label: json["label"] ?? "",
        eventId: json["event_id"] ?? "",
        optional: json["optional"] ?? "",
        fieldType: json["field_type"] ?? "",
        item: json["item"] == null
            ? []
            : List<DbSellConfirmQuestionModel>.from(json["item"]
                .map((x) => DbSellConfirmQuestionModel.fromJson(x))),
      );
}

class DbSellConfirmQuestionModel extends DbSellConfirmQuestionEntity {
  DbSellConfirmQuestionModel({
    required super.label,
    required super.eventId,
    required super.fields,
  });

  factory DbSellConfirmQuestionModel.fromJson(Map<String, dynamic> json) =>
      DbSellConfirmQuestionModel(
        label: json["label"] ?? "",
        eventId: json["event_id"] ?? "",
        fields: json["fields"] == null
            ? []
            : List<DbSellConfirmFieldItemModel>.from(json["fields"]!
                .map((x) => DbSellConfirmFieldItemModel.fromJson(x))),
      );
}

class DbSellConfirmFieldItemModel extends DbSellConfirmFieldItemEntity {
  DbSellConfirmFieldItemModel({
    required super.label,
    required super.lblId,
    required super.optional,
    required super.fieldType,
  });

  factory DbSellConfirmFieldItemModel.fromJson(Map<String, dynamic> json) =>
      DbSellConfirmFieldItemModel(
        label: json["label"] ?? "",
        lblId: json["lbl_Id"] ?? "",
        optional: json["optional"] ?? "",
        fieldType: json["field_type"] ?? "",
      );
}
