import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/FavoritesModel.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonListCard extends StatefulWidget {
  final PokemonModel pokemon;

  PokemonListCard({Key key, @required this.pokemon}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PokemonListCardState();
}

class _PokemonListCardState extends State<PokemonListCard>
    with SingleTickerProviderStateMixin {
  bool _fav;
  bool _favTapped;
  AnimationController _controller;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _favTapped = false;
    _fav = Provider.of<FavoritesModel>(context, listen: false)
        .isFavorite(widget.pokemon.id);
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _opacity = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)));
  }

  _toggleFav() {
    _fav = !_fav;
    _favTapped = true;
    if (_fav)
      Provider.of<FavoritesModel>(context, listen: false)
          .add(widget.pokemon.id);
    else
      Provider.of<FavoritesModel>(context, listen: false)
          .remove(widget.pokemon.id);
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward(from: 0);
    return GestureDetector(
        onDoubleTap: () {
          setState(() {
            _toggleFav();
          });
        },
        child: Card(
          elevation: 8,
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  "#${widget.pokemon.id}",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      height: 200,
                      child: Stack(children: [
                        Center(
                            child: FadeInImage(
                                placeholder: MemoryImage(kTransparentImage),
                                image: NetworkImage(
                                  "https://pokeres.bastionbot.org/images/pokemon/${widget.pokemon.id}.png",
                                ))),
                        AnimatedBuilder(
                            animation: _controller,
                            builder: (BuildContext context, Widget child) =>
                                Opacity(
                                    opacity:
                                        _favTapped && _fav ? _opacity.value : 0,
                                    child: Center(
                                        child: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 100,
                                    ))))
                      ])),
                  Divider(
                    color: Colors.red,
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 0,
                                child: Text(
                                  widget.pokemon.name.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20, letterSpacing: 1.5),
                                )),
                            IconButton(
                              icon: Icon(
                                _fav ? Icons.favorite : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  _toggleFav();
                                });
                              },
                            )
                          ]))
                ],
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
