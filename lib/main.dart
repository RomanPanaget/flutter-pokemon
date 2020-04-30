import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/FavoritesModel.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:flutterpokemon/src/models/ThemeModel.dart';
import 'package:flutterpokemon/src/screens/FavoritesScreen.dart';
import 'package:flutterpokemon/src/screens/HomeScreen.dart';
import 'package:flutterpokemon/src/screens/LoginScreen.dart';
import 'package:flutterpokemon/src/screens/PokedexScreen.dart';
import 'package:flutterpokemon/src/screens/PokemonDetailScreen.dart';
import 'package:flutterpokemon/src/screens/SearchScreen.dart';
import 'package:flutterpokemon/src/screens/SettingsScreen.dart';
import 'package:flutterpokemon/src/screens/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoritesModel>(
            create: (context) => FavoritesModel(ids: [])),
        ChangeNotifierProvider<ThemeModel>(create: (context) => ThemeModel()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (context, theme, child) {
      return MaterialApp(
        title: 'Flutter Pokemon App',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red,
          accentColor: Colors.white,
        ),
        themeMode: theme.adaptive
            ? ThemeMode.system
            : theme.light ? ThemeMode.light : ThemeMode.dark,
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
              return MaterialPageRoute(
                  builder: (_) => PokemonDetailScreen(pokemon));
            case SettingsScreen.routeName:
              return MaterialPageRoute(builder: (_) => SettingsScreen());
          }
          return null;
        },
      );
    });
  }
}
