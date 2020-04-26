import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonDetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  final PokemonModel pokemon;

  PokemonDetailScreen(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.pokemon.name.capitalize()),
        ),
        body: Stack(children: [
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              "#1",
              style: TextStyle(
                  fontSize: 26, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: FadeInImage.assetNetwork(
                  placeholder: String.fromCharCodes(kTransparentImage),
                  image:
                      "https://pokeres.bastionbot.org/images/pokemon/${this.pokemon.id}.png"),
            ),
          ])
        ]));
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
