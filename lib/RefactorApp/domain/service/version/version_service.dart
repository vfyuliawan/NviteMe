import 'package:nvite_me/RefactorApp/domain/model/response/version/model_response_get_version.dart';
import 'package:nvite_me/RefactorApp/domain/repository/version/version_repository.dart';

class VersionService {
  Future<ModelVersionResponse?> getVersionActive() async {
    ModelVersionResponse? result = await VersionRepository().getVersionActive();
    return result;
  }
}
