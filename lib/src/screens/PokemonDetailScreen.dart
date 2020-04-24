import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';

class PokemonDetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  final PokemonModel pokemon;
  PokemonDetailScreen(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.pokemon.name),
      ),
    );
  }
}
