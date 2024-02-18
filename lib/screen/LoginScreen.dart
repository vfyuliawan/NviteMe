// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/AuthController.dart';
import 'package:nvite_me/widgets/FormTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Opacity(
              opacity: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset("assets/images/loginFloral4.jpg",
                    fit: BoxFit.cover),
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
              top: 200,
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
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                          fontSize: 32,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          FormTextField(
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
                            obscureText: true,
                            initialValue: password,
                            labelText: "Password",
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            enable: true,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Constans.secondaryColor),
                              onPressed: () async {
                                await AuthController()
                                    .signIn(context, email, password);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_to_home_screen_outlined,
                                        color: Colors.white),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
