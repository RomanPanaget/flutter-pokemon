import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _singleton = StorageService._internal();

  SharedPreferences prefs;
  final String favoritesString = "POKEMON:FAVORITES";
  final String darkModeString = "POKEMON:DARKMODE";
  final String adaptiveModeString = "POKEMON:ADAPTIVEMODE";

  StorageService._internal();

  factory StorageService() {
    return _singleton;
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs);
  }

  saveIds(List<int> ids) {
    prefs.setString(favoritesString, jsonEncode(ids));
  }

  List<int> retrieveIds() {
    return jsonDecode(prefs.getString(favoritesString) ?? "[]").cast<int>();
  }

  saveAdaptive(bool adaptive) {
    prefs.setBool(adaptiveModeString, adaptive);
  }

  retrieveAdaptive() {
    return prefs.getBool(adaptiveModeString);
  }

  saveDarkMode(bool darkMode) {
    prefs.setBool(darkModeString, darkMode);
  }

  retrieveDarkMode() {
    return prefs.getBool(darkModeString);
  }
}
