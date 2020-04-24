import 'dart:convert';

import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:http/http.dart' as http;

class PokemonService {
  Map<int, PokemonModel> pokemons;
  static final PokemonService _singleton = PokemonService._internal();

  PokemonService._internal(){
    pokemons = Map<int, PokemonModel>();
  }

  factory PokemonService() {
    return _singleton;
  }


  Future<PokemonModel> fetchPokemon(int id) async {
    if (pokemons.containsKey(id)) {
      print("Returned Pokemon in cache");
      return pokemons[id];
    }
    print("Pokemon not found in cache, fetching API");
    final response = await http.get('https://pokeapi.co/api/v2/pokemon/$id');

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      PokemonModel pokemon = PokemonModel.fromJson(json);
      pokemons[json['id']] = pokemon;
      return pokemon;
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  Future<List<PokemonModel>> fetchPokemons(int first, int count) async {
    var ids = new List<int>.generate(count, (i) => i);
    return Future.wait(ids.map((id) => fetchPokemon(first + id)));
  }
}
