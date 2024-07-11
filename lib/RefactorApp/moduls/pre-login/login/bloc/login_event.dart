part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {}

class FormChange extends LoginEvent {
  final ModelLoginForm loginForm;

  FormChange({required this.loginForm});
}
