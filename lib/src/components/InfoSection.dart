import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String title;

  InfoSection({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 22),child: Row(
      children: <Widget>[
        Expanded(child: Divider(
          indent: 16,
          endIndent: 16,
          thickness: 1,
        )),
        Text(this.title),
        Expanded(child: Divider(
          indent: 16,
          endIndent: 16,
          thickness: 1,
        )),
      ],
    ));
  }
}
