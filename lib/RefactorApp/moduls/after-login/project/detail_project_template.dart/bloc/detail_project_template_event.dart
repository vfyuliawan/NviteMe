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
