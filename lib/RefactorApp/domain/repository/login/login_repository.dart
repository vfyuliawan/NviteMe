// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nvite_me/RefactorApp/core/api.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/login/model_request_login.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/login/model_response_login.dart';

class LoginRepository {
  Future<ModelResponseLoginInterface?> loginRepository(
      ModelRequestLoginInterface param) async {
    FetchInterface props = FetchInterface(
      path: "/api/v1/auth/authenticate",
      isAuthHeader: false,
      reqBody: {
        "username": param.username,
        "password": param.password,
      },
    );
    http.Response response = await APIService.post(props);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      ModelResponseLoginInterface result =
          ModelResponseLoginInterface.fromJson(responseBody);
      return result;
    } else {
      return null;
    }
  }

  Future<bool> cekLogin() async {
    FetchInterfaceGet props = FetchInterfaceGet(
        path: '/api/v1/auth/cekUserLogin', isAuthHeader: true);
    http.Response response = await APIService.get(props);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
