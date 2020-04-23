import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PokedexScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pokedex")),
      body: Center(child: Text("Pokedex")),
    );
  }
}
