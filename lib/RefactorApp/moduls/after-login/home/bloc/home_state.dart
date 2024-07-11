part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeIsSuccess extends HomeState {
  final int selectedIndex;

  HomeIsSuccess(this.selectedIndex);
}

final class HomeIsFailed extends HomeState {
  final String message;

  HomeIsFailed(this.message);
}

final class HomeIsLoading extends HomeState {}
