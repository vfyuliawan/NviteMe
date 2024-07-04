// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/core/api.dart';
import 'package:http/http.dart' as http;
import 'package:nvite_me/RefactorApp/domain/model/request/login/model_request_login.dart';
import 'package:nvite_me/RefactorApp/domain/service/login/login_service.dart';

part 'onboarding_bloc_event.dart';
part 'onboarding_bloc_state.dart';

class OnboardingBloc extends Bloc<OnboardingBlocEvent, OnboardingBlocState> {
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  OnboardingBloc() : super(OnboardingInitial()) {
    on<PageChangedEvent>((event, emit) {
      currentIndex = event.pageIndex;
      emit(OnboardingPageChanged(currentIndex));
    });

    on<NextPageEvent>((event, emit) {
      if (currentIndex < 2) {
        currentIndex + 1;
        pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
      } else {
        event.context.replace("/detail");
      }
    });

    on<SkipEvent>((event, emit) async {
      // event.context.replace("/detail");
      ModelRequestLoginInterface request =
          ModelRequestLoginInterface("galang2", "password");
      LoginService().loginService(request).then((value) {
        print('Response code :${value?.result.username}');
      });
    });
  }
}
