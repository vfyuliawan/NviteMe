// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_create_undangan.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/theme_example/model_get_theme_example.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/project/create_project/cubit/create_project_cubit.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/widgets/CardProjectTemplate.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/FormTextFieldWithIcon.dart';
import 'package:nvite_me/widgets/HorizontalTimeline.dart';
import 'package:nvite_me/widgets/IBodyRoundedWidget.dart';

class CreateProjectScreen extends StatelessWidget {
  const CreateProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CreateProjectCubit>();

    int bodyScreen = cubit.screen;
    bool loadingSlug = cubit.isLoadingSlug;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsetsDirectional.symmetric(vertical: 10),
        decoration: BoxDecoration(color: Constans.fourthColor),
        child: buttonPrevNext(bodyScreen, cubit),
      ),
      resizeToAvoidBottomInset:
          true, // This makes the content scroll when the keyboard appears
      body: IBodyRoundedWidget(
        titleAppBar: "Create Invitation",
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: HorizontalTimeline(
                items: [
                  TimelineItem(
                    title: 'Theme',
                    isCompleted: bodyScreen > 0,
                    isProgress: bodyScreen > -1,
                  ),
                  TimelineItem(
                    title: 'Cover',
                    isCompleted: bodyScreen > 1,
                    isProgress: bodyScreen > 0,
                  ),
                  TimelineItem(
                    title: 'Info',
                    isCompleted: bodyScreen > 2,
                    isProgress: bodyScreen > 1,
                  ),
                  TimelineItem(
                    title: 'Event',
                    isCompleted: bodyScreen > 3,
                    isProgress: bodyScreen > 2,
                  ),
                  TimelineItem(
                    title: 'Story',
                    isCompleted: bodyScreen > 4,
                    isProgress: bodyScreen > 3,
                  ),
                  TimelineItem(
                    title: 'Galery',
                    isCompleted: bodyScreen > 5,
                    isProgress: bodyScreen > 4,
                  ),
                  TimelineItem(
                    title: 'Gift',
                    isCompleted: bodyScreen > 6,
                    isProgress: bodyScreen > 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            bodyScreen == -1 && !loadingSlug
                ? cekSlug(cubit, context)
                : bodyScreen == -1 && loadingSlug
                    ? widgetLoadingSlug()
                    : bodyScreen == 0
                        ? theme(cubit, context)
                        : bodyScreen == 1
                            ? cover(cubit)
                            : bodyScreen == 2
                                ? braidInfo()
                                : bodyScreen == 3
                                    ? event()
                                    : bodyScreen == 4
                                        ? story()
                                        : bodyScreen == 5
                                            ? galery()
                                            : bodyScreen == 6
                                                ? gift()
                                                : Container(),
            // bodyScreen != -1 ? buttonPrevNext(bodyScreen, cubit) : Container()
          ],
        ),
        bodyColor: Constans.fourthColor,
        goBack: () {
          if (bodyScreen > -1) {
            Utilities().showDialogConfrimation(context, "Perhatian",
                "Apakah Anda Yakin \nKeluar Dari Form Ini?", () {
              context.pop();
            });
          } else {
            context.pop();
          }
        },
      ),
    );
  }

  Widget widgetLoadingSlug() {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Center(
            child: Column(
          children: [
            LoadingAnimationWidget.discreteCircle(
              color: Colors.grey,
              secondRingColor: Constans.secondaryColor,
              thirdRingColor: Constans.sixth,
              size: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Checking Availabel Slug",
              style: TextStyle(
                fontFamily: 'Roboto-black',
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget cekSlug(CreateProjectCubit cubit, BuildContext context) {
    String slug = "";
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            FormTextField(
              topSpace: 4,
              onChanged: (value) {
                cubit.project.theme.slug = value;
                slug = value;
              },
              labelText: "",
              labelColor: Colors.black45,
              labelSize: 16,
              hintText: "Slug",
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 120,
              child: Image.asset("assets/icons/www.png"),
            ),
            SizedBox(
              height: 15,
            ),
            button("Cek Slug", () {
              cubit.checkSlug(slug, context);
            }),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget theme(CreateProjectCubit cubit, BuildContext context) {
    // Split the title into Ride and Broom (assuming they are separated by a space or delimiter)
    List<String> titleParts = cubit.project.title.split(" ");
    String ride = titleParts.isNotEmpty ? titleParts[0] : "";
    String broom = titleParts.length > 1 ? titleParts[1] : "";

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context)
              .viewInsets
              .bottom, // Adjust for the keyboard
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Divider(
              thickness: 2,
              color: Constans.secondaryColor,
            ),
            Center(
              child: Text(
                "Theme",
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 25,
                  color: Constans.secondaryColor,
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Constans.secondaryColor,
            ),
            SizedBox(
              height: 15,
            ),
            FormTextField(
              enable: false,
              topSpace: 4,
              initialValue: cubit.project.theme.slug,
              onChanged: (value) {},
              labelText: "Slug",
              labelColor: Colors.black45,
              labelSize: 16,
              hintText: "Slug",
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: FormTextField(
                    enable: true,
                    topSpace: 4,
                    initialValue: ride,
                    onChanged: (value) {
                      cubit.projectFormSubmit(
                          cubit.project.copyWith(title: "$value $broom"));
                    },
                    labelText: "Ride",
                    labelColor: Colors.black45,
                    labelSize: 16,
                    hintText: "Ride",
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "&",
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: "Pacifico",
                        color: Constans.secondaryColor),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: FormTextField(
                    enable: true,
                    topSpace: 4,
                    initialValue: broom,
                    onChanged: (value) {
                      cubit.projectFormSubmit(
                          cubit.project.copyWith(title: "$ride $value"));
                    },
                    labelText: "Broom",
                    labelColor: Colors.black45,
                    labelSize: 16,
                    hintText: "Broom",
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            FormTextField(
              enable: false,
              topSpace: 4,
              initialValue: cubit.project.title.isEmpty
                  ? ""
                  : "${cubit.project.title.split(" ")[0]} & ${cubit.project.title.split(" ")[1]}",
              onChanged: (value) {},
              labelText: "Title",
              labelColor: Colors.black45,
              labelSize: 16,
              hintText: "Title",
            ),
            SizedBox(
              height: 15,
            ),
            FormTextField(
              enable: true,
              topSpace: 4,
              initialValue: cubit.project.home.quotes,
              onChanged: (value) {
                cubit.projectFormSubmit(cubit.project.copyWith(
                    home: cubit.project.home.copyWith(quotes: value)));
              },
              labelText: "Quotes",
              labelColor: Colors.black45,
              labelSize: 16,
              line: 6,
              hintText: "Quotes",
            ),
            GestureDetector(
              onTap: () {
                cubit.onClickQuotesList(context);
              },
              child: Text(
                "See Quotes Preset >",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            FormTextFieldWithIcon(
              labelText: "Theme",
              hintText: "Select Theme",
              initialValue: cubit.project.theme.theme,
              icon: Icons.arrow_forward_ios,
              onChange: (val) {},
              onTapIcon: () async {
                final themeOnGoback = await context
                    .push<ListTheme>("/home/createUndangan/listTemplate/false");
                ModelRequestCreateUndangan themeProject = cubit.project
                    .copyWith(
                        theme: cubit.project.theme
                            .copyWith(theme: themeOnGoback?.themeName));
                cubit.projectFormSubmit(themeProject);
                cubit.onChangeTheme(themeOnGoback!);
              },
            ),
            SizedBox(
              height: 20,
            ),
            cubit.themeChoses.themeName != ""
                ? Center(
                    child: Container(
                      width: 350,
                      child: CardProjectTemplate(
                          item: cubit.themeChoses,
                          name: cubit.themeChoses.themeName ?? "",
                          context: context),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            FormTextFieldWithIcon(
              labelText: "Music",
              hintText: "Select Music",
              initialValue: cubit.project.theme.music,
              icon: Icons.arrow_forward_ios,
              onChange: (val) {},
              onTapIcon: () async {
                // final themeOnGoback = await context
                //     .push<ListTheme>("/home/createUndangan/listTemplate/false");
                // ModelRequestCreateUndangan themeProject = cubit.project
                //     .copyWith(
                //         theme: cubit.project.theme
                //             .copyWith(theme: themeOnGoback?.themeName));
                // cubit.projectFormSubmit(themeProject);
                // cubit.onChangeTheme(themeOnGoback!);
              },
            ),
            SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonPrevNext(
    int bodyScreen,
    CreateProjectCubit cubit,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        bodyScreen != 0
            ? GestureDetector(
                onTap: () {
                  if (cubit.screen != 0) {
                    cubit.changeScreen(cubit.screen - 1);
                  }
                },
                child: Container(
                  // ignore: sort_child_properties_last
                  child: Text(
                    "< Previous",
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Constans.secondaryColor,
                  ),
                  width: 150,
                ),
              )
            : Container(),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            if (bodyScreen < 6) {
              cubit.changeScreen(cubit.screen + 1);
            }
          },
          child: Container(
            // ignore: sort_child_properties_last
            child: Text(
              "Next >",
              style: TextStyle(
                  fontFamily: 'Pacifico', fontSize: 18, color: Colors.white),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Constans.secondaryColor,
            ),
            width: 150,
          ),
        ),
      ],
    );
  }

  Widget button(String title, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        // ignore: sort_child_properties_last
        child: Text(
          title,
          style: TextStyle(
              fontFamily: 'Pacifico', fontSize: 18, color: Colors.white),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Constans.sixth,
        ),
        width: 200,
      ),
    );
  }

  Widget cover(CreateProjectCubit cubit) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cover",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 25,
                color: Constans.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget braidInfo() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Braid Info",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 25,
                color: Constans.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget event() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Event",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 25,
                color: Constans.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget story() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Story",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 25,
                color: Constans.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget galery() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Galery",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 25,
                color: Constans.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gift() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gift",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 25,
                color: Constans.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
