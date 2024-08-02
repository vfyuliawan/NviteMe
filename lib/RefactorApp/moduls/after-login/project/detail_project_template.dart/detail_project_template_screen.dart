// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_declarations
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
import 'package:nvite_me/widgets/DropDownWidget.dart';
import 'package:nvite_me/widgets/FormTextField.dart';

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
          }
        },
        builder: (context, state) {
          if (state is DetailProjectTempalteIsSuccess) {
            final resultDetail = state.resultDetail;
            final themeIsOpen = state.isOpen;

            return Stack(
              children: [
                AppbarDetail(context),
                ThemeDetail(context, resultDetail),
                BodyDetail(context, resultDetail, themeIsOpen, state),
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
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           WebView(
                  //             slug: widget
                  //                 .detailUser
                  //                 .slug!,
                  //           )),
                  // );
                },
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
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
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
                                  context.read<DetailProjectTemplateBloc>().add(
                                      OpenClosetheme(isOpen: !themeIsOpen));
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
                        fillColor: Colors.black12,
                        enable: false,
                        onChanged: (value) {
                          final updateForm = state.resultDetail.copyWith(
                              theme: resultDetail.theme.copyWith(slug: value));
                          context
                              .read<DetailProjectTemplateBloc>()
                              .add(UpdateProjectTemplate(detail: updateForm));
                        },
                        labelText: "Slug",
                        labelColor: Constans.secondaryColor,
                        borderColor: Constans.secondaryColor,
                        labelSize: 14,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "For change slug URL please contact administrator",
                          style: TextStyle(fontSize: 12, color: Colors.red),
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
                              theme:
                                  resultDetail.theme.copyWith(alamat: value));
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
                              theme:
                                  resultDetail.theme.copyWith(embeded: value));
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
                        onTap: () async => Utility()
                            .openWebBrowser("https://www.embed-map.com"),
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
                                style:
                                    TextStyle(fontSize: 12, color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Select Theme",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Constans.secondaryColor,
                          ),
                        ),
                      ),
                      Container(
                        child: Image.asset(
                            "assets/images/theme/${resultDetail.theme.theme}.png"),
                      ),
                      SizedBox(height: 10),
                      DropdownWidget(
                        icon: Icons.tablet_android,
                        list: Constans.listTheme,
                        initial: resultDetail.theme.theme,
                        setValue: (String value) {
                          final updateForm = state.resultDetail.copyWith(
                              theme: resultDetail.theme.copyWith(theme: value));
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
                          //
                        },
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 15),
                    ]
                  ],
                ),
              )
            ],
          ),
        ),
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
