import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/article.dart';
import 'package:news_app/src/models/category.dart';
import 'package:news_app/src/models/news.dart';
import 'package:news_app/src/services/news_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService newsService;

  List<Article> headLines = [];
  String _categorySelected = 'business';
  Map<String, List<Article>> categoryArticles = {};

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, String> categoriesTraduction = {
    'business': 'Negocios',
    'entertainment': 'Ocio',
    'general': 'General',
    'health': 'Salud',
    'science': 'Ciencia',
    'sports': 'Deportes',
    'technology': 'Tecnología',
  };

  String get categorySelected => _categorySelected;

  set categorySelected(String cat) {
    _categorySelected = cat;
    notifyListeners();
  }

  NewsProvider({@required this.newsService}) {
    categories.forEach((item) {
      this.categoryArticles[item.name] = [];
    });
    newsService.fetchTopHeadLines().then((articles) {
      headLines.addAll(articles);
      notifyListeners();
    }).catchError((error) => print(error));
  }

  List<Article> getCategorySelectedArticles() {
    if (categoryArticles[categorySelected].length > 0) return categoryArticles[categorySelected];

    newsService.fetchArticlesByCategory(categorySelected).then((articles) {
      this.categoryArticles[categorySelected].addAll(articles);
      notifyListeners();
    }).catchError((error) => print(error));

    return categoryArticles[categorySelected];
  }
}
