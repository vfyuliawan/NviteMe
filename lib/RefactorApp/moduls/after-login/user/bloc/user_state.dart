part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserIsSuccess extends UserState {
  final ModelUserResponse detailUser;

  UserIsSuccess({required this.detailUser});
}

final class UserIsLoading extends UserState {}

final class UserIsFailed extends UserState {
  final String message;

  UserIsFailed(this.message);
}

final class UserIsEdited extends UserState {
  final ModelUserResponse detailUser;

  UserIsEdited(this.detailUser);
}
