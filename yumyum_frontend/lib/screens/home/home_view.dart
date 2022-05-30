import 'package:flutter/material.dart';
import 'package:yumyumfyp/screens/home/search_bar.dart';
import 'package:yumyumfyp/widgets/recipe_grid.dart';

import '../../app/dependencies.dart';
import '../view.dart';
import 'home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  static Route<dynamic> createRoute(args) =>
      MaterialPageRoute(builder: (_) => HomeScreen());

  HomeScreen();
  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<HomeViewModel>()..getList(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Home",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Pacifico',
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        viewmodel.onPressSearchBar(context);
                      },
                      child: Icon(Icons.search),
                    )),
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        viewmodel.logOut();
                      },
                      child: Icon(Icons.logout),
                    )),
              ],
            ),
            backgroundColor: Color.fromRGBO(255, 229, 204, 1),
            body: Container(
              child: Column(
                children: [
                  // SearchBar(
                  //   onPressSearchBar: viewmodel.onPressSearchBar,
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          viewmodel.busy
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : RecipeGrid(
                                  recipes: viewmodel.recipes,
                                  onCardPressed: viewmodel.onCardPressed,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
