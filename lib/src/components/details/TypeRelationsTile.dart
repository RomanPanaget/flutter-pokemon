import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/components/TypeTag.dart';
import 'package:flutterpokemon/src/models/TypeModel.dart';

class TypesRelationsTile extends StatelessWidget {
  final TypeModel type;

  TypesRelationsTile({this.type});

  _pairs(list) =>
      list.isEmpty ? list : ([list.take(2)]..addAll(_pairs(list.skip(2))));

  Widget _buildTypesSet(Set<String> set, String text, {bool taken}) {
    if (set.length == 0) return Row();
    List<Widget> children = [
      Expanded(
          flex: 5,
          child: Column(
            children: [
              Column(
                children: _pairs(set)
                    .map((pair) => Row(
                        mainAxisAlignment: taken
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: pair
                            .map((type) => TypeTag(
                                  name: type,
                                  initial: true,
                                ))
                            .cast<Widget>()
                            .toList()))
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
              color: text == "x2"
                  ? taken ? Colors.red : Colors.green
                  : taken ? Colors.green : Colors.red,
            ),
            Text(text, style: TextStyle(fontSize: 10)),
          ])))
    ];
    return Padding(
        padding: EdgeInsets.all(6),
        child: Row(children: taken ? children : children.reversed.toList()));
  }

  Widget _buildFrom() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildTypesSet(type.noDamageFrom, "x0", taken: true),
        _buildTypesSet(type.halfDamageFrom, "x0.5", taken: true),
        _buildTypesSet(type.doubleDamageFrom, "x2", taken: true),
      ],
    );
  }

  Widget _buildTo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildTypesSet(type.noDamageTo, "x0", taken: false),
        _buildTypesSet(type.halfDamageTo, "x0.5", taken: false),
        _buildTypesSet(type.doubleDamageTo, "x2", taken: false),
      ],
    );
  }

  Widget _buildType() {
    return Center(child: TypeTag(name: type.name));
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(flex: 3, child: _buildFrom()),
      Expanded(flex: 2, child: _buildType()),
      Expanded(flex: 3, child: _buildTo()),
    ]);
  }
}
