import 'dart:convert';

import 'package:nvite_me/RefactorApp/core/Api.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_detail_sample.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:http/http.dart' as http;

class ProjectRepository {
  Future<ModelResponseGetProject?> getProjectSample(
      ModelRequestProjectSample props) async {
    ModelRequestProjectSample reqBody = ModelRequestProjectSample(
        title: props.title, currentPage: props.currentPage, size: props.size);
    FetchInterface request = FetchInterface(
        path: "/api/v1/project/inquiry",
        isAuthHeader: true,
        reqBody: reqBody.toJson());
    http.Response response = await APIService.post(request);
    if (response.statusCode == 200) {
      ModelResponseGetProject result =
          ModelResponseGetProject.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }

  Future<ModelResponseDetailSample?> getDetailProjectSample(String id) async {
    FetchInterfaceGet request = FetchInterfaceGet(
      path: "/api/v1/project/get?id=$id",
      isAuthHeader: true,
    );
    http.Response response = await APIService.get(request);
    if (response.statusCode == 200) {
      ModelResponseDetailSample result =
          ModelResponseDetailSample.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }
}
