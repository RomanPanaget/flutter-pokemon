import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/screens/HomeScreen.dart';
import 'package:flutterpokemon/src/screens/LoginScreen.dart';
import 'package:flutterpokemon/src/screens/PokedexScreen.dart';
import 'package:flutterpokemon/src/screens/SearchScreen.dart';
import 'package:flutterpokemon/src/screens/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (_) => HomeScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case '/search':
            return MaterialPageRoute(builder: (_) => SearchScreen());
          case '/pokedex':
            return MaterialPageRoute(builder: (_) => PokedexScreen());
        }
        return null;
      },
    );
  }
}
