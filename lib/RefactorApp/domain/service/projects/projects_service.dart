import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_create_project.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_create_project.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_detail_sample.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/repository/projects/projects_repository.dart';

class ProjectService {
  Future<ModelResponseGetProject?> getProjectSampel(
      ModelRequestProjectSample props) async {
    final result = await ProjectRepository().getProjectSample(props);
    return result;
  }

  Future<ModelResponseGetProject?> getMyProject(
      ModelRequestProjectSample props) async {
    final result = await ProjectRepository().getMyProjcets(props);
    return result;
  }

  Future<ModelResponseDetailSample?> getDetailProjectSample(String id) async {
    final result = await ProjectRepository().getDetailProjectSample(id);
    return result;
  }

  Future<ModelResponseCreateProject?> createProject(
      ModelRequestCreateProject props) async {
    final result = await ProjectRepository().createNewProject(props);
    return result;
  }
}
