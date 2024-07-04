// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:nvite_me/RefactorApp/core/ErrorHandler.dart';
import 'package:platform/platform.dart';

class APIService {
  static int timeOut = 60000;
  static String baseUrl = "http://localhost:8080";
  static String iosVersion = "0.0.1";
  static String androidVersion = "0.0.1";

  static appVersion(Platform platform) {
    return platform.isIOS ? iosVersion : androidVersion;
  }

  static Future<Map<String, String>> header() async {
    const String token = "fasdfasdfasdfasdfasdf";
    final String appVersionData = appVersion(LocalPlatform());
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
    String deviceId, osVersion, model, brand;

    if (LocalPlatform().isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? "";
      osVersion = iosInfo.systemVersion;
      model = iosInfo.model;
      brand = 'Apple';
    } else {
      deviceId = androidInfo.id;
      osVersion = androidInfo.version.release;
      model = androidInfo.model;
      brand = androidInfo.brand;
    }

    return {
      'Content-Type': 'application/json',
      'accept': '*/*',
      'channel': 'MOB',
      'device-id': deviceId,
      'device-os': LocalPlatform().isIOS ? 'ios' : 'android',
      'device-model': model,
      'device-brand': brand,
      'app-version': appVersionData,
      'os-version': osVersion,
      'language': 'IDN',
      'latitude': '0.0',
      'longitude': '0.0',
      'Authorization': token,
    };
  }

  static Future<http.Response> requestData(
    http.Request request,
    bool isErrorCreate,
    Function? errorMessage,
    bool? dismissable,
  ) async {
    try {
      final response = await http.Response.fromStream(await request.send());
      if (kDebugMode) {
        print('METHOD : ${request.method}');
        print('URL : ${request.url}');
        print('REQUEST HEADER : ${request.headers}');
        print('REQUEST BODY : ${request.body}');
        print('RESPONSE STATUS : ${response.statusCode}');
        print('RESPONSE HEADER : ${response.headers}');
        print('RESPONSE BODY : ${response.body}');
      }

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['code'] == '00' ||
            responseData['code'] == '4301' ||
            responseData['code'] == '5101') {
          return response;
        }
      } else if (response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 303) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"] ?? "",
            title: "Error");
      } else if (response.statusCode == 400) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"] ?? "",
            title: "Error");
      } else if (response.statusCode == 401) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"] ?? "",
            title: "Error");
      } else if (response.statusCode == 403) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"] ?? "",
            title: "Error");
      } else if (response.statusCode == 404 ||
          response.statusCode == 413 ||
          response.statusCode == 422 ||
          response.statusCode == 409) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"],
            title: "Error");
      } else if (response.statusCode == 500) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"],
            title: "Error");
      }
      return response;
    } catch (e) {
      errorHandler.errorResponse(
          message: "",
          dismissable: dismissable,
          errorMessage: e.toString(),
          title: "Error");
      print('Error request: $e');
      return http.Response('Error: $e', 500);
    }
  }

  static Future<http.Response> post(FetchInterface props) async {
    final headers = await header();
    final request = http.Request('POST', Uri.parse(baseUrl + props.path))
      ..headers.addAll(headers)
      ..body = json.encode(props.reqBody);
    return requestData(request, props.isErrorCreate ?? false,
        props.errorMessage, props.dismissable);
  }

  Future<http.Response> get(FetchInterfaceGet props) async {
    final headers = await header();
    final request = http.Request('GET', Uri.parse(baseUrl + props.path))
      ..headers.addAll(headers)
      ..bodyFields =
          props.params?.map((key, value) => MapEntry(key, value.toString())) ??
              {};
    return requestData(request, props.isError ?? false, null, null);
  }

  Future<http.Response> put(FetchInterface props) async {
    final headers = await header();
    final request = http.Request('PUT', Uri.parse(baseUrl + props.path))
      ..headers.addAll(headers)
      ..body = json.encode(props.reqBody);
    return requestData(
        request, props.isErrorCreate ?? false, null, props.dismissable);
  }

  Future<http.Response> patch(FetchInterface props) async {
    final headers = await header();
    final request = http.Request('PATCH', Uri.parse(baseUrl + props.path))
      ..headers.addAll(headers)
      ..body = json.encode(props.reqBody);
    return requestData(
        request, props.isErrorCreate ?? false, null, props.dismissable);
  }

  Future<http.Response> deleted(FetchInterface props) async {
    final headers = await header();
    final request = http.Request('DELETE', Uri.parse(baseUrl + props.path))
      ..headers.addAll(headers)
      ..body = json.encode(props.reqBody);
    return requestData(
        request, props.isErrorCreate ?? false, null, props.dismissable);
  }
}

class FetchInterface {
  final String path;
  final bool? isErrorCreate;
  final bool? dismissable;
  final Map<String, dynamic> reqBody;
  final Function? errorMessage;

  FetchInterface({
    required this.path,
    this.isErrorCreate,
    this.dismissable,
    required this.reqBody,
    this.errorMessage,
  });
}

class FetchInterfaceGet {
  final String path;
  final Map<String, dynamic>? params;
  final bool? isError;

  FetchInterfaceGet({required this.path, this.params, this.isError});
}
