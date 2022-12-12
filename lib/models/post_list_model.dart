// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  String? kind;
  List<Items>? items;
  String? etag;

  PostModel({this.kind, this.items, this.etag});

  PostModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    etag = json['etag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['etag'] = this.etag;
    return data;
  }
}

class Items {
  String? kind;
  String? id;
  Blog? blog;
  String? published;
  String? updated;
  String? url;
  String? selfLink;
  String? title;
  String? content;
  Author? author;
  Replies? replies;
  String? etag;

  Items(
      {this.kind,
      this.id,
      this.blog,
      this.published,
      this.updated,
      this.url,
      this.selfLink,
      this.title,
      this.content,
      this.author,
      this.replies,
      this.etag});

  Items.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    id = json['id'];
    blog = json['blog'] != null ? new Blog.fromJson(json['blog']) : null;
    published = json['published'];
    updated = json['updated'];
    url = json['url'];
    selfLink = json['selfLink'];
    title = json['title'];
    content = json['content'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    replies =
        json['replies'] != null ? new Replies.fromJson(json['replies']) : null;
    etag = json['etag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['id'] = this.id;
    if (this.blog != null) {
      data['blog'] = this.blog!.toJson();
    }
    data['published'] = this.published;
    data['updated'] = this.updated;
    data['url'] = this.url;
    data['selfLink'] = this.selfLink;
    data['title'] = this.title;
    data['content'] = this.content;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    if (this.replies != null) {
      data['replies'] = this.replies!.toJson();
    }
    data['etag'] = this.etag;
    return data;
  }
}

class Blog {
  String? id;

  Blog({this.id});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Author {
  String? id;
  String? displayName;
  String? url;
  Image? image;

  Author({this.id, this.displayName, this.url, this.image});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    url = json['url'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['url'] = this.url;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class Image {
  String? url;

  Image({this.url});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class Replies {
  String? totalItems;
  String? selfLink;

  Replies({this.totalItems, this.selfLink});

  Replies.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    selfLink = json['selfLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['selfLink'] = this.selfLink;
    return data;
  }
}
