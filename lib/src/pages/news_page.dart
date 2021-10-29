import 'package:flutter/material.dart';
import 'package:news_app/src/providers/navigation_provider.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:news_app/src/providers/ui_provider.dart';
import 'package:news_app/src/themes/dark_theme.dart';
import 'package:news_app/src/themes/ligth_theme.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: [
          IconButton(
            onPressed: () {
              uiProvider.currentTheme = uiProvider.currentTheme == lightTheme ? darkTheme : lightTheme;
            },
            icon: Icon(uiProvider.currentTheme == lightTheme ? Icons.dark_mode : Icons.light_mode),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: _PageViewWidget(),
      bottomNavigationBar: _NavigationBarWidget(),
    );
  }
}

class _NavigationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationProvider>(context);

    return BottomNavigationBar(
        currentIndex: navigationModel.currentPage,
        onTap: (index) => navigationModel.currentPage = index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Para ti'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
        ]);
  }
}

class _PageViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: navigationProvider.pageController,
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}
