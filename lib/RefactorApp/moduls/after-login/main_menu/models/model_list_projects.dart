import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';

class ModelListProjects {
  String id;
  String username;
  String title;
  DateTime date;
  Theme theme;

  ModelListProjects({
    required this.id,
    required this.username,
    required this.title,
    required this.date,
    required this.theme,
  });
}
