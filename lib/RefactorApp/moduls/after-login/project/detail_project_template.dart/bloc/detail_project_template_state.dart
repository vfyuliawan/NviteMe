part of 'detail_project_template_bloc.dart';

@immutable
sealed class DetailProjectTemplateState {}

final class DetailProjectTemplateInitial extends DetailProjectTemplateState {}

final class DetailProjectTempalteIsSuccess extends DetailProjectTemplateState {
  final ResultModelResponseDetailSample resultDetail;
  final bool isOpen;

  DetailProjectTempalteIsSuccess({
    required this.resultDetail,
    this.isOpen = false,
  });

  DetailProjectTempalteIsSuccess copyWith(
      {ResultModelResponseDetailSample? resultDetail, bool? isOpen}) {
    return DetailProjectTempalteIsSuccess(
      resultDetail: resultDetail ?? this.resultDetail,
      isOpen: isOpen ?? this.isOpen,
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
