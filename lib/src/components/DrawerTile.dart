import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String path;
  final Function onTap;

  DrawerTile(
      {Key key,
      @required this.icon,
      @required this.title,
      this.path,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        this.icon,
        color: Theme.of(context).accentColor,
      ),
      title: Text(
        this.title,
        style: TextStyle(fontSize: 16),
      ),
      onTap: this.path != null
          ? () {
              Navigator.pushNamed(context, this.path);
            }
          : this.onTap,
    );
  }
}
