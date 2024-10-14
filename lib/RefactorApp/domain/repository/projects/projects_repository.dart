import 'dart:convert';

import 'package:nvite_me/RefactorApp/core/Api.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_cek_slug.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_create_project.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_cek_slug.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_create_project.dart';
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

  Future<ModelResponseGetProject?> getMyProjcets(
      ModelRequestProjectSample props) async {
    FetchInterfaceGet request = FetchInterfaceGet(
      path:
          "/api/v1/project/myProjects?currentPage=${props.currentPage}&size=${props.size}&title=${props.title}",
      isAuthHeader: true,
    );
    http.Response response = await APIService.get(request);
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

  Future<ModelResponseCreateProject?> createNewProject(
      ModelRequestCreateProject props) async {
    FetchInterface request = FetchInterface(
        path: "/api/v1/project/createNew",
        isAuthHeader: true,
        reqBody: props.toJson());
    http.Response response = await APIService.post(request);
    if (response.statusCode == 200) {
      ModelResponseCreateProject result =
          ModelResponseCreateProject.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }

  Future<ModelResponseCekSlug?> cekSlug(ModelRequesCekSlug props) async {
    FetchInterfaceGet request = FetchInterfaceGet(
      path: "/api/v1/project/cekSlug?slug=${props.slug}",
      isAuthHeader: true,
    );
    http.Response response = await APIService.get(request);
    if (response.statusCode == 200) {
      ModelResponseCekSlug res =
          ModelResponseCekSlug.fromJson(jsonDecode(response.body));
      return res;
    } else {
      return null;
    }
  }
}
