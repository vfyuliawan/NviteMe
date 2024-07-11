import 'dart:convert';

import 'package:nvite_me/RefactorApp/core/Api.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/user/model_user_response.dart';
import 'package:http/http.dart' as http;
import 'package:nvite_me/RefactorApp/domain/model/response/user/model_user_update.dart';

class UserRepository {
  Future<ModelUserResponseInterface?> getDetailUser() async {
    FetchInterfaceGet param =
        FetchInterfaceGet(path: "/api/v1/user/current", isAuthHeader: true);
    http.Response response = await APIService.get(param);
    if (response.statusCode == 200) {
      ModelUserResponseInterface result =
          ModelUserResponseInterface.fromJson(jsonDecode(response.body));
      return result;
    }
    return null;
  }

  Future<bool?> logoutUser() async {
    FetchInterface props = FetchInterface(
        path: "/api/v1/auth/logout", isAuthHeader: true, reqBody: {});
    http.Response response = await APIService().deleted(props);
    if (response.statusCode == 200) {
      return true;
    }
    return null;
  }

  Future<ModelUserResponseInterface?> updateUser(
      ModelUserUpdateInterface body) async {
    FetchInterface props = FetchInterface(
      path: "/api/v1/user/update",
      isAuthHeader: true,
      reqBody: body.toJson(),
    );
    http.Response resp = await APIService().patch(props);
    if (resp.statusCode == 200) {
      final result = ModelUserResponseInterface.fromJson(jsonDecode(resp.body));
      return result;
    }
    return null;
  }
}
