// To parse this JSON data, do
//
//     final userQuotes = userQuotesFromJson(jsonString);

import 'dart:convert';

UserQuotes userQuotesFromJson(String str) =>
    UserQuotes.fromJson(json.decode(str));

String userQuotesToJson(UserQuotes data) => json.encode(data.toJson());

class UserQuotes {
  UserQuotes({
    required this.quote,
    required this.status,
    required this.user,
    required this.featured,
  });

  String quote;
  double status;
  String user;
  double featured;

  factory UserQuotes.fromJson(Map<String, dynamic> json) => UserQuotes(
        quote: json["quote"],
        status: json["status"],
        user: json["user"],
        featured: json["featured"],
      );

  Map<String, dynamic> toJson() => {
        "quote": quote,
        "status": status,
        "user": user,
        "featured": featured,
      };
}
