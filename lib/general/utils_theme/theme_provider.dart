import 'package:flutter/material.dart';
import 'package:userapp/general/utils_theme/store_manager.dart';
import 'package:userapp/general/utils_theme/themes.dart';

///Provider to tell the App which Theme is active
class ThemeNotifier with ChangeNotifier {
  final darkTheme = constDarkTheme;
  final lightTheme = constLightTheme;
  final highContrast = constDarkTheme;

  late ThemeData _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then(
      (value) {
        // if (value == 'light') {
        //   _themeData = lightTheme;
        // } else {
        //   _themeData = darkTheme;
        // }
        _themeData = lightTheme;
        notifyListeners();
      },
    );
  }

  ///Returns the current active Theme
  ThemeData getTheme() => _themeData;

  ///Sets the current active theme to dark mode
  void setDarkTheme() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  ///Sets the current active theme to dark mode
  void setHighContrastTheme() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  ///Sets the current active theme to light mode
  void setLightTheme() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
