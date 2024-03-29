import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentPage = 0;
  final _pageController = new PageController();

  int get currentPage => this._currentPage;

  set currentPage(int page) {
    _currentPage = page;
    _pageController.animateToPage(page, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
