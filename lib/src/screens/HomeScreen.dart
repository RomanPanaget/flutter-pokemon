import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/components/DrawerTile.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Text("Home"),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Expanded(
                  child: DrawerHeader(
                child: Image(
                    image: AssetImage('assets/pokeball.png'), height: 44.0),
                margin: EdgeInsets.zero,
              ))
            ]),
            Expanded(
                child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                DrawerTile(
                    title: "Home",
                    icon: Icons.home,
                    onTap: () => Navigator.pop(context)),
                DrawerTile(
                    title: "Pokedex", icon: Icons.pets, path: "/pokedex"),
                DrawerTile(
                    title: "Search", icon: Icons.search, path: "/search"),
                DrawerTile(
                    title: "Favorites",
                    icon: Icons.favorite,
                    path: "/favorites"),
                DrawerTile(
                    title: "Settings", icon: Icons.settings, path: "/settings"),
              ],
            )),
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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 64, horizontal: 24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
              "Hey ! This app was made with Flutter, it basically requests the Pokémon API with a little bit of state management."),
          Padding(
              padding: EdgeInsets.all(24),
              child:
                  Image(image: AssetImage('assets/pokeball.png'), height: 120)),
          Text(
            'You can check the Github project of this app here',
          ),
          RaisedButton(
            child: Text("Github Project"),
            onPressed: () async {
              const String url =
                  "https://github.com/RomanPanaget/flutter-pokemon";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Seems that you can't launch the browser"),
                ));
              }
            },
          )
        ]),
      ),
    );
  }
}
