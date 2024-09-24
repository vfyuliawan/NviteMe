part of 'list_project_cubit.dart';

@immutable
sealed class ListProjectCubitState {}

final class ListProjectInitial extends ListProjectCubitState {}

final class ListProjectCubitIsSuccess extends ListProjectCubitState {
  final List<ListProject> projects;
  final int totalElement;
  final bool hasMoreData;
  final bool searchBar;

  ListProjectCubitIsSuccess(
      this.projects, this.totalElement, this.hasMoreData, this.searchBar);
}

final class ListProjectCubitLoadMore extends ListProjectCubitState {
  final List<ListProject> projects;
  final bool searchBar;

  ListProjectCubitLoadMore(this.projects, this.searchBar);
}

final class ListProjectCubitIsLoading extends ListProjectCubitState {
  final bool searchBar;
  ListProjectCubitIsLoading(this.searchBar);
}

final class ListProjectCubitIsFailed extends ListProjectCubitState {
  final String message;

  ListProjectCubitIsFailed(this.message);
}
