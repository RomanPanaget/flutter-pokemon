import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/components/TypeTag.dart';
import 'package:flutterpokemon/src/models/TypeModel.dart';

class TypesRelationsTakenTile extends StatelessWidget {
  final List<TypeModel> types;
  final TypeModel combination;

  TypesRelationsTakenTile({this.types, this.combination});

  Widget _buildTypesSet(Set<String> set, String text) {
    if (set.length == 0) return Row();
    return Padding(
        padding: EdgeInsets.all(6),
        child: Row(children: [
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
          Expanded(
              flex: 2,
              child: Center(
                  child: Column(children: [
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: text == "x2" ? Colors.red : Colors.green,
                ),
                Text(text, style: TextStyle(fontSize: 10)),
              ])))
        ]));
  }

  Widget _buildFrom() {
    return Center(
        child: Column(
      children: <Widget>[
        _buildTypesSet(combination.noDamageFrom, "x0"),
        _buildTypesSet(combination.halfDamageFrom, "x0.5"),
        _buildTypesSet(combination.doubleDamageFrom, "x2"),
      ],
    ));
  }

  Widget _buildType() {
    return Center(
        child: CombinedTypeTag(
      names: types.map((type) => type.name).toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(flex: 2, child: _buildFrom()),
      Expanded(flex: 1, child: _buildType()),
    ]);
  }
}
