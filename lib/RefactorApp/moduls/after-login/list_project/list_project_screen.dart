// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/list_project/cubit/list_project_cubit.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/widgets/CardListProject.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'bloc/list_project_bloc.dart';

class ListProjectScreen extends StatelessWidget {
  ListProjectScreen({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<ListProjectCubit>().loadMoreItems("");
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        backgroundColor: Constans.secondaryColor,
        title: Text(
          "List Projct",
          style: TextStyle(color: Colors.white, fontFamily: "Pacifico"),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Constans.secondaryColor),
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            child: FormTextField(
              onChanged: (value) {
                context.read<ListProjectCubit>().searchProject(value);
              },
              labelText: "",
              hintText: "Search",
            ),
          ),
          Expanded(
            child: BlocBuilder<ListProjectCubit, ListProjectCubitState>(
              builder: (context, state) {
                List<ListProject> listItem = [];
                bool loadMore = false;
                if (state is ListProjectCubitIsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ListProjectCubitIsSuccess) {
                  listItem = state.projects;
                } else if (state is ListProjectCubitLoadMore) {
                  loadMore = true;
                  listItem = state.projects;
                }
                return Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        controller: scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.80,
                        ),
                        itemCount: listItem.length,
                        itemBuilder: (context, index) {
                          return CardListProject(
                              detailProject: listItem, index: index);
                        },
                      ),
                    ),
                    loadMore
                        ? Center(child: CircularProgressIndicator())
                        : Container()
                  ],
                );
                //  else {
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}
