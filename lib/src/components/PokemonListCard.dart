import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonListCard extends StatefulWidget {
  final PokemonModel pokemon;

  PokemonListCard({this.pokemon});

  @override
  State<StatefulWidget> createState() => _PokemonListCardState();
}

class _PokemonListCardState extends State<PokemonListCard>
    with SingleTickerProviderStateMixin {
  bool _fav;
  AnimationController _controller;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _fav = false;
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _opacity = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)));
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward(from: 0);
    return GestureDetector(
        onDoubleTap: () {
          setState(() {
            _fav = !_fav;
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
                                    opacity: _opacity.value,
                                    child: Center(
                                        child: Icon(
                                      _fav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
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
                                  _fav = !_fav;
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
