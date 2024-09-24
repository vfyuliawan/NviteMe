part of 'list_project_bloc.dart';

@immutable
sealed class ListProjectState {}

final class ListProjectInitial extends ListProjectState {}

final class ListProjectMoreLoaded extends ListProjectState {
  final ResultProjectSample newResult;
  final bool? isSearchOpen;
  final bool? isSearch;

  ListProjectMoreLoaded(
      {required this.newResult,
      required this.isSearchOpen,
      this.isSearch = false});
}

final class ListProjectIsSuccess extends ListProjectState {
  final ResultProjectSample firstResult;
  final bool firstFetch;
  final bool isSearchOpen;

  ListProjectIsSuccess(this.firstResult, this.firstFetch, this.isSearchOpen);
}

final class ListProjectIsFailed extends ListProjectState {
  final String message;

  ListProjectIsFailed({required this.message});
}

final class ListProjectLoading extends ListProjectState {}
