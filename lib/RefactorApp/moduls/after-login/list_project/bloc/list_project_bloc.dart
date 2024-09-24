import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/service/projects/projects_service.dart';

part 'list_project_event.dart';
part 'list_project_state.dart';

class ListProjectBloc extends Bloc<ListProjectEvent, ListProjectState> {
  bool isSearchOpen = false;
  String titleSearch = "";
  int currentPage = 0;

  ScrollController scrollController = ScrollController();

  ListProjectBloc() : super(ListProjectInitial()) {
    on<ListProjectEvent>((event, emit) {});

    on<ToogleSearch>((event, emit) {
      print(event.isOpen);
      isSearchOpen = event.isOpen;
      emit(ListProjectMoreLoaded(
          newResult: (state as ListProjectMoreLoaded).newResult,
          isSearchOpen: event.isOpen));
    });

    on<GetMyProjectEvent>((event, emit) async {
      //fist intiatte state is ProjectIsSuccess when the firsttime rendering
      if (state is ListProjectIsSuccess) return;
      final curentState = state;

      //initialize defaultState-----------------
      List<ListProject> result = [];
      Paging paging = Paging(currentPage: 0, totalPage: 0, size: 0);
      //-----------------------------

      //store the curent state
      if (curentState is ListProjectMoreLoaded) {
        result = curentState.newResult.projects;
        paging = Paging(
            currentPage: curentState.newResult.paging.currentPage,
            totalPage: curentState.newResult.paging.totalPage,
            size: curentState.newResult.paging.size);
      }
      emit(
        ListProjectIsSuccess(
            ResultProjectSample(projects: result, paging: paging),
            currentPage == 0,
            isSearchOpen),
      );

      ModelRequestProjectSample params = ModelRequestProjectSample(
          currentPage: currentPage, size: 7, title: event.title!);
      await ProjectService().getMyProject(params).then((nextResult) {
        currentPage++;
        final result = (state as ListProjectIsSuccess).firstResult;
        result.projects.addAll(nextResult!.result.projects);
        result.paging = Paging(
            currentPage: nextResult.result.paging.currentPage,
            totalPage: nextResult.result.paging.totalPage,
            size: nextResult.result.paging.size);
        emit(ListProjectMoreLoaded(
            newResult: result, isSearchOpen: isSearchOpen));
      });
    });
  }

  void loadListProject() {}

  // void onSearch(String searchQuery, String isMyProject) {
  //   if (_debounce?.isActive ?? false) _debounce!.cancel();
  //   _debounce = Timer(Duration(milliseconds: 500), () {
  //     add(GetMyProjectEvent(
  //       isMyProject: isMyProject,
  //       title: searchQuery,
  //     ));
  //   });
  // }

  @override
  Future<void> close() {
    scrollController.dispose(); // Dispose scroll controller
    return super.close();
  }
}
