import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/FavoritesModel.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:flutterpokemon/src/screens/FavoritesScreen.dart';
import 'package:flutterpokemon/src/screens/HomeScreen.dart';
import 'package:flutterpokemon/src/screens/LoginScreen.dart';
import 'package:flutterpokemon/src/screens/PokedexScreen.dart';
import 'package:flutterpokemon/src/screens/PokemonDetailScreen.dart';
import 'package:flutterpokemon/src/screens/SearchScreen.dart';
import 'package:flutterpokemon/src/screens/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => FavoritesModel(ids: []),
    child: MyApp(),
  ),);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomeScreen.routeName:
            return MaterialPageRoute(builder: (_) => HomeScreen());
          case LoginScreen.routeName:
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case SearchScreen.routeName:
            return MaterialPageRoute(builder: (_) => SearchScreen());
          case PokedexScreen.routeName:
            return MaterialPageRoute(builder: (_) => PokedexScreen());
          case FavoritesScreen.routeName:
            return MaterialPageRoute(builder: (_) => FavoritesScreen());
          case PokemonDetailScreen.routeName:
            final PokemonModel pokemon = settings.arguments;
            return MaterialPageRoute(builder: (_) => PokemonDetailScreen(pokemon));
        }
        return null;
      },
    );
  }
}
