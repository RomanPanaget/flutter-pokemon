import 'package:flutter/cupertino.dart';

class TypeModel {
  final List<String> names;

  TypeModel({this.names});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
        names: (json['types'] as List)
            .map((type) => type['type']['name'])
            .cast<String>()
            .toList());
  }
}

class TypesModel {
  static Map<String, Color> colors = {
    "normal": Color(0xFFA7A879),
    "fire": Color(0xFFF08030),
    "water": Color(0xFF6890F0),
    "electric": Color(0xFFF8D030),
    "grass": Color(0xFF78C850),
    "ice": Color(0xFF98D9D8),
    "ground": Color(0xFFE0C068),
    "flying": Color(0xFFF7F7F7),
    "poison": Color(0xFFA040A0),
    "fighting": Color(0xFFC12F28),
    "psychic": Color(0xFFF85889),
    "dark": Color(0xFF705848),
    "rock": Color(0xFFB8A038),
    "bug": Color(0xFFA8B91F),
    "ghost": Color(0xFF705998),
    "steel": Color(0xFFB8B8D0),
    "dragon": Color(0xFF7038F8),
    "fairy": Color(0xFFFFAECA)
  };
}
