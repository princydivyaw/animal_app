import 'dart:convert';

import 'package:animal_app/onboard/domain/entities/ob_registration_entity.dart';

UserRegistrationModel userRegistrationModelFromJson(String str) =>
    UserRegistrationModel.fromJson(json.decode(str));

class UserRegistrationModel extends UserRegistrationEntity {
  UserRegistrationModel({
    required super.status,
    required super.statusCode,
    required super.message,
    required super.data,
  });

  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) =>
      UserRegistrationModel(
        status: json["status"] ?? "",
        statusCode: json["status_code"] ?? "",
        message: json["message"] ?? "",
        data: List<UserRegistrationDataModel>.from(
          json["data"].map((x) => UserRegistrationDataModel.fromJson(x)),
        ),
      );
}

class UserRegistrationDataModel extends UserRegistrationDataEntity {
  UserRegistrationDataModel({
    required super.userName,
    required super.userMobile,
    required super.userEmail,
    required super.userPassword,
  });

  factory UserRegistrationDataModel.fromJson(Map<String, dynamic> json) =>
      UserRegistrationDataModel(
        userName: json["user_name"] ?? "",
        userMobile: json["user_mobile"] ?? "",
        userEmail: json["user_email"] ?? "",
        userPassword: json["user_password"] ?? "",
      );
}
