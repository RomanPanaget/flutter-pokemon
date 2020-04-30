class EvolutionChainModel {
  final int id;
  final String url;
  final EvolutionChain evolutionChain;

  EvolutionChainModel({this.id, this.url, this.evolutionChain});

  factory EvolutionChainModel.fromJson(Map<String, dynamic> json) {
    return EvolutionChainModel(
        id: json['id'], evolutionChain: EvolutionChain.fromJson(json['chain']));
  }
}

class EvolutionChain {
  List<EvolutionChain> evolvesTo;
  List<EvolutionDetails> evolutionDetails;
  String name;
  int id;

  EvolutionChain({this.name, this.evolvesTo, this.evolutionDetails, this.id});

  factory EvolutionChain.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> evolutionChains =
        json['evolves_to'].cast<Map<String, dynamic>>();
    List<Map<String, dynamic>> evolutionDetails =
        json['evolution_details'].cast<Map<String, dynamic>>();
    List<String> urlSplit = json['species']['url'].split("/");
    return EvolutionChain(
        name: json['species']['name'],
        id: int.parse(urlSplit[urlSplit.length - 2]),
        evolutionDetails: evolutionDetails.map((evolutionDetailsJson) {
          return EvolutionDetails.fromJson(evolutionDetailsJson);
        }).toList(),
        evolvesTo: evolutionChains.map((evolutionChainJson) {
          return EvolutionChain.fromJson(evolutionChainJson);
        }).toList());
  }
}

class EvolutionDetails {
  final int minLevel;

  EvolutionDetails({this.minLevel});

  factory EvolutionDetails.fromJson(Map<String, dynamic> json) {
    return EvolutionDetails(minLevel: json['minLevel']);
  }
}
