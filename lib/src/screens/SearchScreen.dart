import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/components/PokemonListCard.dart';
import 'package:flutterpokemon/src/models/FavoritesModel.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:flutterpokemon/src/services/PokemonService.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  final PokemonService _service = PokemonService();
  String _currentSearch = "";

  PokemonModel _pokemon;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _pokemon = null;
    _loading = false;
  }

  _fetchPokemon() async {
    PokemonModel pokemon =
        await this._service.fetchPokemon(_currentSearch.toLowerCase());
    setState(() {
      _loading = false;
      _pokemon = pokemon;
    });
  }

  _onSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _pokemon = null;
        _loading = true;
      });
      _fetchPokemon();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Theme.of(context).brightness,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Form(
            key: _formKey,
            child: ListTile(
              trailing: IconButton(
                icon: Icon(Icons.search),
                onPressed: _onSubmit,
              ),
              title: TextFormField(
                autofocus: true,
                initialValue: _currentSearch,
                expands: false,
                decoration: InputDecoration(
                  labelText: "Enter a name or an ID",
                ),
                onFieldSubmitted: (v) => _onSubmit(),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please search for something';
                  }
                  return null;
                },
                onSaved: (v) {
                  _currentSearch = v;
                },
              ),
            ),
          ),
          _loading
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : _pokemon == null
                  ? Expanded(
                      child: Center(
                          child: Text(_currentSearch.isEmpty
                              ? "Try searching for something"
                              : "We couldn't find any pokemon with \"$_currentSearch\"")))
                  : Consumer<FavoritesModel>(
                      builder: (context, favorites, child) {
                      return PokemonListCard(
                        pokemon: _pokemon,
                        isFav: favorites.isFavorite(_pokemon.id),
                        onFavPressed: () => favorites.toggle(_pokemon.id),
                      );
                    })
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
