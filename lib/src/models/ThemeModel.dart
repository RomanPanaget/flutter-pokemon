import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/services/StorageService.dart';

class ThemeModel extends ChangeNotifier {
  bool light = true;
  bool adaptive = false;
  StorageService _storage;

  init() {
    _storage = StorageService();
    this.light = !(_storage.retrieveDarkMode() ?? !this.light);
    this.adaptive = _storage.retrieveAdaptive() ?? this.adaptive;
    notifyListeners();
    print("init setting light to ${_storage.retrieveDarkMode()} and adaptive to ${_storage.retrieveAdaptive()}");
  }

  toggleTheme() {
    this.light = !this.light;
    _storage.saveDarkMode(!this.light);
    notifyListeners();
  }

  toggleAdaptive() {
    this.adaptive = !this.adaptive;
    _storage.saveAdaptive(this.adaptive);
    notifyListeners();
  }

}