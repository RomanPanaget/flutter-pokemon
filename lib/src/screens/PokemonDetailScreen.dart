import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/EvolutionChainModel.dart';
import 'package:flutterpokemon/src/models/FavoritesModel.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonDetailScreen extends StatefulWidget {
  static const routeName = '/detail';

  final PokemonModel pokemon;

  PokemonDetailScreen(this.pokemon);

  @override
  State<StatefulWidget> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  bool _fav;

  @override
  void initState() {
    super.initState();
    _fav = Provider.of<FavoritesModel>(context, listen: false)
        .isFavorite(widget.pokemon.id);
  }

  _toggleFav() {
    _fav = !_fav;
    var favorites = Provider.of<FavoritesModel>(context, listen: false);
    if (_fav)
      favorites.add(widget.pokemon.id);
    else
      favorites.remove(widget.pokemon.id);
  }

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
                Text(
                  evolution.evolutionDetails.length > 0 &&
                          evolution.evolutionDetails[0].minLevel != null
                      ? "lvl. ${evolution.evolutionDetails[0].minLevel}"
                      : "",
                  style: TextStyle(fontSize: 12),
                )
              ]),
        Column(children: [
          Image.network(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${evolution.id}.png"),
          Text(evolution.name.capitalize())
        ]),
        Column(
            children: evolution.evolvesTo
                .map((EvolutionChain ev) => _buildEvolutionTree(ev))
                .toList())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: BackButtonIcon(),
            onPressed: () => Navigator.pop(context, _fav),
          ),
          title: Text(widget.pokemon.name.capitalize()),
          actions: <Widget>[
            IconButton(
              icon: Icon(_fav ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                setState(() {
                  _toggleFav();
                });
              },
            )
          ],
        ),
        body: ListView(children: <Widget>[
          Stack(children: [
            Center(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: FadeInImage.assetNetwork(
                  placeholder: String.fromCharCodes(kTransparentImage),
                  image:
                      "https://pokeres.bastionbot.org/images/pokemon/${widget.pokemon.id}.png"),
            )),
            Positioned(
              top: 20,
              left: 20,
              child: Text(
                "#${widget.pokemon.id}",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
          Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Evolution Chain",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          Center(
              child: _buildEvolutionTree(
                  widget.pokemon.evolutions.evolutionChain,
                  first: true))
        ]));
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
