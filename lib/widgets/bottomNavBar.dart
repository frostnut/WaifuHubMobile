import 'package:flutter/material.dart';
import 'package:WaifuHub/account.dart';
import 'package:WaifuHub/explore.dart';
import 'package:WaifuHub/hubs.dart';
import 'package:WaifuHub/global/assets.dart';

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
/// and a corresponding icon in the _bottomNavigationBar widget
class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  final List<Widget> pages = [
    Hubs(
      key: PageStorageKey('Hubs'),
    ),
    Explore(
      key: PageStorageKey('Explore'),
    ),
    Account(
      key: PageStorageKey('Account'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 1;

  /// widget that is shown on screen and the icons
  /// accepts a selection index that decides what tab is being selected
  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        unselectedItemColor: darkPinkColor,
        selectedItemColor: itemSelectedColor,
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
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
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
