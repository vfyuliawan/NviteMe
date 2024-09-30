import 'dart:convert';

import 'package:nvite_me/RefactorApp/core/Api.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/theme_example/model_request_create_theme.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/theme_example/model_theme_example_inquiry.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/theme_example/model_get_theme_example.dart';
import 'package:http/http.dart' as http;
import 'package:nvite_me/RefactorApp/domain/model/response/theme_example/model_response_create_theme.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/theme_example/model_response_delete_theme.dart';

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

  Future<ModelResponseCreateTheme?> createTheme(
      ModelRequestCreateTheme props) async {
    ModelRequestCreateTheme reqBody = ModelRequestCreateTheme(
        themeName: props.themeName,
        themeColor: props.themeColor,
        bgImage: props.bgImage,
        fgImage: props.fgImage);

    final fetch = FetchInterface(
      path: "/api/v1/theme/create",
      isAuthHeader: true,
      reqBody: reqBody.toJson(),
    );

    http.Response response = await APIService.post(fetch);
    if (response.statusCode == 200) {
      final result =
          ModelResponseCreateTheme.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }

  Future<ModelResponseDeleteTheme?> deleteTheme(String id) async {
    final fetch = FetchInterface(
        path: "/api/v1/theme/delete?id=$id", isAuthHeader: true, reqBody: {});

    http.Response response = await APIService().deleted(fetch);
    if (response.statusCode == 200) {
      final result =
          ModelResponseDeleteTheme.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }
}
