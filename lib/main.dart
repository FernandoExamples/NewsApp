import 'package:flutter/material.dart';
import 'package:news_app/src/models/navigation_model.dart';
import 'package:news_app/src/pages/tabs_page.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/themes/darkTheme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationModel>(create: (_) => NavigationModel()),
        ChangeNotifierProvider<NewsService>(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: TabsPage(),
        theme: myTheme,
      ),
    );
  }
}
