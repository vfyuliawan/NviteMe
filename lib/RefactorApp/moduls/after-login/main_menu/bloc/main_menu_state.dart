part of 'main_menu_bloc.dart';

@immutable
sealed class MainMenuState {}

final class MainMenuInitial extends MainMenuState {}

final class GetProjectTemplateIsSuccess extends MainMenuState {
  final ResultProjectSample result;

  GetProjectTemplateIsSuccess({required this.result});
}

final class MainMenuIsFailed extends MainMenuState {}

final class MainMenuIsLoading extends MainMenuState {}

final class MainMenuGetProjectSample extends MainMenuState {}
