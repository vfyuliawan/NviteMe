// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/list_template/cubit/list_template_cubit.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/widgets/CardProjectTemplate.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/NoDataFound.dart';

class ListTemplateScreen extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  ListTemplateScreen({Key? key}) : super(key: key);

  void setUpScroll(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<ListTemplateCubit>().loadMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setUpScroll(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              context.read<ListTemplateCubit>().toggleOpenSearchBar(
                  !context.read<ListTemplateCubit>().searchBar);
            },
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        backgroundColor: Constans.secondaryColor,
        title: Text(
          "List Template",
          style: TextStyle(color: Colors.white, fontFamily: "Pacifico"),
        ),
      ),
      body: BlocBuilder<ListTemplateCubit, ListTemplateState>(
        builder: (context, state) {
          bool isSearchOpen = false;
          if (state is ListTemplateIsSuccess) {
            isSearchOpen = state.searchBarIsOpen;
          } else {
            isSearchOpen = context.read<ListTemplateCubit>().searchBar;
          }

          return Stack(children: [
            Container(
              decoration: BoxDecoration(color: Constans.secondaryColor),
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
              child: FormTextField(
                initialValue: context.read<ListTemplateCubit>().titleProject,
                onChanged: (value) {
                  context.read<ListTemplateCubit>().searchTemplate(value);
                },
                labelText: "",
                hintText: "Search",
              ),
            ),
            isSearchOpen
                ? Container(
                    decoration: BoxDecoration(color: Constans.secondaryColor),
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 30),
                    child: FormTextField(
                      initialValue:
                          context.read<ListTemplateCubit>().titleProject,
                      onChanged: (value) {
                        context.read<ListTemplateCubit>().searchTemplate(value);
                      },
                      labelText: "",
                      hintText: "Search",
                    ),
                  )
                : Container(),
            Positioned(
              top: isSearchOpen ? 100 : 10,
              child: Container(
                height: MediaQuery.of(context).size.height -
                    (isSearchOpen ? 165 : 85),
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<ListTemplateCubit, ListTemplateState>(
                  builder: (context, state) {
                    List<ListProject> listProject = [];
                    bool loadMore = false;
                    String searchVal = '';
                    if (state is ListTemplateIsSuccess) {
                      listProject = state.projects;
                      searchVal =
                          context.read<ListTemplateCubit>().titleProject;
                    } else if (state is ListTemplateIsLoading) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Constans.fourthColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            CircularProgressIndicator(
                                color: Constans.secondaryColor),
                          ],
                        ),
                      );
                    } else if (state is ListTemlateLoadMore) {
                      listProject = state.projects;
                      loadMore = true;
                      searchVal =
                          context.read<ListTemplateCubit>().titleProject;
                    }
                    return listProject.isNotEmpty
                        ? Container(
                            margin: EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                                color: Constans.fourthColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            padding: EdgeInsets.only(left: 30, top: 20),
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: listProject.length +
                                  (loadMore
                                      ? 1
                                      : 0), // Adjust the item count for loadMore
                              itemBuilder: (context, index) {
                                if (index == listProject.length) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Constans.secondaryColor,
                                    ),
                                  );
                                }
                                ListProject detailTemplate = listProject[index];

                                return CardProjectTemplate(
                                  item: detailTemplate,
                                  name: detailTemplate.title,
                                  context: context,
                                );
                              },
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Constans.fourthColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  NoDataFoundWidget(
                                    message: "Template Tidak ditemukan ",
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                ),
              ),
            )
          ]);
        },
      ),
    );
  }
}
