part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUserDetail extends UserEvent {}

class LogoutUser extends UserEvent {
  final BuildContext context;

  LogoutUser(this.context);
}

class EditUser extends UserEvent {}

class UpdatedForm extends UserEvent {
  final ModelUserResponse detailUser;

  UpdatedForm(this.detailUser);
}

class OnSubmitUpdate extends UserEvent {}
