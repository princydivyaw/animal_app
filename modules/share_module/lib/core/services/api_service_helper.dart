import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

class APIServiceHelper {
  dynamic getAPIMethod(
    String url,
    bool loading,
  ) async {
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        return response; // return utf8.decode(response.bodyBytes).toString();
      }
    } on SocketException {
      throw "No internet connection";
    } on HandshakeException {
      throw "Service Verification Failed";
    } on TimeoutException {
      throw "Unable to reach server";
    } catch (e) {
      throw e.toString();
    }
  }

  dynamic postAPIMethod({
    required String url,
    required Map<String, String> header,
    required dynamic request,
    bool loading = false,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: header,
            body: request,
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        return response; // return utf8.decode(response.bodyBytes).toString();
      }
    } on SocketException {
      throw "No internet connection";
    } on HandshakeException {
      throw "Service Verification Failed";
    } on TimeoutException {
      throw "Unable to reach server";
    } catch (e) {
      throw e.toString();
    }
  }
}
