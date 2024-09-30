// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/theme_example/model_request_create_theme.dart';
import 'package:nvite_me/RefactorApp/domain/service/theme_example_service/theme_example_service.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';

part 'create_preset_state.dart';

class CreatePresetCubit extends Cubit<CreatePresetState> {
  bool isDisable = true;
  ModelRequestCreateTheme dataSubmit = ModelRequestCreateTheme(
      themeName: "", themeColor: "0xffff", bgImage: "", fgImage: "");
  CreatePresetCubit() : super(CreatePresetInitial());

  void doPickColor(Color color) {
    String colorString = '0x${color.value.toRadixString(16).toUpperCase()}';
    dataSubmit = dataSubmit.copyWith(themeColor: colorString);
    emit(
      CreatePresetUpdated(
        dataSubmit,
      ),
    );
  }

  void getClipboardText() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    String? clipboardText = clipboardData?.text;
    dataSubmit = dataSubmit.copyWith(themeColor: clipboardText);
    if (clipboardText!.contains("0x")) {
      emit(
        CreatePresetUpdated(
          dataSubmit,
        ),
      );
    } else {
      Utilities().showMessage(message: "Text bukan Warna");
    }
  }

  void inputTheme(String val) {
    dataSubmit = dataSubmit.copyWith(themeName: val);
    emit(CreatePresetUpdated(dataSubmit));
  }

  void uploadBgImage() async {
    await Utilities().pickedImage().then((value) {
      if (value != null) {
        dataSubmit = dataSubmit.copyWith(bgImage: value);
        emit(CreatePresetUpdated(dataSubmit));
      }
    });
  }

  void uploadFgImage() async {
    await Utilities().pickedImage().then((value) {
      if (value != null) {
        dataSubmit = dataSubmit.copyWith(fgImage: value);
        emit(CreatePresetUpdated(dataSubmit));
      }
    });
  }

  void createPresetTheme(BuildContext context) async {
    emit(CreatePresetLoading());
    final chceck = Utilities().validateFields(dataSubmit.toJson());
    if (chceck) {
      final res = await ThemeExampleService().createTheme(dataSubmit);
      if (res != null || res?.result != null) {
        context.go("/home/listTemplate");
        Utilities().showMessage(message: "Berhasil input tema baru");
      }
    } else {
      Utilities().showMessage(message: "form tidak boleh kosong");
      emit(CreatePresetUpdated(dataSubmit));
    }
  }
}
