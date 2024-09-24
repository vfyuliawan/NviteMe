part of 'list_template_cubit.dart';

@immutable
sealed class ListTemplateState {}

final class ListTemplateInitial extends ListTemplateState {}

final class ListTemplateIsSuccess extends ListTemplateState {
  final List<ListProject> projects;
  final bool searchBarIsOpen;

  ListTemplateIsSuccess(this.projects, this.searchBarIsOpen);
}

final class ListTemplateIsLoading extends ListTemplateState {
  final bool searchBarIsOpen;

  ListTemplateIsLoading(this.searchBarIsOpen);
}

final class ListTemlateLoadMore extends ListTemplateState {
  final List<ListProject> projects;
  final bool onLoad;

  ListTemlateLoadMore(this.projects, this.onLoad);
}

final class ListTemplateIsFailed extends ListTemplateState {
  final String message;

  ListTemplateIsFailed(this.message);
}
