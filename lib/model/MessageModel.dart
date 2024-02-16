// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  List<MessageKeyValue>? message;
  MessageModel({
    List<MessageKeyValue>? message,
  }) : message = message ?? [MessageKeyValue()];
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json['Message'] != null
            ? (json['Message'] as List<dynamic>)
                .map((x) => MessageKeyValue.fromJson(x as Map<String, dynamic>))
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        "Message": List<dynamic>.from(
          message!.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class MessageKeyValue {
  bool? confirm;
  Timestamp? date;
  String? name;
  String? text;
  MessageKeyValue({
    this.confirm = true,
    Timestamp? date,
    this.name = "inviteMe",
    this.text = "Congratulation",
  }) : date = date ?? Timestamp.now();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Confirm': confirm,
      'Date': date,
      'Name': name,
      'Text': text,
    };
  }

  factory MessageKeyValue.fromJson(Map<String, dynamic> json) {
    return MessageKeyValue(
      confirm: json['Confirm'] != null ? json['Confirm'] as bool : false,
      date: json['Date'] != null ? json["Date"] as Timestamp : Timestamp.now(),
      name: json['Name'] != null ? json['Name'] as String : "",
      text: json['Text'] != null ? json['Text'] as String : "",
    );
  }
}
