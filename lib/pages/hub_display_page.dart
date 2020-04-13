import 'package:flutter/material.dart';
import '../util/hub_display_screen_arguments.dart';

class HubDisplay extends StatelessWidget {
  static const routeName = '/hubdisplay';
  const HubDisplay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final HubDisplayScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.hubname),
      ),
      body: Center(
        child: Text(args.id),
      ),
    );
  }
}
