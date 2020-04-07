import 'package:WaifuHub/global/assets.dart';
import 'package:flutter/material.dart';
import 'package:WaifuHub/models/waifu.dart';

class WaifuRow extends StatelessWidget {
  final Waifu waifu;

  WaifuRow(this.waifu);

  @override
  Widget build(BuildContext context) {
    final waifuThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new CircleAvatar(
        backgroundImage: new AssetImage(waifu.image),
        radius: 50,
        backgroundColor: Colors.transparent,
      ),
    );

    Widget _waifuValue({String value, String image}) {
      return new Row(children: <Widget>[
        new Image.asset(image, height: 12.0),
        new Container(width: 8.0),
        new Text(
          value,
          style: TextStyle(color: Colors.white),
        ),
      ]);
    }

    final waifuCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 20.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(
            waifu.name,
            style: TextStyle(color: Colors.white),
          ),
          new Container(height: 10.0),
          Text(
            waifu.anime,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            waifu.description,
            style: TextStyle(color: Colors.white),
          ),
          new Container(height: 15),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: _waifuValue(
                      value: waifu.likes.toString(),
                      image: 'assets/img/icons/ic_likes.png')),
              new Expanded(
                  child: _waifuValue(
                      value: waifu.comments.toString(),
                      image: 'assets/img/icons/ic_comments.png'))
            ],
          ),
        ],
      ),
    );

    final waifuCard = new Container(
      child: waifuCardContent,
      height: 130.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: lightPinkColor,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return new Container(
        height: 130.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            waifuCard,
            waifuThumbnail,
          ],
        ));
  }
}
