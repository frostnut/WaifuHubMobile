import 'package:WaifuHub/global/assets.dart';
import 'package:WaifuHub/models/waifu.dart';
import 'package:WaifuHub/widgets/waifuRow.dart';
import 'package:flutter/material.dart';

/// Hubs is used to display all the user's hubs. This consists of the waifu
/// hub cards that they follow. For info on the waifu cards see waifuRow widget.
/// Also contains the appBar title that is displayed above the hubs.
class Hubs extends StatelessWidget {
  final Key key;

  Hubs({this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "WaifuHubs",
          style: headingLarge,
        ),
      ),
      body: new ListView.builder(
        itemBuilder: (context, index) => new WaifuRow(waifuList[index]),
        itemCount: waifuList.length,
      ),
    );
  }
}
