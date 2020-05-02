import 'dart:convert';

import 'package:flutterpokemon/src/models/EvolutionChainModel.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:flutterpokemon/src/models/TypeModel.dart';
import 'package:http/http.dart' as http;

class PokemonService {
  Map<dynamic, PokemonModel> pokemonsCache;
  Map<String, EvolutionChainModel> evolutionsCache;
  static final PokemonService _singleton = PokemonService._internal();

  PokemonService._internal() {
    pokemonsCache = Map<dynamic, PokemonModel>();
    evolutionsCache = Map<String, EvolutionChainModel>();
  }

  factory PokemonService() {
    return _singleton;
  }

  Future<PokemonModel> fetchPokemon(dynamic id) async {
    if (pokemonsCache.containsKey(id)) {
      print("Returned Pokemon in cache");
      return pokemonsCache[id];
    }
    print("Pokemon not found in cache, fetching API");
    final pokemonResponse =
        await http.get('https://pokeapi.co/api/v2/pokemon-species/$id');

    if (pokemonResponse.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(pokemonResponse.body);

      EvolutionChainModel evolutions =
          await fetchEvolutionChain(json['evolution_chain']['url']);

      TypeModel types = await fetchTypes(id);

      PokemonModel pokemon =
          PokemonModel.fromJson(json, evolutionChain: evolutions, types: types);
      pokemonsCache[json['id']] = pokemon;

      return pokemon;
    }
    return null;
  }

  Future<EvolutionChainModel> fetchEvolutionChain(String url) async {
    if (evolutionsCache.containsKey(url)) {
      print("Returned Evolution chain in cache");
      return evolutionsCache[url];
    }
    print("Evolution chain not found in cache, fetching API");
    final evolutionsResponse = await http.get(url);

    if (evolutionsResponse.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(evolutionsResponse.body);
      EvolutionChainModel evolutionChainModel =
          EvolutionChainModel.fromJson(json);
      evolutionsCache[url] = evolutionChainModel;
      return evolutionChainModel;
    }
    return null;
  }

  Future<TypeModel> fetchTypes(dynamic id) async {
    final pokemonResponse =
        await http.get('https://pokeapi.co/api/v2/pokemon/$id');

    if (pokemonResponse.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(pokemonResponse.body);

      return TypeModel.fromJson(json);
    }
    return null;
  }

  Future<List<PokemonModel>> fetchPokemons(int first, int count) async {
    var ids = new List<int>.generate(count, (i) => i);
    return Future.wait(ids.map((id) => fetchPokemon(first + id)));
  }

  Future<List<PokemonModel>> fetchPokemonsList(List<int> ids) async {
    return Future.wait(ids.map((id) => fetchPokemon(id)));
  }

  PokemonModel getFromCache(int id) {
    if (pokemonsCache.containsKey(id)) return pokemonsCache[id];
    throw Exception("Pokemon not found in cache");
  }
}
