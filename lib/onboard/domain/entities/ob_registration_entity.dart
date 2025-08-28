import 'package:equatable/equatable.dart';

class UserRegistrationEntity extends Equatable {
  final String status;
  final String statusCode;
  final String message;
  final List<UserRegistrationDataEntity> data;

  UserRegistrationEntity({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [status, statusCode, message, data];
}

class UserRegistrationDataEntity extends Equatable {
  String userName;
  String userMobile;
  String userEmail;
  String userPassword;

  UserRegistrationDataEntity({
    required this.userName,
    required this.userMobile,
    required this.userEmail,
    required this.userPassword,
  });

  @override
  List<Object?> get props => [
        userName,
        userMobile,
        userEmail,
        userPassword,
      ];
}
