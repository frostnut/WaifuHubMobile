import 'package:WaifuHub/global/assets.dart';
import 'package:flutter/material.dart';
import 'package:WaifuHub/account.dart';
import 'package:WaifuHub/explore.dart';
import 'package:WaifuHub/hubs.dart';

/// bottom navigation bar that routes to hubs, explore and account
/// uses an index to select page, the initial value of _selectedIndex
/// determines the page that will start on opening of the application
/// or once the application is loaded if a splash screen is implemented
class BottomNavigationBarController extends StatefulWidget {
  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

/// control state that has a list of the states that the nav bar has
/// to add new tabs to the navbar, add a new state here then also add it
/// and a corresponding icon in the BottomNavigationBar widget
class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  int _selectedIndex = 1;
  final List<Widget> _children = [
    Hubs(),
    Explore(),
    Account(),
  ];

  void initState() {
    super.initState();
  }

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkPinkColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: darkPinkColor,
        selectedItemColor: itemSelectedColor,
        onTap: _onTapped,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Hubs'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text('Explore'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text('Account'),
          ),
        ],
      ),
    );
  }
}
