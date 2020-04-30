import 'package:flutterpokemon/src/models/EvolutionChainModel.dart';

class PokemonModel {
  final int id;
  final String name;
  final EvolutionChainModel evolutions;

  PokemonModel({this.id, this.name, this.evolutions});

  factory PokemonModel.fromJson(Map<String, dynamic> json,
      {EvolutionChainModel evolutionChain}) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      evolutions: evolutionChain,
    );
  }
}
