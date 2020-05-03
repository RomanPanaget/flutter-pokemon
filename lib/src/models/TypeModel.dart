import 'package:flutter/cupertino.dart';

class TypeModel {
  final int id;
  final String name;
  final Set<String> doubleDamageFrom;
  final Set<String> doubleDamageTo;
  final Set<String> halfDamageFrom;
  final Set<String> halfDamageTo;
  final Set<String> noDamageFrom;
  final Set<String> noDamageTo;

  TypeModel(
      {this.id,
      this.name,
      this.doubleDamageFrom,
      this.doubleDamageTo,
      this.halfDamageFrom,
      this.halfDamageTo,
      this.noDamageFrom,
      this.noDamageTo});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    Set<String> _getDamageRelation(
            Map<String, dynamic> json, String relation) =>
        json['damage_relations'][relation]
            .map((type) => type['name'])
            .cast<String>()
            .toSet();
    return TypeModel(
      id: json['id'],
      name: json['name'],
      doubleDamageFrom: _getDamageRelation(json, 'double_damage_from'),
      doubleDamageTo: _getDamageRelation(json, 'double_damage_to'),
      halfDamageFrom: _getDamageRelation(json, 'half_damage_from'),
      halfDamageTo: _getDamageRelation(json, 'half_damage_to'),
      noDamageFrom: _getDamageRelation(json, 'no_damage_from'),
      noDamageTo: _getDamageRelation(json, 'no_damage_to'),
    );
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
    "flying": Color(0xFFA890F0),
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

  static combineTypes(List<TypeModel> types) {
    Set<String> doubleDamageFrom = types.fold(
        Set<String>(),
        (Set<String> doubleDamageFrom, TypeModel type) =>
            doubleDamageFrom.union(type.doubleDamageFrom));
    Set<String> halfDamageFrom = types.fold(
        Set<String>(),
        (Set<String> halfDamageFrom, TypeModel type) =>
            halfDamageFrom.union(type.halfDamageFrom));
    Set<String> noDamageFrom = types.fold(
        Set<String>(),
        (Set<String> noDamageFrom, TypeModel type) =>
            noDamageFrom.union(type.noDamageFrom));
    Set<String> neutralFrom = doubleDamageFrom.intersection(halfDamageFrom);
    doubleDamageFrom =
        doubleDamageFrom.difference(noDamageFrom).difference(neutralFrom);
    halfDamageFrom =
        halfDamageFrom.difference(noDamageFrom).difference(neutralFrom);
    return TypeModel(
        doubleDamageFrom: doubleDamageFrom,
        halfDamageFrom: halfDamageFrom,
        noDamageFrom: noDamageFrom);
  }
}
