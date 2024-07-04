import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:nvite_me/RefactorApp/core/api.dart';

// Ensure Flutter is initialized for testing
void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Add this line

  test('Authentication API Test', () async {
    FetchInterface props = FetchInterface(
      path: "/api/v1/auth/authenticate",
      reqBody: {
        "username": "galang",
        "password": "password",
      },
    );
    http.Response response = await APIService.post(props);
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    expect(response.statusCode, 200);
    Map<String, dynamic> responseData = jsonDecode(response.body);
    expect(responseData.containsKey('token'), true);
  });
}
