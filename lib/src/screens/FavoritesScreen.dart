import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/components/PokemonListCard.dart';
import 'package:flutterpokemon/src/models/FavoritesModel.dart';
import 'package:flutterpokemon/src/services/PokemonService.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = "/favorites";

  final PokemonService _service = PokemonService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
        ),
        body: Consumer<FavoritesModel>(
          builder: (context, favorites, child) {
            return favorites.ids.length == 0
                ? Center(child: Text("No favorites found..."))
                : ListView.builder(
                    itemBuilder: (context, index) => PokemonListCard(
                      key: ValueKey(favorites.ids[index]),
                      pokemon: _service.getFromCache(favorites.ids[index]),
                      isFav: true,
                      onFavPressed: () =>
                          Provider.of<FavoritesModel>(context, listen: false)
                              .remove(favorites.ids[index]),
                    ),
                    itemCount: favorites.ids.length,
                  );
          },
        ));
  }
}
