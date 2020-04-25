import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/components/PokemonListTile.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:flutterpokemon/src/services/PokemonService.dart';

class PokedexScreen extends StatefulWidget {
  static const routeName = '/pokedex';

  @override
  State<StatefulWidget> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  final PokemonService _service = PokemonService();
  List<PokemonModel> _pokemons;

  final _formKey = GlobalKey<FormState>();
  int firstId = 1;
  int count = 20;

  @override
  void initState() {
    super.initState();
    _pokemons = [];
    fetchPokemons();
  }

  fetchPokemons() async {
    List<PokemonModel> pokemons =
        await this._service.fetchPokemons(firstId, count);
    setState(() {
      _pokemons = pokemons;
    });
  }

  _onSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _pokemons = [];
      });
      fetchPokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Pokedex")),
        body: _pokemons.length == 0
            ? Center(child: CircularProgressIndicator())
            : Column(mainAxisSize: MainAxisSize.max, children: [
                Form(
                    key: _formKey,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text("From")),
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  initialValue: '$firstId',
                                  onFieldSubmitted: (v) => _onSubmit(),
                                  validator: (value) {
                                    if (value.isEmpty ||
                                        (int.tryParse(value) ?? "") is! int) {
                                      print(value.isEmpty);
                                      print(value is int);
                                      return 'Enter a number';
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    firstId = int.tryParse(v) ?? 0;
                                  },
                                ))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text("Count")),
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  initialValue: '$count',
                                  validator: (value) {
                                    if (value.isEmpty ||
                                        (int.tryParse(value) ?? "") is! int) {
                                      return 'Enter a number';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (v) => _onSubmit(),
                                  onSaved: (v) {
                                    count = int.tryParse(v) ?? 0;
                                  },
                                ))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: RaisedButton(
                              child: Text(
                                "Fetch",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.red,
                              onPressed: _onSubmit,
                            )),
                      ],
                    )),
                Expanded(
                    child: ListView.separated(
                  separatorBuilder: (_, __) => Divider(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                  itemBuilder: (context, i) =>
                      PokemonListTile(pokemon: this._pokemons[i]),
                  itemCount: this._pokemons.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                ))
              ]));
  }
}
