import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/service/projects/projects_service.dart';

part 'main_menu_event.dart';
part 'main_menu_state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  MainMenuBloc() : super(MainMenuInitial()) {
    on<GetProjectSampele>((event, emit) async {
      emit(MainMenuIsLoading());
      ModelRequestProjectSample reqBody =
          ModelRequestProjectSample(title: "Project", currentPage: 0, size: 10);
      final res = await ProjectService().getProjectSampel(reqBody);
      if (res != null) {
        emit(GetProjectTemplateIsSuccess(result: res.result));
      }
    });
  }
}
