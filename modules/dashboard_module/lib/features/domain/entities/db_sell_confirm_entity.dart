import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DbSellConfirmEntity extends Equatable {
  final String status;
  final int statusCode;
  final String message;
  final List<DbSellConfirmDataEntity> data;

  DbSellConfirmEntity({
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

class DbSellConfirmDataEntity extends Equatable {
  final String question;
  final String widgetType;
  final String label;
  final String eventId;
  final bool optional;
  final String fieldType;
  final List<DbSellConfirmQuestionEntity>? item;
  TextEditingController fieldController = TextEditingController();
  FocusNode fieldFocus = FocusNode();
  bool isFieldValidated = false;
  String fieldErrorTxt = "";

  DbSellConfirmDataEntity({
    required this.question,
    required this.widgetType,
    required this.label,
    required this.eventId,
    required this.optional,
    required this.fieldType,
    this.item,
  });

  @override
  List<Object?> get props => [
        question,
        widgetType,
        label,
        eventId,
        optional,
        fieldType,
      ];
}

class DbSellConfirmQuestionEntity extends Equatable {
  final String label;
  final String eventId;
  bool isSelected = false;
  final List<DbSellConfirmFieldItemEntity>? fields;

  DbSellConfirmQuestionEntity({
    required this.label,
    required this.eventId,
    required this.fields,
  });

  @override
  List<Object?> get props => [
        label,
        eventId,
        fields,
      ];
}

class DbSellConfirmFieldItemEntity extends Equatable {
  final String label;
  final String lblId;
  final bool optional;
  final String fieldType;

  DbSellConfirmFieldItemEntity({
    required this.label,
    required this.lblId,
    required this.optional,
    required this.fieldType,
  });

  @override
  List<Object?> get props => [
        label,
        lblId,
        optional,
        fieldType,
      ];
}
