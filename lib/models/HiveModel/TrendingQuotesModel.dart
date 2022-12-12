// To parse this JSON data, do
//
//     final trendingQuotes = trendingQuotesFromJson(jsonString);

import 'dart:convert';

List<TrendingQuotesModel> trendingQuotesFromJson(String str) => List<TrendingQuotesModel>.from(json.decode(str).map((x) => TrendingQuotesModel.fromJson(x)));

String trendingQuotesToJson(List<TrendingQuotesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrendingQuotesModel {
    TrendingQuotesModel({
        this.id,
        this.quote,
        this.category,
        this.author,
    });

    int? id;
    String? quote;
    String? category;
    String? author;

    factory TrendingQuotesModel.fromJson(Map<String, dynamic> json) => TrendingQuotesModel(
        id: json["id"] == null ? null : json["id"],
        quote: json["quote"] == null ? null : json["quote"],
        category: json["category"] == null ? null : json["category"],
        author: json["author"] == null ? null : json["author"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "quote": quote == null ? null : quote,
        "category": category == null ? null : category,
        "author": author == null ? null : author,
    };
}
