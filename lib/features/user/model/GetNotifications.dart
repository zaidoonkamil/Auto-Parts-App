import 'dart:convert';

import '../../../core/localization/locale_value.dart';

GetNotifications getNotificationsFromJson(String str) => GetNotifications.fromJson(json.decode(str));

String getNotificationsToJson(GetNotifications data) => json.encode(data.toJson());

class GetNotifications {
  int total;
  int page;
  int totalPages;
  List<Log> logs;

  GetNotifications({
    required this.total,
    required this.page,
    required this.totalPages,
    required this.logs,
  });

  factory GetNotifications.fromJson(Map<String, dynamic> json) => GetNotifications(
    total: json["total"],
    page: json["page"],
    totalPages: json["totalPages"],
    logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "totalPages": totalPages,
    "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
  };
}

class Log {
  int id;
  int? userId;
  String title;
  String message;
  String? titleAr;
  String? titleCkb;
  String? messageAr;
  String? messageCkb;
  String targetType;
  String targetValue;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Log({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    this.titleAr,
    this.titleCkb,
    this.messageAr,
    this.messageCkb,
    required this.targetType,
    required this.targetValue,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  static int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static String _asString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static DateTime _asDate(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
    return DateTime.now();
  }

  factory Log.fromJson(Map<String, dynamic> json) => Log(
    id: _asInt(json["id"]),
    userId: json["user_id"] == null ? null : _asInt(json["user_id"]),
    title: _asString(json["title"]),
    message: _asString(json["message"]),
    titleAr: _asString(json["title_ar"]).isEmpty ? null : _asString(json["title_ar"]),
    titleCkb: _asString(json["title_ckb"]).isEmpty ? null : _asString(json["title_ckb"]),
    messageAr: _asString(json["message_ar"]).isEmpty ? null : _asString(json["message_ar"]),
    messageCkb: _asString(json["message_ckb"]).isEmpty
        ? null
        : _asString(json["message_ckb"]),
    targetType: _asString(json["target_type"]),
    targetValue: _asString(json["target_value"]),
    status: _asString(json["status"]),
    createdAt: _asDate(json["createdAt"]),
    updatedAt: _asDate(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "message": message,
    "title_ar": titleAr,
    "title_ckb": titleCkb,
    "message_ar": messageAr,
    "message_ckb": messageCkb,
    "target_type": targetType,
    "target_value": targetValue,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };

  String localizedTitle(String localeCode) => localizedValue(
    localeCode: localeCode,
    arabicValue: titleAr,
    kurdishValue: titleCkb,
    fallback: title,
  );

  String localizedMessage(String localeCode) => localizedValue(
    localeCode: localeCode,
    arabicValue: messageAr,
    kurdishValue: messageCkb,
    fallback: message,
  );
}
