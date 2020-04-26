import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _singleton = StorageService._internal();

  SharedPreferences prefs;
  final String prefsString = "POKEMON:FAVORITES";

  StorageService._internal() {
    //constructor
  }

  factory StorageService() {
    return _singleton;
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  save(List<int> ids) {
    prefs.setString(prefsString, jsonEncode(ids));
  }

  List<int> retrieve() {
    return jsonDecode(prefs.getString(prefsString) ?? "[]").cast<int>();
  }
}
