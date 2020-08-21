import 'package:flutter/material.dart';

class NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  final _pageController = new PageController();

  //Get y Set de currentPage
  int get currentPage => this._currentPage;

  set currentPage(int page) {
    _currentPage = page;
    _pageController.animateToPage(page, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    notifyListeners();
  }

  //get de PageController
  PageController get pageController => this._pageController;
}
