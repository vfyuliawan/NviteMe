// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/theme_example/model_theme_example_inquiry.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/theme_example/model_get_theme_example.dart';
import 'package:nvite_me/RefactorApp/domain/service/theme_example_service/theme_example_service.dart';
import 'package:nvite_me/RefactorApp/utility/Debouncer.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';

part 'list_template_state.dart';

class ListTemplateCubit extends Cubit<ListTemplateState> {
  int curentPage = 0;
  String titleProject = "Template";
  List<ListTheme> projects = [];
  final debouncer = Debouncer(milliseconds: 900);
  bool searchBar = true;

  ListTemplateCubit() : super(ListTemplateInitial());

  void toggleOpenSearchBar(bool value) {
    searchBar = value;
    emit(ListTemplateIsSuccess(projects, searchBar));
  }

  void searchTemplate(String valueSearch, BuildContext context) {
    titleProject = valueSearch;
    debouncer.run(() {
      getFirstProject(valueSearch, context);
    });
  }

  Future<void> loadMore() async {
    curentPage++;
    emit(ListTemlateLoadMore(projects, true));
    try {
      final res = await fetchProjectTemplate(titleProject);
      if (res!.result != null) {
        projects.addAll(res.result.listTheme);
        emit(ListTemplateIsSuccess(projects, searchBar));
      } else {
        emit(ListTemplateIsFailed("failed to Load Project"));
      }
    } catch (e) {
      Utilities().showMessage(message: e.toString());
    }
  }

  Future<void> getFirstProject(
      String titleTemplate, BuildContext context) async {
    emit(ListTemplateIsLoading(searchBar));
    titleProject = titleTemplate;
    curentPage = 0;
    projects.clear();
    try {
      final res = await fetchProjectTemplate(titleTemplate);
      if (res!.result != null) {
        projects = res.result.listTheme;
        emit(ListTemplateIsSuccess(projects, searchBar));
      } else {
        emit(ListTemplateIsFailed("failed to get Project"));
      }
    } catch (e) {
      Utilities().showMessage(message: e.toString());
      // ignore: use_build_context_synchronously
      context.replace("login");
    }
  }

  Future<ModelGetThemeExample?> fetchProjectTemplate(String title) async {
    final res = ThemeExampleService().themeInquiry(ModelThemeExampleInquiry(
        currentPage: curentPage, pageSize: 7, themeName: title));
    return res;
  }
}
