import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/components/InfoSection.dart';
import 'package:flutterpokemon/src/components/details/EvolutionChainTile.dart';
import 'package:flutterpokemon/src/components/details/TypeRelationsTile.dart';
import 'package:flutterpokemon/src/components/details/TypesRelationsGivenTile.dart';
import 'package:flutterpokemon/src/components/details/TypesRelationsTakenTile.dart';
import 'package:flutterpokemon/src/models/FavoritesModel.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:flutterpokemon/src/models/TypeModel.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonDetailScreen extends StatefulWidget {
  static const routeName = '/detail';

  final Future<PokemonModel> pokemonFuture;

  PokemonDetailScreen(this.pokemonFuture);

  @override
  State<StatefulWidget> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  bool _fav;
  PokemonModel _pokemon;

  @override
  void initState() {
    super.initState();
    onStart();
  }

  onStart() async {
    var pokemon = await widget.pokemonFuture;
    if (this.mounted) {
      setState(() {
        _fav = Provider.of<FavoritesModel>(context, listen: false)
            .isFavorite(pokemon.id);
        _pokemon = pokemon;
      });
    }
  }

  _toggleFav() {
    _fav = !_fav;
    var favorites = Provider.of<FavoritesModel>(context, listen: false);
    if (_fav)
      favorites.add(_pokemon.id);
    else
      favorites.remove(_pokemon.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(_pokemon != null ? _pokemon.name.capitalize() : "Loading"),
          backgroundColor: Theme.of(context).accentColor.withOpacity(.03),
          elevation: 0,
          brightness: Theme.of(context).brightness,
          actions: _pokemon != null
              ? <Widget>[
                  IconButton(
                    icon: Icon(_fav ? Icons.favorite : Icons.favorite_border),
                    onPressed: () {
                      setState(() {
                        _toggleFav();
                      });
                    },
                  )
                ]
              : [],
        ),
        body: Container(
            color: Theme.of(context).accentColor.withOpacity(.03),
            child: _pokemon == null
                ? Center(child: CircularProgressIndicator())
                : ListView(children: <Widget>[
                    Container(
                        height: 270,
                        child: Stack(children: [
                          Center(
                              child: Padding(
                            padding: EdgeInsets.all(20),
                            child: FadeInImage.assetNetwork(
                                placeholder:
                                    String.fromCharCodes(kTransparentImage),
                                image:
                                    "https://pokeres.bastionbot.org/images/pokemon/${_pokemon.id}.png"),
                          )),
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Text(
                              "#${_pokemon.id}",
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ])),
                    InfoSection(
                        title: "Evolution Chain",
                        child: EvolutionChainTile(
                            pokemonName: _pokemon.name,
                            evolutionChain:
                                _pokemon.evolutions.evolutionChain)),
                    ...(_pokemon.types.length == 1
                        ? [
                            InfoSection(
                                title: "Type Damage Relations",
                                child: TypesRelationsTile(
                                    type: _pokemon.types[0])),
                          ]
                        : [
                            InfoSection(
                                title: "Type Damage Taken",
                                child: TypesRelationsTakenTile(
                                    types: _pokemon.types,
                                    combination: TypesModel.combineTypes(
                                        _pokemon.types))),
                            ..._pokemon.types
                                .expand((TypeModel type) => [
                                      InfoSection(
                                          title:
                                              "Type Damage Given - ${type.name.capitalize()}",
                                          child: TypesRelationsGivenTile(
                                            type: type,
                                          )),
                                    ])
                                .toList()
                          ])
                  ])));
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
