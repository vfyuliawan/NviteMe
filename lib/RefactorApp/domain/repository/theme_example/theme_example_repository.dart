import 'dart:convert';

import 'package:nvite_me/RefactorApp/core/Api.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/theme_example/model_theme_example_inquiry.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/theme_example/model_get_theme_example.dart';
import 'package:http/http.dart' as http;

class ThemeExampleRepository {
  Future<ModelGetThemeExample?> themeInquiry(
      ModelThemeExampleInquiry props) async {
    FetchInterfaceGet request = FetchInterfaceGet(
        path:
            "/api/v1/theme/inquiry?themeName=${props.themeName}&currentPage=${props.currentPage}&pageSize=${props.pageSize}",
        isAuthHeader: true);
    http.Response response = await APIService.get(request);
    if (response.statusCode == 200) {
      ModelGetThemeExample result =
          ModelGetThemeExample.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }
}
