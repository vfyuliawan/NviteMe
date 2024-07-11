// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nvite_me/RefactorApp/moduls/pre-login/login/bloc/login_bloc.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/widgets/FormTextField.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginIsSuccess) {
              context.go("/home");
            } else if (state is LoginIsFailed) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                  backgroundColor: Constans.sixth));
            }
          },
          builder: (context, state) {
            if (state is LoginFormState) {
              _emailController.text = state.loginForm.username;
              _passwordController.text = state.loginForm.password;
              bool hidePassword = !state.loginForm.isPasswordVisible;
              bool isDisableButton = state.loginForm.isDisableButton;

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Image.asset(
                          "assets/images/loginFloral4.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.6,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Constans.secondaryColor,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                textAlign: TextAlign.center,
                                "Make Your Weddinig Digitalize",
                                style: TextStyle(
                                  color: Constans.sixth,
                                  fontFamily: 'Pacifico',
                                  fontSize: 32,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AspectRatio(
                              aspectRatio: 3,
                              child: Image.asset(
                                "assets/icons/nmlogo2.png",
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                        MediaQuery.of(context).size.width /
                                            1.5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12, // Shadow color
                                    offset: Offset(0,
                                        1), // Offset in the x and y direction
                                    blurRadius: 6, // Amount of blur
                                    spreadRadius: 15, // Amount of spread
                                  ),
                                ],
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Column(children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "Welcome",
                                  style: TextStyle(
                                      color: Constans.secondaryColor,
                                      fontSize: 24,
                                      fontFamily: "Pacifico"),
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                                FormTextField(
                                  height: 50,
                                  labelText: "Email",
                                  valueColor: Constans.secondaryColor,
                                  labelColor: Constans.sixth,
                                  labelSize: 18,
                                  onChanged: (value) {
                                    final loginForm = state.loginForm
                                        .copyWith(username: value);
                                    context
                                        .read<LoginBloc>()
                                        .add(FormChange(loginForm: loginForm));
                                  },
                                  initialValue: state.loginForm.username,
                                  enable: true,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FormTextField(
                                  height: 50,
                                  labelSize: 18,
                                  valueColor: Constans.secondaryColor,
                                  obscureText: !hidePassword,
                                  labelColor: Constans.sixth,
                                  initialValue: state.loginForm.password,
                                  suffix: GestureDetector(
                                    onTap: () {
                                      final loginForm =
                                          state.loginForm.copyWith(
                                        isPasswordVisible:
                                            !state.loginForm.isPasswordVisible,
                                      );
                                      context.read<LoginBloc>().add(
                                          FormChange(loginForm: loginForm));
                                    },
                                    child: Icon(
                                        color: Constans.secondaryColor,
                                        hidePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                  ),
                                  labelText: "Password",
                                  onChanged: (value) {
                                    final loginForm = state.loginForm
                                        .copyWith(password: value);
                                    context
                                        .read<LoginBloc>()
                                        .add(FormChange(loginForm: loginForm));
                                  },
                                  enable: true,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (isDisableButton) {
                                      context
                                          .read<LoginBloc>()
                                          .add(LoginSubmitted());
                                    }
                                  },
                                  child: Container(
                                    // ignore: sort_child_properties_last
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: 'Pacifico',
                                          fontSize: 25,
                                          color: !isDisableButton
                                              ? Colors.white30
                                              : Constans.secondaryColor),
                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: !isDisableButton
                                            ? Colors.grey
                                            : Constans.sixth),
                                    width: 180,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "V.0.0.1",
                                  style: TextStyle(fontFamily: "Pacifico"),
                                )
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is LoginIsLoading) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
