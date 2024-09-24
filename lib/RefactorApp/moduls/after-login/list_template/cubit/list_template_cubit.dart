// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/service/projects/projects_service.dart';
import 'package:nvite_me/RefactorApp/utility/Debouncer.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';

part 'list_template_state.dart';

class ListTemplateCubit extends Cubit<ListTemplateState> {
  int curentPage = 0;
  String titleProject = "Template";
  List<ListProject> projects = [];
  final debouncer = Debouncer(milliseconds: 900);
  bool searchBar = true;

  ListTemplateCubit() : super(ListTemplateInitial());

  void toggleOpenSearchBar(bool value) {
    searchBar = value;
    emit(ListTemplateIsSuccess(projects, searchBar));
  }

  void searchTemplate(String valueSearch) {
    titleProject = valueSearch;
    debouncer.run(() {
      getFirstProject(valueSearch);
    });
  }

  Future<void> loadMore() async {
    curentPage++;
    emit(ListTemlateLoadMore(projects, true));
    try {
      final res = await fetchProjectTemplate(titleProject);
      if (res!.result != null) {
        projects.addAll(res.result.projects);
        emit(ListTemplateIsSuccess(projects, searchBar));
      } else {
        emit(ListTemplateIsFailed("failed to Load Project"));
      }
    } catch (e) {
      Utilities().showMessage(message: e.toString());
    }
  }

  Future<void> getFirstProject(String titleTemplate) async {
    emit(ListTemplateIsLoading(searchBar));
    titleProject = titleTemplate;
    curentPage = 0;
    projects.clear();
    try {
      final res = await fetchProjectTemplate(titleTemplate);
      if (res!.result != null) {
        projects = res.result.projects;
        emit(ListTemplateIsSuccess(projects, searchBar));
      } else {
        emit(ListTemplateIsFailed("failed to get Project"));
      }
    } catch (e) {
      Utilities().showMessage(message: e.toString());
    }
  }

  Future<ModelResponseGetProject?> fetchProjectTemplate(String title) async {
    final res = ProjectService().getProjectSampel(ModelRequestProjectSample(
        currentPage: curentPage, size: 7, title: title));
    return res;
  }
}
