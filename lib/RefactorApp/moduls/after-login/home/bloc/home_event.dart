part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class BottomnavItemSelected extends HomeEvent {
  final int index;

  BottomnavItemSelected(this.index);
}
