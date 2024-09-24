part of 'list_project_cubit.dart';

@immutable
sealed class ListProjectCubitState {}

final class ListProjectInitial extends ListProjectCubitState {}

final class ListProjectCubitIsSuccess extends ListProjectCubitState {
  final List<ListProject> projects;
  final int totalElement;
  final bool hasMoreData;

  ListProjectCubitIsSuccess(this.projects, this.totalElement, this.hasMoreData);
}

final class ListProjectCubitLoadMore extends ListProjectCubitState {
  final List<ListProject> projects;

  ListProjectCubitLoadMore(this.projects);
}

final class ListProjectCubitIsLoading extends ListProjectCubitState {}

final class ListProjectCubitIsFailed extends ListProjectCubitState {
  final String message;

  ListProjectCubitIsFailed(this.message);
}
