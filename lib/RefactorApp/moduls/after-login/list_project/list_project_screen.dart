// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/list_project/cubit/list_project_cubit.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/widgets/CardListProject.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/NoDataFound.dart';

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
            onTap: () {
              context
                  .read<ListProjectCubit>()
                  .toggleSearch(!context.read<ListProjectCubit>().searchBar);
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
          "List Projct",
          style: TextStyle(color: Colors.white, fontFamily: "Pacifico"),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<ListProjectCubit, ListProjectCubitState>(
            builder: (context, state) {
              bool searhBar = false;
              if (state is ListProjectCubitIsSuccess) {
                searhBar = state.searchBar;
              } else {
                searhBar = context.read<ListProjectCubit>().searchBar;
              }
              return searhBar
                  ? Container(
                      decoration: BoxDecoration(color: Constans.secondaryColor),
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 20),
                      child: FormTextField(
                        initialValue:
                            context.read<ListProjectCubit>().searchValue,
                        onChanged: (value) {
                          context.read<ListProjectCubit>().onSearch(value);
                        },
                        labelText: "",
                        hintText: "Search",
                      ),
                    )
                  : Container();
            },
          ),
          Expanded(
            child: BlocBuilder<ListProjectCubit, ListProjectCubitState>(
              builder: (context, state) {
                List<ListProject> listItem = [];
                bool loadMore = false;
                int totalPage = 0;
                String searchValue =
                    context.read<ListProjectCubit>().searchValue;
                ;
                if (state is ListProjectCubitIsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ListProjectCubitIsSuccess) {
                  listItem = state.projects;
                  totalPage = state.totalElement;
                } else if (state is ListProjectCubitLoadMore) {
                  loadMore = true;
                  listItem = state.projects;
                }
                return listItem.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: scrollController,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
                      )
                    : listItem.isEmpty && totalPage == 0 && searchValue.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              NoDataFoundWidget(
                                message:
                                    "Anda Belum Memiliki undangan  \n Segera buat undangan anda",
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              NoDataFoundWidget(
                                message: "Undangan Tidak ditemukan ",
                              ),
                            ],
                          );
              },
            ),
          ),
        ],
      ),
    );
  }
}
