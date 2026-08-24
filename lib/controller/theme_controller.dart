import 'package:flutter/cupertino.dart';

class ThemeController extends ChangeNotifier {
  bool isDarkMode = false;

   toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}