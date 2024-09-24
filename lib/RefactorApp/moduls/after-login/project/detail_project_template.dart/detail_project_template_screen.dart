// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_declarations, sort_child_properties_last
// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_detail_sample.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/project/detail_project_template.dart/bloc/detail_project_template_bloc.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/utils/utils.dart';
import 'package:nvite_me/widgets/DateTimeComponent.dart';
import 'package:nvite_me/widgets/DropDownWidget.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/ImageComponentBase64.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';

class DetailProjectTemplateScreen extends StatelessWidget {
  const DetailProjectTemplateScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DetailProjectTemplateBloc, DetailProjectTemplateState>(
        listener: (context, state) {
          if (state is DetailProjectTempalteIsFailed) {
            context.replace("/login");
            Utilities().showMessage(message: state.message);
          }
        },
        builder: (context, state) {
          if (state is DetailProjectTempalteIsSuccess) {
            final resultDetail = state.resultDetail;
            final themeIsOpen = state.themeIsOpen;
            final heroIsOpen = state.heroIsOpen;
            final homeIsOpen = state.homeIsOpen;
            final coverIsOpen = state.coverIsOpen;

            return Stack(
              children: [
                AppbarDetail(context),
                ThemeDetail(context, resultDetail),
                BodyDetail(
                  context,
                  resultDetail,
                  themeIsOpen,
                  coverIsOpen,
                  heroIsOpen,
                  homeIsOpen,
                  state,
                ),
              ],
            );
          } else if (state is DetailProjectTempalteIsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Text(
                  "no State",
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Positioned ThemeDetail(
      BuildContext context, ResultModelResponseDetailSample resultDetail) {
    return Positioned(
      top: 20,
      child: Container(
        height: 300,
        margin: const EdgeInsets.only(top: 80),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(resultDetail.home.img),
                fit: BoxFit.cover,
                opacity: 0.4),
            color: Utilities().cekColor(resultDetail.theme.theme),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                resultDetail.theme.theme.isNotEmpty
                    ? Image.asset(
                        'assets/images/theme/${resultDetail.theme.theme}.png',
                        width: 250,
                        height: 200,
                      )
                    : Image.network('https://placehold.co/250x250/black/white'),
                Text(
                  "You Using Theme ${resultDetail.theme.theme}",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Pacifico',
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Constans.secondaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: const Row(children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Perview",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned BodyDetail(
      BuildContext context,
      ResultModelResponseDetailSample resultDetail,
      bool themeIsOpen,
      bool coverIsOpen,
      bool heroIsOpen,
      bool homeIsOpen,
      DetailProjectTempalteIsSuccess state) {
    return Positioned(
      top: 335,
      right: 0,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 320,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              ThemeView(context, themeIsOpen, resultDetail, state),
              SizedBox(
                height: 20,
              ),
              HeroView(context, heroIsOpen, resultDetail, state),
              SizedBox(
                height: 20,
              ),
              HomeView(context, homeIsOpen, resultDetail, state),
              SizedBox(
                height: 20,
              ),
              ButtonSubmit(resultDetail, context),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector ButtonSubmit(
      ResultModelResponseDetailSample resultDetail, BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(resultDetail);
        context
            .read<DetailProjectTemplateBloc>()
            .add(SubmitUpdateProjectTemplate(detail: resultDetail));
      },
      child: Container(
        child: Text(
          "Submit",
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Constans.secondaryColor),
        width: 180,
      ),
    );
  }

  Container HeroView(
      BuildContext context,
      bool heroIsOpen,
      ResultModelResponseDetailSample resultDetail,
      DetailProjectTempalteIsSuccess state) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constans.secondaryColor)),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hero",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Constans.secondaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<DetailProjectTemplateBloc>()
                            .add(OpenCloseHero(isOpen: !heroIsOpen));
                      },
                      child: heroIsOpen
                          ? Icon(
                              Icons.keyboard_arrow_up,
                              color: Constans.secondaryColor,
                              size: 33,
                            )
                          : Icon(
                              Icons.keyboard_arrow_down,
                              color: Constans.secondaryColor,
                              size: 33,
                            ),
                    )
                  ]),
            ),
          ),
          if (heroIsOpen) ...[
            ImageComponentBase64(
              label: "Gambar Hero",
              img: resultDetail.hero.img,
              pickedImageBase64: (base64Image) {
                final updateForm = state.resultDetail.copyWith(
                    hero: resultDetail.hero.copyWith(img: base64Image));
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(UpdateProjectTemplate(detail: updateForm));
              },
            ),
            SizedBox(height: 10),
            DateTimeComponent(
              dateValue: resultDetail.hero.date,
              setValue: (DateTime time) {
                final updateForm = state.resultDetail
                    .copyWith(hero: resultDetail.hero.copyWith(date: time));
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(UpdateProjectTemplate(detail: updateForm));
              },
            ),
            SizedBox(height: 10),
            SwitchComponent(
              onChange: (value) {
                final updateForm = state.resultDetail
                    .copyWith(hero: resultDetail.hero.copyWith(isShow: value));
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(UpdateProjectTemplate(detail: updateForm));
              },
              value: resultDetail.hero.isShow,
              label: 'Tampilkan Hero',
            ),
            SizedBox(height: 10),
            SizedBox(height: 15),
          ]
        ],
      ),
    );
  }

  Container HomeView(
      BuildContext context,
      bool homeIsOpen,
      ResultModelResponseDetailSample resultDetail,
      DetailProjectTempalteIsSuccess state) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constans.secondaryColor)),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Constans.secondaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<DetailProjectTemplateBloc>()
                            .add(OpenCloseHome(isOpen: !homeIsOpen));
                      },
                      child: homeIsOpen
                          ? Icon(
                              Icons.keyboard_arrow_up,
                              color: Constans.secondaryColor,
                              size: 33,
                            )
                          : Icon(
                              Icons.keyboard_arrow_down,
                              color: Constans.secondaryColor,
                              size: 33,
                            ),
                    )
                  ]),
            ),
          ),
          if (homeIsOpen) ...[
            ImageComponentBase64(
              label: "Gambar Home",
              img: resultDetail.home.img,
              pickedImageBase64: (base64Image) {
                final updateForm = state.resultDetail.copyWith(
                    home: resultDetail.home.copyWith(img: base64Image));
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(UpdateProjectTemplate(detail: updateForm));
              },
            ),
            SizedBox(height: 10),
            FormTextField(
              initialValue: resultDetail.home.quotes,
              enable: true,
              line: 2,
              labelSize: 14,
              labelColor: Constans.secondaryColor,
              borderColor: Constans.secondaryColor,
              onChanged: (value) {
                final updateForm = state.resultDetail
                    .copyWith(home: resultDetail.home.copyWith(quotes: value));
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(UpdateProjectTemplate(detail: updateForm));
              },
              labelText: "Quotes",
            ),
            SizedBox(height: 10),
            SwitchComponent(
              onChange: (value) {
                final updateForm = state.resultDetail
                    .copyWith(home: resultDetail.home.copyWith(isShow: value));
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(UpdateProjectTemplate(detail: updateForm));
              },
              value: resultDetail.home.isShow,
              label: 'Tampilkan Hero',
            ),
            SizedBox(height: 10),
            SizedBox(height: 15),
          ]
        ],
      ),
    );
  }

  Container ThemeView(
      BuildContext context,
      bool themeIsOpen,
      ResultModelResponseDetailSample resultDetail,
      DetailProjectTempalteIsSuccess state) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constans.secondaryColor)),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              context
                  .read<DetailProjectTemplateBloc>()
                  .add(OpenClosetheme(isOpen: !themeIsOpen));
            },
            child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Theme",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Constans.secondaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<DetailProjectTemplateBloc>()
                            .add(OpenClosetheme(isOpen: !themeIsOpen));
                      },
                      child: themeIsOpen
                          ? Icon(
                              Icons.keyboard_arrow_up,
                              color: Constans.secondaryColor,
                              size: 33,
                            )
                          : Icon(
                              Icons.keyboard_arrow_down,
                              color: Constans.secondaryColor,
                              size: 33,
                            ),
                    )
                  ]),
            ),
          ),
          if (themeIsOpen) ...[
            FormTextField(
              initialValue: resultDetail.theme.slug,
              enable: true,
              onChanged: (value) {
                final updateForm = state.resultDetail
                    .copyWith(theme: resultDetail.theme.copyWith(slug: value));
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(UpdateProjectTemplate(detail: updateForm));
              },
              labelText: "Slug",
              labelColor: Constans.secondaryColor,
              borderColor: Constans.secondaryColor,
              labelSize: 14,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.green,
                  ),
                  Text(
                    "Slug Tersedia",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                print(resultDetail);
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(SubmitUpdateProjectTemplate(detail: resultDetail));
              },
              child: Container(
                child: Text(
                  "Check Slug",
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium',
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Constans.secondaryColor),
                width: 180,
              ),
            ),
            SizedBox(height: 10),
            FormTextField(
              initialValue: resultDetail.theme.alamat,
              enable: true,
              line: 2,
              labelSize: 14,
              labelColor: Constans.secondaryColor,
              borderColor: Constans.secondaryColor,
              onChanged: (value) {
                final updateForm = state.resultDetail.copyWith(
                    theme: resultDetail.theme.copyWith(alamat: value));
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(UpdateProjectTemplate(detail: updateForm));
              },
              labelText: "Alamat Rumah",
            ),
            SizedBox(
              height: 15,
            ),
            FormTextField(
              initialValue: resultDetail.theme.embeded,
              enable: true,
              line: 7,
              labelSize: 14,
              onChanged: (value) {
                final updateForm = state.resultDetail.copyWith(
                    theme: resultDetail.theme.copyWith(embeded: value));
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(UpdateProjectTemplate(detail: updateForm));
              },
              labelText: "Embeded",
              labelColor: Constans.secondaryColor,
              borderColor: Constans.secondaryColor,
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () async =>
                  Utility().openWebBrowser("https://www.embed-map.com"),
              child: Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: Colors.blue,
                    ),
                    Text(
                      "Click here to get Embeded map",
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 10),
            // Container(
            //   alignment: Alignment.bottomLeft,
            //   child: Text(
            //     "Select Theme",
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //       color: Constans.secondaryColor,
            //     ),
            //   ),
            // ),
            // Container(
            //   child: Image.asset(
            //       "assets/images/theme/${resultDetail.theme.theme}.png"),
            // ),
            SizedBox(height: 10),
            DropdownWidget(
              icon: Icons.tablet_android,
              list: Constans.listTheme,
              initial: resultDetail.theme.theme,
              setValue: (String value) {
                final updateForm = state.resultDetail
                    .copyWith(theme: resultDetail.theme.copyWith(theme: value));
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(UpdateProjectTemplate(detail: updateForm));
              },
            ),
            SizedBox(height: 15),
            DropdownWidget(
              icon: Icons.music_note,
              list: Constans.listThemeSong,
              initial: resultDetail.theme.music,
              setValue: (String value) {
                final updateForm = state.resultDetail
                    .copyWith(theme: resultDetail.theme.copyWith(music: value));
                context
                    .read<DetailProjectTemplateBloc>()
                    .add(UpdateProjectTemplate(detail: updateForm));
              },
            ),
            SizedBox(height: 10),
            SizedBox(height: 15),
          ]
        ],
      ),
    );
  }

  Container AppbarDetail(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Constans.seventh,
        image: DecorationImage(
            image: AssetImage(
              "assets/icons/bg.png",
            ),
            fit: BoxFit.cover,
            opacity: 0.4),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(left: 15, top: 15),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, right: 10),
              child: const Text(
                "Project Template",
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 25,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
