part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginIsLoading extends LoginState {}

class LoginIsSuccess extends LoginState {}

class LoginIsFailed extends LoginState {
  final String message;

  LoginIsFailed({required this.message});
}

class LoginFormState extends LoginState {
  final ModelLoginForm loginForm;

  LoginFormState({required this.loginForm});
}
