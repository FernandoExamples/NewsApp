import 'dart:convert';

import 'package:news_app/src/models/article.dart';

class NewsResponse {
  NewsResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory NewsResponse.fromJson(String str) => NewsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewsResponse.fromMap(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        totalResults: json["totalResults"] >= 100 ? 100 : json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toMap())),
      };
}
