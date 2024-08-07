// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_project_template_bloc.dart';

@immutable
sealed class DetailProjectTemplateEvent {}

class GetProjectDetailSample extends DetailProjectTemplateEvent {
  final String id;
  final BuildContext contex;

  GetProjectDetailSample({
    required this.id,
    required this.contex,
  });
}

class OpenClosetheme extends DetailProjectTemplateEvent {
  final bool isOpen;

  OpenClosetheme({required this.isOpen});
}

class OpenCloseHero extends DetailProjectTemplateEvent {
  final bool isOpen;

  OpenCloseHero({required this.isOpen});
}

class OpenCloseHome extends DetailProjectTemplateEvent {
  final bool isOpen;

  OpenCloseHome({required this.isOpen});
}

class OpenCloseCover extends DetailProjectTemplateEvent {
  final bool isOpen;

  OpenCloseCover({required this.isOpen});
}

class UpdateProjectTemplate extends DetailProjectTemplateEvent {
  final ResultModelResponseDetailSample detail;

  UpdateProjectTemplate({required this.detail});
}

class SubmitUpdateProjectTemplate extends DetailProjectTemplateEvent {
  final ResultModelResponseDetailSample detail;

  SubmitUpdateProjectTemplate({required this.detail});
}
