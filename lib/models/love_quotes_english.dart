// To parse this JSON data, do
//
//     final quotesModel = quotesModelFromJson(jsonString);

import 'dart:convert';

List<QuotesModel> quotesModelFromJson(String str) => List<QuotesModel>.from(
    json.decode(str).map((x) => QuotesModel.fromJson(x)));

String quotesModelToJson(List<QuotesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuotesModel {
  QuotesModel({
    this.image,
    this.content,
  });

  String? image;
  List<Content>? content;

  factory QuotesModel.fromJson(Map<String, dynamic> json) => QuotesModel(
      image: json["image"] == null ? null : json["image"],
      content: (json["content"] == null
          ? null
          : List<Content>.from(
              json["content"].map((x) => Content.fromJson(x)))));

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image,
        "content": content == null
            ? null
            : List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    required this.dislike,
    required this.like,
    required this.msg,
    required this.saved,
    required this.sid,
    required this.submit,
    required this.views,
  });

  dynamic dislike;
  dynamic like;
  String msg;
  String saved;
  int sid;
  String submit;
  int views;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        dislike: json["dislike"],
        like: json["like"],
        msg: json["msg"] == null ? null : json["msg"],
        saved: json["saved"] == null ? null : json["saved"],
        sid: json["sid"] == null ? null : json["sid"],
        submit: json["submit"] == null ? null : json["submit"],
        views: json["views"] == null ? null : json["views"],
      );

  Map<String, dynamic> toJson() => {
        "dislike": dislike,
        "like": like,
        "msg": msg == null ? null : msg,
        "saved": saved == null ? null : saved,
        "sid": sid == null ? null : sid,
        "submit": submit == null ? null : submit,
        "views": views == null ? null : views,
      };
}
