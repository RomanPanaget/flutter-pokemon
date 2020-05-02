import 'package:flutterpokemon/src/models/EvolutionChainModel.dart';
import 'package:flutterpokemon/src/models/TypeModel.dart';

class PokemonModel {
  final int id;
  final String name;
  final TypeModel types;
  final EvolutionChainModel evolutions;

  PokemonModel({this.id, this.name, this.evolutions, this.types});

  factory PokemonModel.fromJson(Map<String, dynamic> json,
      {EvolutionChainModel evolutionChain, TypeModel types}) {
    return PokemonModel(
        id: json['id'],
        name: json['name'],
        evolutions: evolutionChain,
        types: types);
  }

}
