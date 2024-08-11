import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:userapp/general/utils_theme/store_manager.dart';
import 'package:userapp/general/utils_theme/themes.dart';

///Provider to tell the App which Theme is active
class ThemeNotifier with ChangeNotifier {
  final darkTheme = constDarkTheme;
  final lightTheme = constLightTheme;
  final highContrast = constDarkTheme;

  ThemeData? _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then(
      (value) {
        //TODO Themes integration finishing all styles and colors. but for now the app just needs to be functional
        // if (value == 'light') {
        //   _themeData = lightTheme;
        // } else if (value == 'dark') {
        //   _themeData = darkTheme;
        // } else {
        //   // _themeData = getSystemTheme();
        //   _themeData = lightTheme;
        // }
        // notifyListeners();

        _themeData = lightTheme;
        notifyListeners();
      },
    );
  }

  ///Returns the current active Theme
  ThemeData? getTheme() => _themeData;

  ///Sets the current active theme to dark mode

  Future<void> setDarkTheme() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  ///Sets the current active theme to dark mode

  Future<void> setHighContrastTheme() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  ///Sets the current active theme to light mode

  Future<void> setLightTheme() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  Future<void> setSystemTheme() async {
    print("set system theme");
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    _themeData = isDarkMode ? darkTheme : lightTheme;
    StorageManager.saveData('themeMode', 'system');
    notifyListeners();
  }

  ThemeData getSystemTheme() {
    // var brightness =
    //     SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode ? darkTheme : lightTheme;
  }
}
