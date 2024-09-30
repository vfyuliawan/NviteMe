part of 'create_preset_cubit.dart';

@immutable
sealed class CreatePresetState {}

final class CreatePresetInitial extends CreatePresetState {
  final String initColor;

  CreatePresetInitial({this.initColor = "0xffFFFFFF"});
}

final class CreatePresetUpdated extends CreatePresetState {
  final ModelRequestCreateTheme requets;

  CreatePresetUpdated(this.requets);
}

final class UpdateIsDisable extends CreatePresetState {
  final bool value;

  UpdateIsDisable(this.value);
}

final class CreatePresetLoading extends CreatePresetState {}
