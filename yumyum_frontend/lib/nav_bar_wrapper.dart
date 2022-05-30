import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yumyumfyp/screens/add_recipe/add_recipe_view.dart';
import 'package:yumyumfyp/screens/home/home_view.dart';
import 'package:yumyumfyp/screens/main/main_view.dart';
import 'package:yumyumfyp/screens/my_profile/my_profile_view.dart';
import 'package:yumyumfyp/screens/my_recipe/my_recipe_view.dart';

class NavBarWrapper extends StatefulWidget {
  static MaterialPageRoute createRoute() =>
      MaterialPageRoute(builder: (_) => NavBarWrapper());
  @override
  _NavBarWrapperState createState() => _NavBarWrapperState();
}

class _NavBarWrapperState extends State<NavBarWrapper> {
  int _selectedIndex = 0;

  List _navBarItem = [
    {
      'icon': Icons.home,
      'label': 'Home',
      'Widget': HomeScreen(),
    },
    // {
    //   'icon': Icons.add,
    //   'label': 'New Recipe',
    //   'Widget': MainScreen(),
    // },
    {
      'icon': Icons.article,
      'label': 'My Recipe',
      'Widget': MyRecipeScreen(),
    },
    {
      'icon': Icons.person,
      'label': 'My Profile',
      'Widget': MyProfileScreen(),
    }
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navBarItem[_selectedIndex]['Widget'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(255, 204, 153, 1),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          ..._navBarItem.map((item) => BottomNavigationBarItem(
              icon: Icon(
                item['icon'],
              ),
              label: item['label']))
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Material(
  //     child: CupertinoTabScaffold(
  //         tabBar: CupertinoTabBar(
  //           currentIndex: _selectedIndex,
  //           onTap: _onItemTapped,
  //           items: <BottomNavigationBarItem>[
  //             ..._navBarItem.map((item) => BottomNavigationBarItem(
  //                 icon: Icon(
  //                   item['icon'],
  //                 ),
  //                 label: item['label']))
  //           ],
  //         ),
  //         tabBuilder: (BuildContext context, int index) {
  //           return CupertinoTabView(
  //             builder: (BuildContext context) {
  //               return SafeArea(
  //                 top: false,
  //                 bottom: false,
  //                 child: CupertinoApp(
  //                   home: CupertinoPageScaffold(
  //                     resizeToAvoidBottomInset: false,
  //                     child: _navBarItem[_selectedIndex]['Widget'],
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         }),
  //   );
  // }
}
