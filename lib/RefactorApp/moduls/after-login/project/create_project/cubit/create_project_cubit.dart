// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:light_modal_bottom_sheet/light_modal_bottom_sheet.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_cek_slug.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_create_undangan.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/theme_example/model_get_theme_example.dart';
import 'package:nvite_me/RefactorApp/domain/service/projects/projects_service.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';
import 'package:nvite_me/constans.dart';

part 'create_project_state.dart';

class CreateProjectCubit extends Cubit<CreateProjectState> {
  CreateProjectCubit() : super(CreateProjectInitial());
  int screen = -1;
  bool isLoadingSlug = false;
  ModelRequestCreateUndangan project = ModelRequestCreateUndangan(
      title: "",
      countdown: DateTime.now(),
      hero: Cover(img: "", isShow: false),
      home: Home(quotes: "", img: "", isShow: false),
      cover: Cover(img: "", isShow: false),
      theme: ThemeProj(slug: "", alamat: "", embeded: "", theme: "", music: ""),
      infoAcara: InfoAcara(
          akad: Akad(
              titleAkad: "",
              mapAkad: "",
              imgAkad: "",
              lokasiAkad: "",
              dateAkad: DateTime.now()),
          resepsi: Resepsi(
              titleResepsi: "",
              mapResepsi: "",
              imgResepsi: "",
              lokasiResepsi: "",
              dateResepsi: DateTime.now())),
      braidInfo: BraidInfo(
          male: Male(name: "", mom: "", dad: "", photo: ""),
          female: Male(name: "", mom: "", dad: "", photo: ""),
          isShow: false),
      story: ModelRequestCreateUndanganStory(stories: [], isShow: false),
      galery: Galery(galeries: [], isShow: false),
      gift: ModelRequestCreateUndanganGift(gifts: [], isShow: false));
  // String slugState = "";

  ListTheme themeChoses = ListTheme(
      id: "",
      themeName: "",
      primaryColor: "",
      secondaryColor: "",
      bgImage: "",
      fgImage: "",
      createdAt: DateTime.now());

  void changeScreen(int valueBody) {
    screen = valueBody;
    emit(CreateProjectBody(screen: valueBody, false, project, themeChoses));
  }

  void projectFormSubmit(ModelRequestCreateUndangan projectState) {
    project = projectState;
    emit(
        CreateProjectBody(screen: screen, isLoadingSlug, project, themeChoses));
  }

  void checkSlug(String slug, BuildContext context) async {
    slug.toLowerCase();
    isLoadingSlug = true;
    project.copyWith(theme: project.theme.copyWith(slug: slug));
    if (project.theme.slug != "" && project.theme.slug.contains("-")) {
      Utilities().showDialogConfrimation(
          context, "Perhatian", "Apakah Anda Yakain \nDengan Slug Ini?", () {
        emit(CreateProjectBody(
            screen: screen, isLoadingSlug, project, themeChoses));
        Future.delayed(
          Duration(milliseconds: 3000),
          () async {
            final res = await ProjectService()
                .cekSlug(ModelRequesCekSlug(slug: project.theme.slug));
            if (res?.result == true) {
              screen = 0;
              isLoadingSlug = false;
              emit(CreateProjectBody(screen: 0, false, project, themeChoses));
              Utilities().showModalInfo(
                  context,
                  "Success",
                  "Berhasil \nSlug ${project.theme.slug} dapat digunakan",
                  "assets/images/please.png");
            } else {
              screen = -1;
              isLoadingSlug = false;
              emit(CreateProjectBody(
                  screen: screen, isLoadingSlug, project, themeChoses));
              Utilities().showModalInfo(context, "Gagal", res?.message ?? "",
                  "assets/images/please.png");
            }
          },
        );
      });
    } else if (!slug.contains("-")) {
      Utilities().showModalInfo(context, "Gagal", "Slug Format Tidak Sesuai",
          "assets/images/please.png");
    } else {
      Utilities().showModalInfo(context, "Gagal", "Slug Tidak Boleh Kosong",
          "assets/images/please.png");
    }
  }

  void onChangeTheme(ListTheme propsTheme) {
    themeChoses = propsTheme;
    emit(
        CreateProjectBody(screen: screen, isLoadingSlug, project, themeChoses));
  }

  void onClickQuotesList(BuildContext context) {
    List<Map<String, dynamic>> listQuotes = [
      {
        "quotes":
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum delectus nobis accusantium dolorum provident et numquam dolores molestias est mollitia.",
        "id": 1,
        "by": "Andi Wherhole"
      },
      {
        "quotes":
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum delectus nobis accusantium dolorum provident et numquam dolores molestias est mollitia.",
        "id": 2,
        "by": "Andi Wherhole",
        "by": "Andi Wherhole"
      },
      {
        "quotes":
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum delectus nobis accusantium dolorum provident et numquam dolores molestias est mollitia.",
        "id": 3,
        "by": "Andi Wherhole"
      },
      {
        "quotes":
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum delectus nobis accusantium dolorum provident et numquam dolores molestias est mollitia.",
        "id": 4,
        "by": "Andi Wherhole"
      },
      {
        "quotes":
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum delectus nobis accusantium dolorum provident et numquam dolores molestias est mollitia.",
        "id": 5,
        "by": "Andi Wherhole"
      },
      {
        "quotes":
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum delectus nobis accusantium dolorum provident et numquam dolores molestias est mollitia.",
        "id": 6,
        "by": "Andi Wherhole"
      },
      {
        "quotes":
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum delectus nobis accusantium dolorum provident et numquam dolores molestias est mollitia.",
        "id": 7,
        "by": "Andi Wherhole"
      },
      {
        "quotes":
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum delectus nobis accusantium dolorum provident et numquam dolores molestias est mollitia.",
        "id": 8,
        "by": "Andi Wherhole"
      },
    ];
    showMaterialModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Material(
        child: SafeArea(
          top: false,
          child: Container(
            decoration: BoxDecoration(color: Constans.fourthColor),
            height: MediaQuery.of(context).size.height *
                0.7, // 90% of screen height
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Preset Quotes",
                    style: TextStyle(
                        color: Constans.secondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: listQuotes.map((e) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              projectFormSubmit(project.copyWith(
                                  home: project.home
                                      .copyWith(quotes: e["quotes"])));
                              context.pop();
                            },
                            child: ListTile(
                              title: Text("~${e["by"]}~"),
                              subtitle: Text(e["quotes"]),
                            ),
                          ),
                          const Divider()
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
