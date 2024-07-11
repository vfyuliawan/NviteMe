import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/login/model_request_login.dart';
import 'package:nvite_me/RefactorApp/domain/service/login/login_service.dart';
import 'package:nvite_me/RefactorApp/moduls/pre-login/login/model/model_form_login.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/utils/utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginFormState(loginForm: ModelLoginForm.initial())) {
    on<FormChange>((event, emit) {
      final isDisableButton = event.loginForm.username.length >= 5 &&
          event.loginForm.password.length >= 5;
      emit(LoginFormState(
          loginForm:
              event.loginForm.copyWith(isDisableButton: isDisableButton)));
    });

    on<LoginSubmitted>((event, emit) async {
      final currentState = state as LoginFormState;
      emit(LoginIsLoading());
      ModelRequestLoginInterface param = ModelRequestLoginInterface(
          currentState.loginForm.username, currentState.loginForm.password);
      await LoginService().login(param).then((value) {
        if (value != null) {
          Utility()
              .savePref(Constans.bearerToken, "Bearer ${value.result.token}");
          emit(LoginIsSuccess());
        } else {
          Utility().deletePreference(key: Constans.bearerToken);
          emit(LoginIsFailed(message: "Username and password salah"));
          emit(LoginFormState(loginForm: ModelLoginForm.initial()));
        }
      });
    });
  }
}
