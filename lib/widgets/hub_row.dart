import 'package:WaifuHub/global/assets.dart';
import 'package:WaifuHub/pages/hub_display_page.dart';
import 'package:flutter/material.dart';
import 'package:WaifuHub/models/hub.dart';
import '../util/hub_display_screen_arguments.dart';

// used to put space between objects
const double separatorDist = 10.0;
// used to determine size of waifu avatar pic size on the card
const double waifuAvatarRadius = 50.0;
// used to determine the icon size for likes and comments
const double iconsSize = 20.0;
const double iconContainerWidth = iconsSize / 2;

/// WaifuRow is the widget used to load the waifu cards
/// like the ones on the explore and hubs tabs
/// Accepts a waifu as a field. This field is used to
/// generate the card
class WaifuRow extends StatelessWidget {
  final Hub hub;

  WaifuRow(this.hub);

  @override
  Widget build(BuildContext context) {
    final _waifuThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new CircleAvatar(
        backgroundImage: new NetworkImage(hub.imageUrl),
        radius: waifuAvatarRadius,
        backgroundColor: Colors.transparent,
      ),
    );

    /// _waifuValue is used to load the likes and comments badges and values
    /// accepts Value string which is the number that will be displayed next
    /// to the icon and accepts the String image path, the path to the image
    /// of the icon
    Widget _waifuValue({String value, String image}) {
      return new Row(children: <Widget>[
        new Image.asset(image, height: iconsSize),
        new Container(width: iconContainerWidth),
        new Text(
          value,
          style: TextStyle(color: Colors.white),
        ),
      ]);
    }

    /// _waifuCardContent is used to generate the content of the waifu card
    /// the new containers with height 10 are used to make space between
    /// contents. This can all possibly replaced with media queries to make
    /// sure that the app is fully responsive
    final _waifuCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(80.0, 18.0, 20.0, 20.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 3.0),
          new Text(
            hub.hubname,
            style: TextStyle(color: Colors.white),
          ),
          new Container(height: separatorDist),
          new Container(height: separatorDist),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: _waifuValue(
                      value: hub.likes.toString(),
                      image: 'assets/img/icons/ic_likes.png')),
              new Expanded(
                  child: _waifuValue(
                      value: hub.commentIDs.length.toString(),
                      image: 'assets/img/icons/ic_comments.png'))
            ],
          ),
        ],
      ),
    );

    /// _waifuCard generates the actual rectangular card
    final _waifuCard = new Container(
      child: _waifuCardContent,
      height: 130.0,
      // how much card goes under the avatar image
      margin: new EdgeInsets.only(left: 30.0),
      decoration: new BoxDecoration(
        color: lightPinkColor,
        shape: BoxShape.rectangle,
        // how much circular effect there is on edges of the card
        borderRadius: new BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          // gives the cards a shadow effect
          new BoxShadow(
            // color of the shadow
            color: darkPinkColor,
            // level of blur of the shadow
            blurRadius: 20.0,
            // offset controls where shadow is displayed
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    // tie it all together and return waifu card with a thumbnail
    return new Container(
      height: 130.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          InkWell(
            child: _waifuCard,
            onTap: () {
              Navigator.pushNamed(
                context,
                HubDisplay.routeName,
                arguments: HubDisplayScreenArguments(
                  hub.id,
                  hub.commentIDs,
                  hub.hubname,
                  hub.description,
                  hub.imageUrl,
                ),
              );
            },
          ),
          _waifuThumbnail,
        ],
      ),
    );
  }
}
