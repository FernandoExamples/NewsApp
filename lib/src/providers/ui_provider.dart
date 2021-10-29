import 'package:flutter/material.dart';
import 'package:news_app/src/themes/dark_theme.dart';

class UIProvider with ChangeNotifier {
  ThemeData _currentTheme = darkTheme;

  ThemeData get currentTheme => _currentTheme;

  set currentTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}
