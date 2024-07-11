import 'package:nvite_me/RefactorApp/domain/model/request/login/model_request_login.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/login/model_response_login.dart';
import 'package:nvite_me/RefactorApp/domain/repository/login/login_repository.dart';

class LoginService {
  Future<ModelResponseLoginInterface?> login(
      ModelRequestLoginInterface param) async {
    Future<ModelResponseLoginInterface?> result =
        LoginRepository().loginRepository(param);
    return result;
  }

  Future<bool?> cekLogin() async {
    Future<bool?> res = LoginRepository().cekLogin();
    return res;
  }
}
