class PokemonModel {
  int id;
  String name;

  PokemonModel({this.id, this.name});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
    );
  }
}