import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/theme_example/model_theme_example_inquiry.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/theme_example/model_get_theme_example.dart';
import 'package:nvite_me/RefactorApp/domain/service/projects/projects_service.dart';
import 'package:nvite_me/RefactorApp/domain/service/theme_example_service/theme_example_service.dart';

part 'main_menu_event.dart';
part 'main_menu_state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  MainMenuBloc() : super(MainMenuInitial()) {
    on<GetProjectSampele>((event, emit) async {
      emit(MainMenuIsLoading());
      ModelThemeExampleInquiry reqBody =
          ModelThemeExampleInquiry(themeName: "", currentPage: 0, pageSize: 10);
      final projectTemplate = await ThemeExampleService().themeInquiry(reqBody);

      ModelRequestProjectSample params =
          ModelRequestProjectSample(currentPage: 0, size: 7, title: "");
      final myProject = await ProjectService().getMyProject(params);

      if (projectTemplate != null && myProject != null) {
        emit(GetProjectTemplateIsSuccess(
            projectTemplate: projectTemplate.result,
            myProject: myProject.result));
      }
    });
  }
}
