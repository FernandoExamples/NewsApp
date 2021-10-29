import 'package:http/http.dart' as http;
import 'package:news_app/src/models/article.dart';
import 'package:news_app/src/models/news.dart';

import '../keys.dart';

class NewsService {
  final _baseUrl = 'https://newsapi.org/v2';

  NewsService();

  Future<List<Article>> fetchTopHeadLines() async {
    final url = '$_baseUrl/top-headlines?apiKey=$NEWS_API_KEY&country=mx';
    final response = await http.get(url);

    final newsResponse = NewsResponse.fromJson(response.body);

    return newsResponse.articles;
  }

  Future<List<Article>> fetchArticlesByCategory(String category) async {
    final url = '$_baseUrl/top-headlines?apiKey=$NEWS_API_KEY&country=mx&category=$category';
    final response = await http.get(url);

    final newsResponse = NewsResponse.fromJson(response.body);
    return newsResponse.articles;
  }
}
