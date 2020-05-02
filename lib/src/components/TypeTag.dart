import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/TypeModel.dart';

class TypeTag extends StatelessWidget {
  final String typeTitle;

  TypeTag({this.typeTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(typeTitle.toUpperCase()),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: TypesModel.colors[typeTitle],
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: Colors.white, width: 1)),
    );
  }
}
