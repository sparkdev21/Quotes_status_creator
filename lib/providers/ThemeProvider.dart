import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_status_creator/Constants/Thmes.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = ChangeNotifierProvider<ThemeProvider>(
  (ref) => ThemeProvider(),
);

class ThemeProvider extends ChangeNotifier {
  DevFestPreferences devFestPreferences = DevFestPreferences();

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  FlexScheme _flexScheme = FlexScheme.outerSpace;
  FlexScheme get flexScheme => _flexScheme;

  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  setThemeMode() async {
    int index = await devFestPreferences.getThemeColor();
    _flexScheme = themeColors[index];
    _darkTheme = await devFestPreferences.getTheme();
    _themeMode =
        await devFestPreferences.getTheme() ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    devFestPreferences.setDarkTheme(value);
    debugPrint("Dark Theme: $_darkTheme");
    notifyListeners();
  }

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    _darkTheme = isOn;
    devFestPreferences.setDarkTheme(isOn);
    notifyListeners();
  }

  void setColor(FlexScheme value, int i) {
    _flexScheme = value;
    devFestPreferences.setThemeColor(i);

    print("color:$value");
    notifyListeners();
  }
}

class DevFestPreferences {
  static const THEME_STATUS = "THEMESTATUS";
  static const THEME_COLOR = "color";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  setThemeColor(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(THEME_COLOR, value);
  }

  Future<int> getThemeColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(THEME_COLOR) ?? 1;
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}
