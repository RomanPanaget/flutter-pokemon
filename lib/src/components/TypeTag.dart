import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/TypeModel.dart';

class TypeTag extends StatelessWidget {
  final String name;
  final bool initial;

  TypeTag({this.name, this.initial = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child: Center(
              child: Text(
            this.initial
                ? name.substring(0, 1).toUpperCase()
                : name.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
          padding: this.initial
              ? null
              : EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          width: this.initial ? 24 : 100,
          height: this.initial ? 24 : null,
          decoration: BoxDecoration(
            color: TypesModel.colors[name],
            borderRadius: BorderRadius.all(Radius.circular(100)),
          )),
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: TypesModel.colors[name].withOpacity(0.6),
          borderRadius: BorderRadius.all(Radius.circular(100))),
    );
  }
}

class CombinedTypeTag extends StatelessWidget {
  final List<String> names;

  CombinedTypeTag({this.names});

  _buildBorderRadius(int index) {
    return BorderRadius.only(
        topLeft: Radius.circular(index == 0 ? 14 : 0),
        topRight: Radius.circular(index == 0 ? 14 : 0),
        bottomLeft: Radius.circular(index == names.length - 1 ? 14 : 0),
        bottomRight: Radius.circular(index == names.length - 1 ? 14 : 0));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: names
            .asMap()
            .map((index, String name) => MapEntry(
                index,
                Container(
                  width: 100,
                  child: Container(
                      child: Center(
                          child: Text(
                        name.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: TypesModel.colors[name],
                          borderRadius: _buildBorderRadius(index))),
                  padding: EdgeInsets.only(
                      left: 2,
                      right: 2,
                      top: index == 0 ? 2 : 0,
                      bottom: index == names.length - 1 ? 2 : 0),
                  decoration: BoxDecoration(
                      color: TypesModel.colors[name].withOpacity(0.6),
                      borderRadius: _buildBorderRadius(index)),
                )))
            .values
            .toList());
  }
}
