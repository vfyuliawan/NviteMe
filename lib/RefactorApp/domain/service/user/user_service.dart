import 'package:nvite_me/RefactorApp/domain/model/response/user/model_user_response.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/user/model_user_update.dart';
import 'package:nvite_me/RefactorApp/domain/repository/user/user_repository.dart';

class UserService {
  Future<ModelUserResponseInterface?> getUserDetail() async {
    final result = await UserRepository().getDetailUser();
    return result;
  }

  Future<bool?> userLogout() async {
    final result = await UserRepository().logoutUser();
    return result;
  }

  Future<ModelUserResponseInterface?> updateUser(
      ModelUserUpdateInterface props) async {
    final result = await UserRepository().updateUser(props);
    return result;
  }
}
