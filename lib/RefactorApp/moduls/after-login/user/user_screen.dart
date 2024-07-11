// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nvite_me/RefactorApp/domain/model/general/props_key_value.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/user/bloc/user_bloc.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';
import 'package:nvite_me/RefactorApp/widget/props_key_value_widget.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/widgets/FormTextField.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserIsFailed) {
            Utilities().showMessage(message: state.message);
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              context.read<UserBloc>().add(GetUserDetail());
              return Center(
                child: Text("init State"),
              );
            } else if (state is UserIsSuccess) {
              List<PropsKeyValue> userDetail = [
                PropsKeyValue(key: "Name", value: state.detailUser.name),
                PropsKeyValue(
                    key: "Username", value: state.detailUser.username),
                PropsKeyValue(key: "Email", value: state.detailUser.email),
                PropsKeyValue(key: "Alamat", value: state.detailUser.alamat),
              ];
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Constans.seventh,
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/icons/bg.png",
                          ),
                          fit: BoxFit.cover,
                          opacity: 0.4),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              "Welcome ${state.detailUser.name}",
                              style: TextStyle(
                                fontFamily: "Pacifico",
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    right: 0,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Constans.nine,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 150,
                            width: 150,
                            alignment: Alignment.center,
                            child: Text(
                              state.detailUser.username
                                  .split("")[0]
                                  .toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pacifico",
                                fontSize: 70,
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Constans.textColor2,
                                borderRadius: BorderRadius.circular(150 / 2)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PropsKeyValueWidget(data: userDetail),
                          SizedBox(
                            height: 20,
                          ),
                          UserActionButton(
                            iconData: Icons.edit_note_rounded,
                            ontap: () {
                              context.read<UserBloc>().add(EditUser());
                            },
                            title: "Edited Data",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          UserActionButton(
                            iconData: Icons.logout_rounded,
                            ontap: () {
                              context.read<UserBloc>().add(LogoutUser(context));
                            },
                            title: "Logout",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is UserIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserIsEdited) {
              List<PropsKeyValue> userDetail = [
                PropsKeyValue(key: "Name", value: state.detailUser.name),
                PropsKeyValue(
                    key: "Username", value: state.detailUser.username),
                PropsKeyValue(key: "Email", value: state.detailUser.email),
                PropsKeyValue(key: "Alamat", value: state.detailUser.alamat),
              ];
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Constans.seventh,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/icons/bg.png",
                            ),
                            fit: BoxFit.cover,
                            opacity: 0.4,
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  "Welcome ${state.detailUser.name}",
                                  style: TextStyle(
                                    fontFamily: "Pacifico",
                                    fontSize: 23,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 90,
                        right: 0,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight - 90,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Constans.nine,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.manual,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 150,
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    state.detailUser.username
                                        .split("")[0]
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Pacifico",
                                      fontSize: 70,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Constans.textColor2,
                                      borderRadius:
                                          BorderRadius.circular(150 / 2)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                      children: userDetail.map((item) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FormTextField(
                                          height: 60,
                                          labelText: item.key,
                                          valueColor: Constans.textColor,
                                          labelColor: Constans.textColor,
                                          labelSize: 14,
                                          borderColor: Constans.seventh,
                                          line: 1,
                                          onChanged: (value) {
                                            if (item.key == "Username") {
                                              final updateForm = state
                                                  .detailUser
                                                  .copyWith(username: value);
                                              context
                                                  .read<UserBloc>()
                                                  .add(UpdatedForm(updateForm));
                                            }
                                            if (item.key == "Name") {
                                              final updateForm = state
                                                  .detailUser
                                                  .copyWith(name: value);
                                              context
                                                  .read<UserBloc>()
                                                  .add(UpdatedForm(updateForm));
                                            }
                                            if (item.key == "Email") {
                                              final updateForm = state
                                                  .detailUser
                                                  .copyWith(email: value);
                                              context
                                                  .read<UserBloc>()
                                                  .add(UpdatedForm(updateForm));
                                            }
                                            if (item.key == "Alamat") {
                                              final updateForm = state
                                                  .detailUser
                                                  .copyWith(alamat: value);
                                              context
                                                  .read<UserBloc>()
                                                  .add(UpdatedForm(updateForm));
                                            }
                                          },
                                          initialValue: item.value,
                                          enable: item.key != "Username",
                                        ),
                                      ],
                                    );
                                  }).toList()),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                UserActionButton(
                                  iconData: Icons.save,
                                  ontap: () {
                                    context
                                        .read<UserBloc>()
                                        .add(OnSubmitUpdate());
                                  },
                                  title: "Save Data",
                                ),
                                SizedBox(
                                  height: 150,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  GestureDetector UserActionButton(
      {required String title,
      required IconData? iconData,
      required Function ontap}) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: Constans.textColor,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 65,
              child: Icon(
                iconData,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Roboto-Medium",
              ),
            ))
          ],
        ),
      ),
    );
  }
}
