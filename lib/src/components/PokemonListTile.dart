import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';

class PokemonListTile extends StatelessWidget {
  final PokemonModel pokemon;

  PokemonListTile({Key key, @required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(8),
      leading: Container(
          width: 90,
          child: Center(
              child: Text(
            '#${this.pokemon.id}',
            style: TextStyle(
                fontSize: 26, color: Colors.red, fontWeight: FontWeight.bold),
          ))),
      title: Text(
        '${this.pokemon.name.capitalize()}',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        Image.network(
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${this.pokemon.id}.png"),
        Padding(padding: EdgeInsets.only(left: 10),child:Icon(Icons.chevron_right))
      ]),
      onTap: () {
        Navigator.pushNamed(context, "/detail", arguments: this.pokemon);
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}