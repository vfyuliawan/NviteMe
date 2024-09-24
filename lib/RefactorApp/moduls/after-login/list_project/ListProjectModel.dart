// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';

class ListProjectModel {
  final ResultProjectSample result;
  final bool isToggleOpen;
  final String titleSearch;
  final bool hasMoreData;
  final bool loadMore;

  ListProjectModel(this.result, this.isToggleOpen, this.titleSearch,
      this.hasMoreData, this.loadMore);

  ListProjectModel copyWith({
    ResultProjectSample? result,
    bool? isToggleOpen,
    String? titleSearch,
    bool? hasMoreData,
    bool? loadMore,
  }) {
    return ListProjectModel(
      result ?? this.result,
      isToggleOpen ?? this.isToggleOpen,
      titleSearch ?? this.titleSearch,
      hasMoreData ?? this.hasMoreData,
      loadMore ?? this.loadMore,
    );
  }
}
