import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/TypeModel.dart';

class TypeTag extends StatelessWidget {
  final String name;
  final bool initial;

  TypeTag({this.name, this.initial = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        this.initial ? name.substring(0, 1).toUpperCase() : name.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.w600),
      )),
      margin: EdgeInsets.all(2),
      padding: this.initial
          ? null
          : EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      width: this.initial ? 26 : null,
      height: this.initial ? 26 : null,
      decoration: BoxDecoration(
          color: TypesModel.colors[name],
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: Colors.white.withOpacity(0.6), width: 2)),
    );
  }
}
