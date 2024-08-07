part of 'detail_project_template_bloc.dart';

@immutable
sealed class DetailProjectTemplateState {}

final class DetailProjectTemplateInitial extends DetailProjectTemplateState {}

final class DetailProjectTempalteIsSuccess extends DetailProjectTemplateState {
  final ResultModelResponseDetailSample resultDetail;
  final bool themeIsOpen;
  final bool heroIsOpen;
  final bool homeIsOpen;
  final bool coverIsOpen;

  DetailProjectTempalteIsSuccess({
    required this.resultDetail,
    this.themeIsOpen = false,
    this.heroIsOpen = false,
    this.homeIsOpen = false,
    this.coverIsOpen = false,
  });

  DetailProjectTempalteIsSuccess copyWith({
    ResultModelResponseDetailSample? resultDetail,
    bool? themeIsOpen,
    bool? heroIsOpen,
    bool? homeIsOpen,
    bool? coverIsOpen,
  }) {
    return DetailProjectTempalteIsSuccess(
      resultDetail: resultDetail ?? this.resultDetail,
      themeIsOpen: themeIsOpen ?? this.themeIsOpen,
      heroIsOpen: heroIsOpen ?? this.heroIsOpen,
      homeIsOpen: homeIsOpen ?? this.homeIsOpen,
      coverIsOpen: coverIsOpen ?? this.coverIsOpen,
    );
  }
}

final class DetailProjectTempalteIsFailed extends DetailProjectTemplateState {
  final String message;

  DetailProjectTempalteIsFailed(this.message);
}

final class DetailProjectTempalteIsLoading extends DetailProjectTemplateState {}

final class UpdateDetailProjectTemplate extends DetailProjectTemplateState {
  final ResultModelResponseDetailSample resultDetail;

  UpdateDetailProjectTemplate({
    required this.resultDetail,
  });
}
