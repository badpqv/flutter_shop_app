// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<AppNotification> notificationFromJson(String str) =>
    List<AppNotification>.from(
        json.decode(str).map((x) => AppNotification.fromJson(x)));

String notificationToJson(List<AppNotification> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppNotification extends Equatable {
  const AppNotification({
    this.content = "",
    required this.time,
    this.id = "0",
    this.isSeen = false,
    this.productId = "0",
  });

  final String content;
  final DateTime time;
  final String id;
  final String productId;
  final bool isSeen;
  factory AppNotification.fromJson(dynamic json) => AppNotification(
        content: json["content"],
        time: json["time"],
        id: json["id"].toString(),
        isSeen: json["isSeen"],
        productId: json["productId"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "time": time,
        "id": int.parse(id),
        "productId": int.parse(productId),
        "isSeen": isSeen,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [content, time, id, isSeen];
}
