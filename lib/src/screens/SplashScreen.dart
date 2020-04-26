import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/FavoritesModel.dart';
import 'package:flutterpokemon/src/services/PokemonService.dart';
import 'package:flutterpokemon/src/services/StorageService.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    onStart();
  }

  onStart() async {
    print("onStart");
    StorageService storage = StorageService();
    PokemonService pokemonService = PokemonService();
    //await storage.initDatabase();
    //get favorites ids list from storage
    List<int> ids = [2, 87, 340];
    Provider.of<FavoritesModel>(context, listen: false).init(ids);
    await pokemonService.fetchPokemonsList(ids);
    print("done caching");
    Future.delayed(Duration(seconds: 1), () {
      // TODO: implement login check
//      if (false) {
//        Navigator.pushReplacementNamed(context, '/home');
//      } else {
//        Navigator.pushReplacementNamed(context, '/login');
//      }
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(child: Text("Splash")),
    );
  }
}
