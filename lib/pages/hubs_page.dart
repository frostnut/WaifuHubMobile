import 'package:WaifuHub/global/assets.dart';
import 'package:WaifuHub/models/hub.dart';
import 'package:WaifuHub/widgets/hub_row.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Hubs is used to display all the user's hubs. This consists of the waifu
/// hub cards that they follow. For info on the waifu cards see waifuRow widget.
/// Also contains the appBar title that is displayed above the hubs.
class Hubs extends StatefulWidget {
  Hubs({Key key}) : super(key: key);

  @override
  _HubsState createState() => _HubsState();
}

class _HubsState extends State<Hubs> {
  var _waifuList = [];

  @override
  void initState() {
    super.initState();
    _genWaifuList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hubs"),
        backgroundColor: lightPinkColor,
      ),
      body: new ListView.builder(
        itemBuilder: (context, index) => new WaifuRow(_waifuList[index]),
        itemCount: _waifuList.length,
      ),
    );
  }

  /// fetches all hubs from the firestore database
  /// and adds them to the waifulist
  void _genWaifuList(BuildContext context) async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("hubs").getDocuments();
    List<Hub> waifuList = [];
    var list = querySnapshot.documents;
    for (var i = 0; i < list.length; ++i) {
      print(list[i].data);
      final data = list[i].data;
      Hub newHub = new Hub(
          hubname: data["hubname"],
          description: data["description"],
          commentIDs: data["comments"],
          id: data["id"],
          imageUrl: data["imageUrl"],
          likes: data["likes"]);
      waifuList.add(newHub);
    }
    setState(() {
      _waifuList = waifuList;
    });
  }
}
