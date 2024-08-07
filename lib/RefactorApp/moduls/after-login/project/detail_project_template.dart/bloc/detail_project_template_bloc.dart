// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_create_project.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_create_project.dart';
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
        emit(currentState.copyWith(themeIsOpen: event.isOpen));
      }
    });
    on<OpenCloseHero>((event, emit) {
      if (state is DetailProjectTempalteIsSuccess) {
        final currentState = state as DetailProjectTempalteIsSuccess;
        emit(currentState.copyWith(heroIsOpen: event.isOpen));
      }
    });

    on<UpdateProjectTemplate>((event, emit) {
      final currentState = state as DetailProjectTempalteIsSuccess;
      emit(currentState.copyWith(resultDetail: event.detail));
    });

    on<SubmitUpdateProjectTemplate>((event, emit) async {
      ModelRequestCreateProject request = ModelRequestCreateProject(
          title: event.detail.title,
          cover: CoverResponse(
            img: event.detail.cover.img,
            isShow: event.detail.cover.isShow,
          ),
          countdown: event.detail.countdown,
          hero: CoverResponse(
            img: event.detail.hero.img,
            isShow: event.detail.hero.isShow,
          ),
          home: HomeResponse(
            quotes: event.detail.home.quotes,
            img: event.detail.home.img,
            isShow: event.detail.home.isShow,
          ),
          theme: ThemeResponse(
            slug: event.detail.theme.slug,
            alamat: event.detail.theme.alamat,
            embeded: event.detail.theme.embeded,
            theme: event.detail.theme.theme,
            music: event.detail.theme.music,
          ),
          infoAcara: InfoAcarResponse(
              akad: AkadResponse(
                  titleAkad: event.detail.infoAcara.akad.titleAkad,
                  mapAkad: event.detail.infoAcara.akad.mapAkad,
                  imgAkad: event.detail.infoAcara.akad.imageAkad,
                  lokasiAkad: event.detail.infoAcara.akad.lokasiAkad,
                  dateAkad: event.detail.infoAcara.akad.dateAkad),
              resepsi: ResepsiResponse(
                  titleResepsi: event.detail.infoAcara.resepsi.titleResepsi,
                  mapResepsi: event.detail.infoAcara.resepsi.mapResepsi,
                  imgResepsi: event.detail.infoAcara.resepsi.imageResepsi,
                  lokasiResepsi: event.detail.infoAcara.resepsi.lokasiResepsi,
                  dateResepsi: event.detail.infoAcara.resepsi.dateResepsi)),
          braidInfo: BraidInfoResponse(
              male: MaleResponse(
                  name: event.detail.braidInfo.male.name,
                  mom: event.detail.braidInfo.male.mom,
                  dad: event.detail.braidInfo.male.dad,
                  photo: event.detail.braidInfo.male.image),
              female: MaleResponse(
                  name: event.detail.braidInfo.female.name,
                  mom: event.detail.braidInfo.female.mom,
                  dad: event.detail.braidInfo.female.dad,
                  photo: event.detail.braidInfo.female.image),
              isShow: event.detail.braidInfo.isShow),
          story: ModelRequestCreateProjectStory(
              stories: event.detail.story.stories.map((e) {
                return StoryElementReq(
                    title: e.title, text: e.text, image: e.image, date: e.date);
              }).toList(),
              isShow: event.detail.story.isShow),
          galery: GaleryRequeset(
              galeries: event.detail.galery.galeries.map((e) {
                return e;
              }).toList(),
              isShow: event.detail.galery.isShow),
          gift: ModelRequestCreateProjectGift(
              gifts: event.detail.gift.gifts.map((e) {
                return GiftElementReq(
                    image: e.image, name: e.name, noRek: e.noRek);
              }).toList(),
              isShow: event.detail.gift.isShow ?? false));
      ModelResponseCreateProject? res =
          await ProjectService().createProject(request);
      if (res!.result != null) {
        emit(DetailProjectTempalteIsSuccess(
            resultDetail: res.result,
            coverIsOpen: true,
            heroIsOpen: true,
            homeIsOpen: true,
            themeIsOpen: true));
      } else {
        emit(DetailProjectTempalteIsFailed("failed"));
      }
    });

    on<OpenCloseHome>((event, emit) {
      if (state is DetailProjectTempalteIsSuccess) {
        final currentState = state as DetailProjectTempalteIsSuccess;
        emit(currentState.copyWith(homeIsOpen: event.isOpen));
      }
    });

    on<OpenCloseCover>((event, emit) {
      if (state is DetailProjectTempalteIsSuccess) {
        final currentState = state as DetailProjectTempalteIsSuccess;
        emit(currentState.copyWith(coverIsOpen: event.isOpen));
      }
    });
  }
}
