import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Expanded(
                  child: DrawerHeader(
                child: Text("Drawer header"),
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(color: Colors.blue),
              ))
            ]),
            ListTile(
              title: Text("Search Pokemon"),
              onTap: () {
                Navigator.pushNamed(context, "/search");
              },
            ),
            ListTile(
              title: Text("Pokedex"),
              onTap: () {
                Navigator.pushNamed(context, "/pokedex");
              },
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.bottomCenter, child: IconButton(icon: Icon(Icons.power_settings_new), onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
              },)),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
