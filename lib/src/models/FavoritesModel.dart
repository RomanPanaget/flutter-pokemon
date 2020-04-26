import 'package:flutter/cupertino.dart';
import 'package:flutterpokemon/src/services/StorageService.dart';

class FavoritesModel extends ChangeNotifier{
  List<int> ids;
  StorageService _storage;

  FavoritesModel({@required this.ids});

  factory FavoritesModel.fromJson(Map<String, List<int>> json) {
    return FavoritesModel(
      ids: json['ids'],
    );
  }

  toJson() {
    Map<String, List<int>> json = Map<String, List<int>>();
    json['ids'] = this.ids;
    return json;
  }

  bool isFavorite(int id) => this.ids.contains(id);

  init(List<int> ids) {
    _storage = StorageService();
    this.ids = ids;
  }

  add(int id) {
    this.ids.add(id);
    notifyListeners();
  }

  remove(int id) {
    this.ids.remove(id);
    notifyListeners();
  }
}