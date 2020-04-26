import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
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
                child: Image(
                    image: AssetImage(
                  'assets/pokeball.png'
                ), height: 44.0),
                margin: EdgeInsets.zero,
              ))
            ]),
            ListTile(
              leading: Icon(Icons.pets),
              title: Text("Pokedex"),
              onTap: () {
                Navigator.pushNamed(context, "/pokedex");
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text("Search"),
              onTap: () {
                Navigator.pushNamed(context, "/search");
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Favorites"),
              onTap: () {
                Navigator.pushNamed(context, "/favorites");
              },
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    icon: Icon(Icons.power_settings_new),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                  )),
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
