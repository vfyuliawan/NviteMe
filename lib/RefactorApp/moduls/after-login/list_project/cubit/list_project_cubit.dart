import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/projects/model_request_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:nvite_me/RefactorApp/domain/service/projects/projects_service.dart';
import 'package:nvite_me/RefactorApp/utility/Debouncer.dart';

part 'list_project_state.dart';

class ListProjectCubit extends Cubit<ListProjectCubitState> {
  List<ListProject> listProjects = [];
  final int pageSize = 5;
  int currentPage = 0;
  bool hasMoreData = true;
  String searchValue = "";
  bool searchBar = false;
  final _debouncer = Debouncer(milliseconds: 900);

  ListProjectCubit() : super(ListProjectInitial());

  void onSearch(String valueSearch) {
    _debouncer.run(() {
      getProject(valueSearch);
      print("debounce " + valueSearch);
    });
  }

  void toggleSearch(bool searchBarValue) {
    searchBar = searchBarValue;
    emit(ListProjectCubitIsSuccess(
        listProjects, pageSize, hasMoreData, searchBar));
  }

  Future<void> getProject(String valueSearch) async {
    print("valueSearch " + valueSearch);
    emit(ListProjectCubitIsLoading(searchBar));
    currentPage = 0;
    hasMoreData = true;
    listProjects.clear();
    searchValue = valueSearch;

    try {
      final fetchData = await fetchProject(searchValue, currentPage);
      listProjects = fetchData!.result.projects;
      hasMoreData = listProjects.length == pageSize;
      emit(ListProjectCubitIsSuccess(listProjects,
          fetchData.result.paging.totalPage, hasMoreData, searchBar));
    } catch (e) {
      emit(ListProjectCubitIsFailed(e.toString()));
    }
  }

  Future<void> loadMoreItems(String query) async {
    emit(ListProjectCubitLoadMore(listProjects, searchBar));
    currentPage++;
    try {
      final result = await fetchProject(searchValue, currentPage);
      hasMoreData = result!.result.projects.length == pageSize;
      listProjects.addAll(result.result.projects);
      emit(ListProjectCubitIsSuccess(listProjects,
          result.result.paging.totalPage, hasMoreData, searchBar));
    } catch (error) {
      emit(ListProjectCubitIsFailed(error.toString()));
    }
  }

  Future<ModelResponseGetProject?> fetchProject(String title, int page) async {
    ModelRequestProjectSample params = ModelRequestProjectSample(
        currentPage: page, size: pageSize, title: title);
    final result = await ProjectService().getMyProject(params);
    return result;
  }
}
