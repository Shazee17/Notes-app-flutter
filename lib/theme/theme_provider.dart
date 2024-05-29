import 'package:flutter/material.dart';
import 'package:notes_app_flutter/theme/theme.dart';


class ThemeProvider extends ChangeNotifier {
  // Default theme is light mode
  ThemeData _themeData = lightMode;


// Getter for the theme data, to acess the theme data from other files
  ThemeData get themeData => _themeData;


// Getter for the isDarkMode, to check if the current theme is dark mode  
  bool get isDarkMode => _themeData == darkMode;


// Setter for the theme data, to set the theme data from other files
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

// Function to toggle the theme
  void toggleTheme() {
    _themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();
  }
}