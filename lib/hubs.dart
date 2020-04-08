import 'package:WaifuHub/global/assets.dart';
import 'package:WaifuHub/models/waifu.dart';
import 'package:WaifuHub/widgets/waifuRow.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Key key;

  Home({this.key}) : super(key: key);

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
