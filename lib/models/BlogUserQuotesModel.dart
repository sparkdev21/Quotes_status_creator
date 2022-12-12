// To parse this JSON data, do
//
//     final userQuotesBlog = userQuotesBlogFromJson(jsonString);

import 'dart:convert';

List<UserQuotesBlogModel> userQuotesBlogFromJson(String str) =>
    List<UserQuotesBlogModel>.from(
        json.decode(str).map((x) => UserQuotesBlogModel.fromJson(x)));

String userQuotesBlogToJson(List<UserQuotesBlogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserQuotesBlogModel {
  UserQuotesBlogModel({
    required this.userid,
    required this.quote,
    required this.featured,
    required this.status,
  });

  String userid;
  String quote;
  int featured;
  String status;

  factory UserQuotesBlogModel.fromJson(Map<String, dynamic> json) =>
      UserQuotesBlogModel(
        userid: json["userid"] == null ? null : json["userid"],
        quote: json["quote"] == null ? null : json["quote"],
        featured: json["featured"] == null ? null : json["featured"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid == null ? null : userid,
        "quote": quote == null ? null : quote,
        "featured": featured == null ? null : featured,
        "status": status == null ? null : status,
      };
}
