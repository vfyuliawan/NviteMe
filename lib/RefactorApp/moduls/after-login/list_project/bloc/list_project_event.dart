part of 'list_project_bloc.dart';

@immutable
sealed class ListProjectEvent {}

class GetMyProjectEvent extends ListProjectEvent {
  final String isMyProject;
  final String? title;
  final bool isSearch;

  GetMyProjectEvent(
      {required this.isMyProject, required this.title, required this.isSearch});
}

class ToogleSearch extends ListProjectEvent {
  final bool isOpen;

  ToogleSearch({required this.isOpen});
}
