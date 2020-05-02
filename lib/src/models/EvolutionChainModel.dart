import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EvolutionChainModel {
  final int id;
  final String url;
  final EvolutionChain evolutionChain;

  EvolutionChainModel({this.id, this.url, this.evolutionChain});

  factory EvolutionChainModel.fromJson(Map<String, dynamic> json) {
    return EvolutionChainModel(
        id: json['id'], evolutionChain: EvolutionChain.fromJson(json['chain']));
  }
}

class EvolutionChain {
  List<EvolutionChain> evolvesTo;
  List<EvolutionDetails> evolutionDetails;
  String name;
  int id;

  EvolutionChain({this.name, this.evolvesTo, this.evolutionDetails, this.id});

  factory EvolutionChain.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> evolutionChains =
        json['evolves_to'].cast<Map<String, dynamic>>();
    List<Map<String, dynamic>> evolutionDetails =
        json['evolution_details'].cast<Map<String, dynamic>>();
    List<String> urlSplit = json['species']['url'].split("/");
    return EvolutionChain(
        name: json['species']['name'],
        id: int.parse(urlSplit[urlSplit.length - 2]),
        evolutionDetails: evolutionDetails.map((evolutionDetailsJson) {
          return EvolutionDetails.fromJson(evolutionDetailsJson);
        }).toList(),
        evolvesTo: evolutionChains.map((evolutionChainJson) {
          return EvolutionChain.fromJson(evolutionChainJson);
        }).toList());
  }

  List<Widget> buildDetails() {
    return <Widget>[
      ...(evolutionDetails.length > 0
          ? evolutionDetails[0].buildDetails()
          : []),
      ...evolutionDetails.sublist(1).expand((evDet) =>
          [Text("or", style: TextStyle(fontSize: 10)), ...evDet.buildDetails()])
    ];
  }
}

class EvolutionDetails {
  final String trigger;
  final int minLevel;
  final int minHappiness;
  final int minAffection;
  final String timeOfDay;
  final String knownMoveType;
  final String location;
  final int gender;
  final String item;
  final int relativePhysicalStats;

  EvolutionDetails(
      {this.trigger,
      this.item,
      this.minLevel,
      this.minHappiness,
      this.minAffection,
      this.knownMoveType,
      this.location,
      this.gender,
      this.timeOfDay,
      this.relativePhysicalStats});

  factory EvolutionDetails.fromJson(Map<String, dynamic> json) {
    return EvolutionDetails(
        trigger: json['trigger']['name'],
        item: json['item'] != null ? json['item']['name'] : null,
        location: json['location'] != null
            ? (json['location']['name'] as String)
                .split("-")
                .map((s) => s.capitalize())
                .join(" ")
            : null,
        minLevel: json['min_level'],
        minHappiness: json['min_happiness'],
        minAffection: json['min_affection'],
        timeOfDay: json['time_of_day'],
        knownMoveType: json['known_move_type'] != null
            ? json['known_move_type']['name']
            : null,
        gender: json['gender'],
        relativePhysicalStats: json['relative_physical_stats']);
  }

  List<Widget> buildDetails() {
    TextStyle style = TextStyle(fontSize: 10);
    return [
      trigger == "level-up"
          ? Text("lvl ${minLevel != null ? minLevel : "up"}", style: style)
          : null,
      trigger == "use-item"
          ? Image.network(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/$item.png")
          : null,
      relativePhysicalStats != null
          ? relativePhysicalStats > 0
              ? Text("Att > Def", style: style)
              : relativePhysicalStats == 0
                  ? Text("Att = Def", style: style)
                  : Text("Att < Def", style: style)
          : null,
      minHappiness != null ? Text("Happy > $minHappiness", style: style) : null,
      minAffection != null
          ? Text("Affection > $minAffection", style: style)
          : null,
      timeOfDay != ""
          ? Icon(timeOfDay == "day" ? Icons.brightness_7 : Icons.brightness_2,
              size: 12)
          : null,
      knownMoveType != null
          ? Text("Known move type: $knownMoveType", style: style)
          : null,
      gender != null ? Text(gender == 1 ? "Female" : "Male") : null,
      location != null
          ? Row(
              children: <Widget>[
                Icon(Icons.location_on, size: 12),
                Text(" $location", style: style)
              ],
            )
          : null
    ]..removeWhere((el) => el == null);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
