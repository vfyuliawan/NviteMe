part of 'main_menu_bloc.dart';

@immutable
sealed class MainMenuEvent {}

class GetProjectSampele extends MainMenuEvent {
  final BuildContext context;

  GetProjectSampele(this.context);
}
