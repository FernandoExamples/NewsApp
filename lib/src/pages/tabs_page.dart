import 'package:flutter/material.dart';
import 'package:news_app/src/models/navigation_model.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PageViewWidget(),
      bottomNavigationBar: _NavigationBarWidget(),
    );
  }
}

///Barra de navegacion inferior
class _NavigationBarWidget extends StatelessWidget {
  const _NavigationBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationModel>(context);

    return BottomNavigationBar(currentIndex: navigationModel.currentPage, onTap: (index) => navigationModel.currentPage = index, items: [
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('Para ti')),
      BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('Encabezados')),
    ]);
  }
}

///Widget encargado de la paginacion
class _PageViewWidget extends StatelessWidget {
  const _PageViewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationModel>(context);

    return PageView(
      //inhabilitar el scroll horizontal del pageview
      physics: NeverScrollableScrollPhysics(),
      controller: navigationModel.pageController,
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}
