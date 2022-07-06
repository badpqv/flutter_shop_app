// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

List<Notification> notificationFromJson(String str) => List<Notification>.from(
    json.decode(str).map((x) => Notification.fromJson(x)));

String notificationToJson(List<Notification> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notification {
  const Notification({
    this.content = "",
    required this.time,
    this.id = "0",
  });

  final String content;
  final DateTime time;
  final String id;

  factory Notification.fromJson(dynamic json) => Notification(
        content: json["content"],
        time: json["time"],
        id: json["id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "time": time,
        "id": int.parse(id),
      };
}
