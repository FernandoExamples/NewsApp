import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_model.dart';

import '../keys.dart';

class NewsService with ChangeNotifier {
  final _BASE_URL = 'https://newsapi.org/v2';

  List<Article> headLines = [];
  String _categorySelected = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  //mapa que traduce el nombre de una categoria a una forma mas amigable
  Map<String, String> categoriesTraduction = {
    'business': 'Negocios',
    'entertainment': 'Ocio',
    'general': 'General',
    'health': 'Salud',
    'science': 'Ciencia',
    'sports': 'Deportes',
    'technology': 'Tecnología',
  };

  //mapa que traduce el nombre de una categoria a una lista de noticias
  Map<String, List<Article>> categoryArticles = {};

  //El constructor solo se ejecuta una vez al crear la aplicacion.
  //Por lo tanto la peticion se dispara una sola vez
  NewsService() {
    print('Peticion top headlines realizada');
    this.getTopHeadLines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
    print(categoryArticles);
  }

  String get categorySelected => _categorySelected;

  set categorySelected(String cat) {
    _categorySelected = cat;
    notifyListeners();
  }

  ///Obtiene una lista de articulos a partir de la categoria seleccionada
  List<Article> getCategorySelectedArticles() {
    //si la lista de articulos de la categoria aun no ha sido llenada se hace la peticion
    if (categoryArticles[categorySelected].length == 0) {
      getArticlesByCategory(categorySelected);
    }
    return categoryArticles[categorySelected];
  }

  ///Obtiene una lista de las noticias top mediante una peticion get
  void getTopHeadLines() async {
    final url = '$_BASE_URL/top-headlines?apiKey=$NEWS_API_KEY&country=mx';
    final response = await http.get(url);

    final newsResponse = NewsResponse.fromJson(response.body);

    this.headLines.addAll(newsResponse.articles);
    notifyListeners();
  }

  ///Obtiene una lista de las noticias filtradas por categoria mediate una peticion get
  getArticlesByCategory(String category) async {
    //Si la lista ya tiene noticias ya no se hace la peticion
    if (this.categoryArticles[category].length > 0) {
      return;
    }

    final url = '$_BASE_URL/top-headlines?apiKey=$NEWS_API_KEY&country=mx&category=$category';
    final response = await http.get(url);

    final newsResponse = NewsResponse.fromJson(response.body);
    this.categoryArticles[category].addAll(newsResponse.articles);
    
    print('Peticion headlines realizada');

    notifyListeners();
  }
}
