import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_menu_event.dart';
part 'main_menu_state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  MainMenuBloc() : super(MainMenuInitial()) {
    on<MainMenuEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
