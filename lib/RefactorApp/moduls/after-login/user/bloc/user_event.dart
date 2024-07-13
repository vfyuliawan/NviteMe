part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUserDetail extends UserEvent {
  final BuildContext context;

  GetUserDetail(this.context);
}

class LogoutUser extends UserEvent {
  final BuildContext context;

  LogoutUser(this.context);
}

class EditUser extends UserEvent {
  final BuildContext context;

  EditUser(this.context);
}

class UpdatedForm extends UserEvent {
  final ModelUserResponse detailUser;

  UpdatedForm(this.detailUser);
}

class OnSubmitUpdate extends UserEvent {}

class OnEditCencel extends UserEvent {
  final ModelUserResponse detailUser;

  OnEditCencel(this.detailUser);
}

class OnPickImage extends UserEvent {}
