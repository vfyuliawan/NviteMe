// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_detail_sample.dart';
import 'package:nvite_me/RefactorApp/domain/service/projects/projects_service.dart';

part 'detail_project_template_event.dart';
part 'detail_project_template_state.dart';

class DetailProjectTemplateBloc
    extends Bloc<DetailProjectTemplateEvent, DetailProjectTemplateState> {
  DetailProjectTemplateBloc() : super(DetailProjectTemplateInitial()) {
    on<GetProjectDetailSample>((event, emit) async {
      emit(DetailProjectTempalteIsLoading());
      try {
        final res = await ProjectService().getDetailProjectSample(event.id);
        if (res!.result != null) {
          emit(DetailProjectTempalteIsSuccess(
            resultDetail: res.result,
          ));
        } else {
          emit(DetailProjectTempalteIsFailed("need Login"));
        }
      } catch (e) {
        emit(DetailProjectTempalteIsFailed(e.toString()));
      }
    });

    on<OpenClosetheme>((event, emit) {
      if (state is DetailProjectTempalteIsSuccess) {
        final currentState = state as DetailProjectTempalteIsSuccess;
        emit(currentState.copyWith(isOpen: event.isOpen));
      }
    });

    on<UpdateProjectTemplate>((event, emit) {
      final currentState = state as DetailProjectTempalteIsSuccess;
      emit(currentState.copyWith(resultDetail: event.detail));
    });
  }
}
