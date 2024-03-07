// ignore_for_file: unused_element, use_build_context_synchronously, sort_child_properties_last

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nvite_me/model/UserLoginModel.dart';
import 'package:nvite_me/screen/RootPage.dart';
import 'package:nvite_me/utils/utils.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> cekAuthenticationSignIn() async {
    Completer<bool> completer = Completer<bool>();
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        print("User tidak login");
        completer.complete(false);
      } else {
        print("User is signIn");
        completer.complete(true);
      }
    });
    return completer.future;
  }

  Future<bool> signIn(
      BuildContext context, String email, String password) async {
    Completer<bool> completer = Completer<bool>();

    try {
      UserCredential login = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Utility.logger.i("Success $login");
      completer.complete(true);

      if (login.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => RootPage(userInfo: login.user),
          ),
        );
      }
    } catch (e) {
      Utility().themeAlert(
        context: context,
        isError: true,
        title: "Gagal Login",
        subtitle: "Periksa Kembali Email dan Password",
        callback: () async {
          Navigator.pop(context);
        },
      );
      completer.complete(false);
      Utility.logger.e("message: $e");
    }
    return completer.future;
  }

  Future<bool> signOut() async {
    Completer<bool> completer = Completer<bool>();
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      completer.complete(true);
    } catch (e) {
      completer.complete(false);

      print("Error signing out: $e");
    }
    return completer.future;
  }

  Future<UserLoginModel> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Utility.logger.i("User ID: ${user.uid}");
      Utility.logger.i("Email: ${user.email}");
      Utility.logger.i("Display Name: ${user.displayName}");
      Utility.logger.i("Photo URL: ${user.photoURL}");

      // Return a UserLoginModel object with user information
      return UserLoginModel(uid: user.uid);
    } else {
      return UserLoginModel(uid: "");
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount == null) {
        // The user canceled the sign-in process
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }
}
