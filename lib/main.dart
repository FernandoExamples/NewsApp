import 'package:flutter/material.dart';
import 'package:news_app/src/providers/navigation_provider.dart';
import 'package:news_app/src/pages/tabs_page.dart';
import 'package:news_app/src/providers/news_provider.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/themes/dark_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(create: (_) => NavigationProvider()),
        ChangeNotifierProvider<NewsProvider>(create: (_) => NewsProvider(newsService: NewsService())),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: TabsPage(),
        theme: myTheme,
      ),
    );
  }
}
