import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/components/settings/DarkModeSetting.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings";

  @override
  State<StatefulWidget> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          brightness: Theme.of(context).brightness,
        ),
        body: Column(children: [DarkModeSetting()]));
  }
}
