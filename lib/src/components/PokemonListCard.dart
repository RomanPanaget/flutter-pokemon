import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/PokemonModel.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonListCard extends StatefulWidget {
  final PokemonModel pokemon;
  final bool isFav;
  final Function onFavPressed;

  PokemonListCard(
      {Key key,
      @required this.pokemon,
      @required this.isFav,
      @required this.onFavPressed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PokemonListCardState();
}

class _PokemonListCardState extends State<PokemonListCard>
    with SingleTickerProviderStateMixin {
  bool _favTapped;
  AnimationController _controller;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _favTapped = false;
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _opacity = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)));
  }

  _toggleFav() {
    _favTapped = true;
    widget.onFavPressed();
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/detail",
              arguments: Future.value(widget.pokemon));
        },
        onDoubleTap: () {
          setState(() {
            _toggleFav();
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 21),
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.05))
            ],
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
                                    opacity: _favTapped && widget.isFav
                                        ? _opacity.value
                                        : 0,
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
                                widget.isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border,
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
