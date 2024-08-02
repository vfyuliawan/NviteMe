import 'dart:convert';

import 'package:nvite_me/RefactorApp/core/Api.dart';
import 'package:http/http.dart' as http;
import 'package:nvite_me/RefactorApp/domain/model/response/version/model_response_get_version.dart';

class VersionRepository {
  Future<ModelVersionResponse?> getVersionActive() async {
    FetchInterfaceGet param =
        FetchInterfaceGet(path: "/api/v1/version/check", isAuthHeader: true);
    http.Response response = await APIService.get(param);
    if (response.statusCode == 200) {
      ModelVersionResponse result =
          ModelVersionResponse.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }
}
