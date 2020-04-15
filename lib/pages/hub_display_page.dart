import 'package:WaifuHub/global/assets.dart';
import 'package:WaifuHub/util/hub_display_screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HubDisplay extends StatefulWidget {
  static const routeName = '/hubdisplay';
  const HubDisplay({Key key}) : super(key: key);

  @override
  _HubDisplayState createState() => _HubDisplayState();
}

class _HubDisplayState extends State<HubDisplay> {
  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final HubDisplayScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: args.imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image(
                        image: NetworkImage(args.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: lightPinkColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.thumb_up),
                          iconSize: 30.0,
                          color: lightPinkColor,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.comment),
                          iconSize: 25.0,
                          color: lightPinkColor,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      args.hubname,
                      style: headingLarge,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        args.description,
                        style: textStandard,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        args.description,
                        style: textStandard,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
