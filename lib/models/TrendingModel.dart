// To parse this JSON data, do
//
//     final trendingModel = trendingModelFromJson(jsonString);

import 'dart:convert';

TrendingModel trendingModelFromJson(String str) =>
    TrendingModel.fromJson(json.decode(str));

String trendingModelToJson(TrendingModel data) => json.encode(data.toJson());

class TrendingModel {
  TrendingModel({
    this.kind,
    this.id,
    this.blog,
    this.published,
    this.updated,
    this.url,
    this.selfLink,
    this.title,
    this.content,
    this.author,
  });

  String? kind;
  String? id;
  Blog? blog;
  DateTime? published;
  DateTime? updated;
  String? url;
  String? selfLink;
  String? title;
  String? content;
  Author? author;

  factory TrendingModel.fromJson(Map<String, dynamic> json) => TrendingModel(
        kind: json["kind"] == null ? null : json["kind"],
        id: json["id"] == null ? null : json["id"],
        blog: (json["blog"] == null ? null : Blog.fromJson(json["blog"]))!,
        published: (json["published"] == null
            ? null
            : DateTime.parse(json["published"]))!,
        updated:
            (json["updated"] == null ? null : DateTime.parse(json["updated"]))!,
        url: json["url"] == null ? null : json["url"],
        selfLink: json["selfLink"] == null ? null : json["selfLink"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        author:
            (json["author"] == null ? null : Author.fromJson(json["author"]))!,
      );

  Map<String, dynamic> toJson() => {
        "kind": kind == null ? null : kind,
        "id": id == null ? null : id,
        "blog": blog == null ? null : blog!.toJson(),
        "published": published == null ? null : published!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "url": url == null ? null : url,
        "selfLink": selfLink == null ? null : selfLink,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
        "author": author == null ? null : author!.toJson(),
      };
}

class Author {
  Author({
    required this.id,
    required this.displayName,
    required this.url,
    required this.image,
  });

  String id;
  String displayName;
  String url;
  Image image;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"] == null ? null : json["id"],
        displayName: json["displayName"] == null ? null : json["displayName"],
        url: json["url"] == null ? null : json["url"],
        image: (json["image"] == null ? null : Image.fromJson(json["image"]))!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "displayName": displayName == null ? null : displayName,
        "url": url == null ? null : url,
        "image": image == null ? null : image.toJson(),
      };
}

class Image {
  Image({
    required this.url,
  });

  String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
      };
}

class Blog {
  Blog({
    required this.id,
  });

  String id;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
      };
}

class Replies {
  Replies({
    required this.totalItems,
    required this.selfLink,
  });

  String totalItems;
  String selfLink;

  factory Replies.fromJson(Map<String, dynamic> json) => Replies(
        totalItems: json["totalItems"] == null ? null : json["totalItems"],
        selfLink: json["selfLink"] == null ? null : json["selfLink"],
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems == null ? null : totalItems,
        "selfLink": selfLink == null ? null : selfLink,
      };
}
