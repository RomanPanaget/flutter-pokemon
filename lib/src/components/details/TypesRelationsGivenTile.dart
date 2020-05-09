import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/components/TypeTag.dart';
import 'package:flutterpokemon/src/models/TypeModel.dart';

class TypesRelationsGivenTile extends StatelessWidget {
  final TypeModel type;

  TypesRelationsGivenTile({this.type});

  Widget _buildTypesSet(Set<String> set, String text) {
    if (set.length == 0) return Row();
    return Padding(
        padding: EdgeInsets.all(6),
        child: Row(children: [
          Expanded(
              flex: 2,
              child: Center(
                  child: Column(children: [
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: text == "x2" ? Colors.green : Colors.red,
                ),
                Text(text, style: TextStyle(fontSize: 10)),
              ]))),
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: set
                        .map((type) => TypeTag(
                              name: type,
                              initial: true,
                            ))
                        .cast<Widget>()
                        .toList(),
                  )
                ],
              )),
        ]));
  }

  Widget _buildTo() {
    return Center(
        child: Column(
      children: <Widget>[
        _buildTypesSet(type.noDamageFrom, "x0"),
        _buildTypesSet(type.halfDamageFrom, "x0.5"),
        _buildTypesSet(type.doubleDamageFrom, "x2"),
      ],
    ));
  }

  Widget _buildType() {
    return Center(child: TypeTag(name: type.name));
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(flex: 1, child: _buildType()),
      Expanded(flex: 2, child: _buildTo())
    ]);
  }
}
