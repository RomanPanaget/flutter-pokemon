import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/FavoritesModel.dart';
import 'package:flutterpokemon/src/models/ThemeModel.dart';
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
    await storage.init();
    PokemonService pokemonService = PokemonService();
    Provider.of<FavoritesModel>(context, listen: false).init();
    Provider.of<ThemeModel>(context, listen: false).init();
    await pokemonService.fetchPokemonsList(storage.retrieveIds());
    Future.delayed(Duration(seconds: 1), () {
      // TODO: implement login
//      if (false) {
//        Navigator.pushReplacementNamed(context, '/home');
//      } else {
//        Navigator.pushReplacementNamed(context, '/login');
//      }
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(child: Image(image: AssetImage("assets/pokeball.png"), width: 200,)),
    );
  }
}
