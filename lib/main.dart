import 'package:WaifuHub/pages/hub_comments_page.dart';
import 'package:flutter/material.dart';

import 'pages/hub_display_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/splash_page.dart';

void main() => runApp(SampleApp());

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaifuHub',
      home: SplashPage(),
      initialRoute: '/',
      // using generate route for comments to be able to pass
      // the hubId to the comment page
      onGenerateRoute: (RouteSettings settings) {
        print('build route for ${settings.name}');
        var routes = <String, WidgetBuilder>{
          CommentPage.routeName: (ctx) => CommentPage(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(
            settings: settings, builder: (ctx) => builder(ctx));
      },
      routes: {
        HubDisplay.routeName: (context) => HubDisplay(),
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
      },
    );
  }
}
