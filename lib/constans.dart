// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class Constans {
  static final theme = _Theme();
  static final routeMenu = RouteMenu();
  static var primaryColor = Color(0xff296e48);
  static var secondaryColor = Color(0xff3A8891);
  static var thirdColor = Color(0xffEBD9B4);
  static var fourthColor = Color(0xffFBF9F1);
  static var fivethColor = Color(0xffd2c1b9);
  static var sixth = Color(0xffe3b480);
  // static var seventh = Color(0xff265073);
  static var seventh = Color(0xff3A8891);
  static var eight = Color.fromARGB(255, 239, 239, 239);
  static var nine = Color.fromARGB(255, 240, 240, 240);
  static var textColor = const Color(0xff3C3633);
  static var textColor2 = Color.fromARGB(255, 88, 75, 70);
  static var alertColor = Color.fromARGB(255, 252, 239, 214);
  static var redEssence = Color.fromARGB(255, 117, 7, 7);
  static var bluePremium = Color(0xff101f32);
  static var luxuryGreen = Color(0xff758673);
  static var luxuryCream = Color(0xffEBD9B4);
  static var luxuryPink = Color(0xffDBC4CA);

  static var baseUrlDev = 'localhost:3000/?a=';
  static var version = "V.0.0.1";
  static var baseUrlDeploy =
      'https://your-wedding-day-git-main-vfyuliawans-projects.vercel.app/?a=';

  static List<String> listDebitCard = [
    "ImageBca",
    "ImageBri",
    "ImageOvo",
  ];
  static List<String> listTheme = [
    "RedEssence",
    "BluePremium",
    "LuxuryCream",
    "LuxuryGreen",
    "LuxuryPink",
    "GreenFloral",
    "DarkGreenFloral",
    "BlueFloral",
    "BluePastel",
    "BlueAnimatedFloral",
    "CoklatAnimatedFloral",
    "JavaStyle1"
    // "BlackPasta"
    // "BlackPasta"
    // "BlackPasta"
  ];

  static List<String> listThemeSong = [
    "Payung-Teduh-Akad",
    "Komang-Raim-Laode",
    "Pamungkas-To-The-Bone",
    "Merry-Your-Daughter",
    "Thousand-Years",
  ];

  static var uidLogin = "uidLogin";
  static var bearerToken = "bearerToken";
  static var displayName = "displayName";
  static var unauthorize = "Unauthorize";
}

class _Theme {
  final String redEssence = "RedEssence";
  final String bluePremium = "BluePremium";
  final String luxuryCream = "LuxuryCream";
  final String luxuryGreen = "LuxuryGreen";
  final String luxuryPink = "LuxuryPink";
}

class RouteMenu {
  final String createPreset = "createPreset";
  final String createUndangan = "createUndangan";
  final String listcontact = "listcontact";
  final String listUser = "listUser";
  final String listRsvp = "listRsvp";
  final String listMessage = "listMessage";
}
