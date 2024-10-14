part of 'create_project_cubit.dart';

@immutable
sealed class CreateProjectState {}

final class CreateProjectInitial extends CreateProjectState {}

final class CreateProjectForm extends CreateProjectState {
  final ModelRequestCreateUndangan project;

  CreateProjectForm(this.project);
}

final class CreateProjectBody extends CreateProjectState {
  final int screen;
  final bool slugLoading;
  final ModelRequestCreateUndangan project;
  final ListTheme themeChoses;

  CreateProjectBody(this.slugLoading, this.project, this.themeChoses,
      {required this.screen});
}
