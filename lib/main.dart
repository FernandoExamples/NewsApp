import 'package:flutter/material.dart';
import 'package:news_app/src/providers/navigation_provider.dart';
import 'package:news_app/src/pages/news_page.dart';
import 'package:news_app/src/providers/news_provider.dart';
import 'package:news_app/src/providers/ui_provider.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<NavigationProvider>(create: (_) => NavigationProvider()),
          ChangeNotifierProvider<UIProvider>(create: (_) => UIProvider()),
          ChangeNotifierProvider<NewsProvider>(create: (_) => NewsProvider(newsService: NewsService())),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: NewsPage(),
      theme: Provider.of<UIProvider>(context).currentTheme,
    );
  }
}
