// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:nvite_me/RefactorApp/core/api.dart';

// import 'package:nvite_me/main.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   testWidgets('Authentication API Test', (WidgetTester tester) async {
//     await tester.pumpWidget(MyAppRefactor());
//     FetchInterface props = FetchInterface(
//       path: "/api/v1/auth/authenticate",
//       reqBody: {
//         "username": "galang",
//         "password": "password",
//       },
//     );
//     http.Response response = await APIService.post(props);
//     print('Response Status Code: ${response.statusCode}');
//     print('Response Body: ${response.body}');

//     expect(response.statusCode, 200);
//     Map<String, dynamic> responseData = jsonDecode(response.body);
//     expect(responseData.containsKey('token'), true);
//   });
// }
