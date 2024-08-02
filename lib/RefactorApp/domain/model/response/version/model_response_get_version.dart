import 'dart:convert';

class ModelVersionResponse {
  String code;
  String message;
  dynamic messageError;
  Result result;

  ModelVersionResponse({
    required this.code,
    required this.message,
    required this.messageError,
    required this.result,
  });

  factory ModelVersionResponse.fromRawJson(String str) =>
      ModelVersionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelVersionResponse.fromJson(Map<String, dynamic> json) =>
      ModelVersionResponse(
        code: json["code"],
        message: json["message"],
        messageError: json["messageError"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "messageError": messageError,
        "result": result.toJson(),
      };
}

class Result {
  String versionId;
  String currentVersion;

  Result({
    required this.versionId,
    required this.currentVersion,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        versionId: json["versionId"],
        currentVersion: json["currentVersion"],
      );

  Map<String, dynamic> toJson() => {
        "versionId": versionId,
        "currentVersion": currentVersion,
      };
}
