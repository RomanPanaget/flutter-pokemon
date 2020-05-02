import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/EvolutionChainModel.dart';
import 'package:flutterpokemon/src/services/PokemonService.dart';

class EvolutionChainTile extends StatefulWidget {
  final String pokemonName;
  final EvolutionChain evolutionChain;

  EvolutionChainTile({this.pokemonName, this.evolutionChain});

  @override
  State<StatefulWidget> createState() => _EvolutionChainTile();
}

class _EvolutionChainTile extends State<EvolutionChainTile> {
  Widget _buildEvolutionTree(EvolutionChain evolution, {bool first = false}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        first
            ? Column()
            : Column(children: [
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                ),
                ...evolution.buildDetails()
              ]),
        GestureDetector(
            onTap: evolution.name != widget.pokemonName
                ? () => Navigator.pushReplacementNamed(context, "/detail",
                    arguments: PokemonService().fetchPokemon(evolution.id))
                : null,
            child: Column(children: [
              Image.network(
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${evolution.id}.png"),
              Text(evolution.name.capitalize())
            ])),
        Column(
            children: evolution.evolvesTo
                .map((EvolutionChain ev) => _buildEvolutionTree(ev))
                .toList())
      ],
    );
  }

  List<String> fetchEvolutions(
      EvolutionChain evolutions, List<String> current) {
    if (evolutions.evolvesTo.length == 0) {
      return [evolutions.name];
    }
    return evolutions.evolvesTo
        .expand((ev) => [evolutions.name, ...fetchEvolutions(ev, current)])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: _buildEvolutionTree(widget.evolutionChain, first: true));
  }
}
