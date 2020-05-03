import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/components/TypeTag.dart';
import 'package:flutterpokemon/src/models/TypeModel.dart';

class TypesRelationsTakenTile extends StatelessWidget {
  final List<TypeModel> types;
  final TypeModel combination;

  TypesRelationsTakenTile({this.types, this.combination});

  _trios(list) =>
      list.isEmpty ? list : ([list.take(3)]..addAll(_trios(list.skip(3))));

  Widget _buildTypesSet(Set<String> set, String text) {
    if (set.length == 0) return Row();
    return Padding(
        padding: EdgeInsets.all(6),
        child: Row(children: [
          Expanded(
              child: Column(
            children: _trios(set)
                .map((trio) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: trio
                          .map((type) => TypeTag(
                                name: type,
                                initial: true,
                              ))
                          .cast<Widget>()
                          .toList(),
                    ))
                .cast<Widget>()
                .toList(),
          )),
          Center(
              child: Column(children: [
            Icon(Icons.arrow_forward, size: 16),
            Text(text, style: TextStyle(fontSize: 10)),
          ]))
        ]));
  }

  Widget _buildFrom() {
    return Column(
      children: <Widget>[
        _buildTypesSet(combination.noDamageFrom, "x0"),
        _buildTypesSet(combination.halfDamageFrom, "x0.5"),
        _buildTypesSet(combination.doubleDamageFrom, "x2"),
      ],
    );
  }

  Widget _buildType() {
    return Column(
        children: types
            .map((type) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(child: TypeTag(name: type.name)),
                  ],
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(child: _buildFrom()),
      Expanded(child: _buildType()),
    ]);
  }
}
