import 'dart:convert';

import 'package:animal_app/onboard/data/models/ob_all_request_model.dart';
import 'package:animal_app/onboard/data/models/ob_registration_model.dart';
import 'package:share_module/core/constants/app_strings.dart';
import 'package:share_module/core/services/storage_services.dart';

abstract class ObDataSource {
  Future<dynamic> register({required ObRegRequestModel request});
}

class ObDataSourceImpl extends ObDataSource {
  @override
  Future<dynamic> register({required ObRegRequestModel request}) async {
    try {
      final response =
          "{\"status_code\":\"200\",\"status\":\"Success\",\"message\":\"Login successful\","
          "\"data\":[{\"user_email\":\"${request.email}\","
          "\"user_password\":\"${request.password}\"}]}";

      if (response.isNotEmpty) {
        DoHiveUtils.openHiveBox(hiveBoxName: AppStrings.appUserDetails);
        DoHiveUtils.insertValuesToBox(
          hiveBoxName: AppStrings.appUserDetails,
          keyName: AppStrings.userRegDetails,
          value: response,
        );
        var result = jsonDecode(response);
        return UserRegistrationModel.fromJson(result);
      } else {
        return "Invalid Credentials";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
