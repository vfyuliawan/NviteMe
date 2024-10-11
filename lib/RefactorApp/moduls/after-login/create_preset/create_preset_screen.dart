// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nvite_me/RefactorApp/domain/model/request/theme_example/model_request_create_theme.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/create_preset/cubit/create_preset_cubit.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/IBodyRoundedWidget.dart';
import 'package:nvite_me/widgets/IImageBase64Component.dart';

class CreatePresetScreen extends StatelessWidget {
  const CreatePresetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IBodyRoundedWidget(
          widget: _content(context), bodyColor: Constans.fourthColor),
    );
  }

  Widget _content(BuildContext context) {
    final cubit = context.watch<CreatePresetCubit>();
    final currentState = cubit.state;
    final createParseCubit = context.read<CreatePresetCubit>();
    ModelRequestCreateTheme dataSubmit = ModelRequestCreateTheme(
        themeName: "", themeColor: "0xffff", bgImage: "", fgImage: "");
    bool loading = false;

    if (currentState is CreatePresetUpdated) {
      dataSubmit = currentState.requets;
    } else if (currentState is CreatePresetLoading) {
      return Center(
        child: CircularProgressIndicator(color: Constans.secondaryColor),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          FormTextField(
            topSpace: 4,
            initialValue: dataSubmit.themeName,
            onChanged: (value) {
              cubit.inputTheme(value);
            },
            labelText: "Theme Name",
            labelColor: Colors.black45,
            labelSize: 16,
            hintText: "Theme Name",
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: FormTextField(
                  topSpace: 4,
                  enable: false,
                  onChanged: (value) {},
                  labelText: "Primary Color",
                  labelColor: Colors.black45,
                  labelSize: 16,
                  hintText:
                      context.read<CreatePresetCubit>().dataSubmit.themeColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Column(
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  GestureDetector(
                    onTap: () async {
                      cubit.getClipboardText();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Constans.secondaryColor),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.paste,
                          color: Constans.fourthColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ColorPicker(
            pickerColor: Color(int.parse(dataSubmit.themeColor)),
            displayThumbColor: true,
            onColorChanged: (value) {
              cubit.doPickColor(value);
            },
          ),
          Container(
              height: 200,
              width: 200,
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Constans.secondaryColor, width: 2)),
              child: createParseCubit.dataSubmit.bgImage == ""
                  ? Image(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZABkNKmDUF6OtvxBMfdpmrByfc5ui2p0QvQ&s"))
                  : IImageBase64Component(
                      image: createParseCubit.dataSubmit.bgImage,
                      fit: BoxFit.cover)),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: FormTextField(
                  topSpace: 4,
                  enable: false,
                  onChanged: (value) {},
                  labelText: "Background Image",
                  labelColor: Colors.black45,
                  labelSize: 16,
                  hintText: createParseCubit.dataSubmit.bgImage,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Column(
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<CreatePresetCubit>().uploadBgImage();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Constans.secondaryColor),
                      child: Icon(
                        Icons.image,
                        color: Constans.fourthColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            width: 200,
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Constans.secondaryColor, width: 2)),
            child: createParseCubit.dataSubmit.fgImage == ""
                ? Image(
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZABkNKmDUF6OtvxBMfdpmrByfc5ui2p0QvQ&s"))
                : IImageBase64Component(
                    image: createParseCubit.dataSubmit.fgImage,
                    fit: BoxFit.cover),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: FormTextField(
                  topSpace: 4,
                  enable: false,
                  onChanged: (value) {},
                  labelText: "Foreground Image",
                  labelColor: Colors.black45,
                  labelSize: 16,
                  hintText: createParseCubit.dataSubmit.fgImage,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Column(
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<CreatePresetCubit>().uploadFgImage();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Constans.secondaryColor),
                      child: Icon(
                        Icons.image,
                        color: Constans.fourthColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: 250,
            margin: EdgeInsets.symmetric(horizontal: 0),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Constans.secondaryColor),
              onPressed: () async {
                context.read<CreatePresetCubit>().createPresetTheme(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.subdirectory_arrow_left, color: Colors.white),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
