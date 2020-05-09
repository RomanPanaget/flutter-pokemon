import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final Widget child;

  InfoSection({this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 22),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).backgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 16, bottom: 16),
                child: Text(
                  this.title,
                  style: TextStyle(fontSize: 16),
                )),
            this.child
          ],
        ));
  }
}
