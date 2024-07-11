import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'listproject_event.dart';
part 'listproject_state.dart';

class ListprojectBloc extends Bloc<ListprojectEvent, ListprojectState> {
  ListprojectBloc() : super(ListprojectInitial()) {
    on<ListprojectEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
