// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/AuthController.dart';
import 'package:nvite_me/screen/RootPage.dart';
import 'package:nvite_me/utils/utils.dart';
import 'package:nvite_me/widgets/FormTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;

  late bool hidePassword = true;

  late bool isLoading = false;
  @override
  void initState() {
    email = "";
    password = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Constans.secondaryColor),
              child: Center(
                  child: CircularProgressIndicator(
                color: Constans.thirdColor,
              )),
            )
          : SingleChildScrollView(
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
                    top: 150,
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
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [
                                FormTextField(
                                  height: 50,
                                  labelText: "Email",
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                  initialValue: email,
                                  enable: true,
                                ),
                                FormTextField(
                                  height: 50,
                                  obscureText: hidePassword,
                                  initialValue: password,
                                  suffix: hidePassword
                                      ? GestureDetector(
                                          onTap: () => setState(() {
                                                hidePassword = !hidePassword;
                                              }),
                                          child: Icon(Icons.visibility))
                                      : GestureDetector(
                                          onTap: () => setState(() {
                                                hidePassword = !hidePassword;
                                              }),
                                          child: Icon(Icons.visibility_off)),
                                  labelText: "Password",
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  enable: true,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 0),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Constans.sixth),
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await AuthController()
                                          .signIn(context, email, password)
                                          .then((value) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                              Icons.add_to_home_screen_outlined,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'Login',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    UserCredential? userCredential =
                                        await AuthController()
                                            .signInWithGoogle();
                                    if (userCredential != null) {
                                      await Utility().savePref(
                                          Constans.uidLogin,
                                          userCredential.user!.uid);
                                      await Utility().savePref(
                                          Constans.displayName,
                                          userCredential.user!.displayName!);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      print(
                                          "Google Sign-In Successful: ${userCredential.user?.displayName}");
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => WillPopScope(
                                            onWillPop: () async {
                                              return false;
                                            },
                                            child: RootPage(),
                                          ),
                                        ),
                                      );
                                    }
                                    Future.delayed(Duration(seconds: 3), () {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/icons/google.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
