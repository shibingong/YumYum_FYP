import 'package:flutter/material.dart';
import 'package:yumyumfyp/widgets/my_recipe_list.dart';
import 'package:yumyumfyp/widgets/recipe_grid.dart';

import '../../app/dependencies.dart';
import '../view.dart';
import 'my_recipe_viewmodel.dart';

class MyRecipeScreen extends StatelessWidget {
  static const routeName = '/my_recipe';
  static Route<dynamic> createRoute(args) =>
      MaterialPageRoute(builder: (_) => MyRecipeScreen());

  MyRecipeScreen();
  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<MyRecipeViewModel>()..getList(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "My Recipe",
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
                        viewmodel.logOut();
                      },
                      child: Icon(Icons.logout),
                    )),
              ],
            ),
            // extendBodyBehindAppBar: true,
            backgroundColor: Color.fromRGBO(255, 229, 204, 1),
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          viewmodel.busy
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : MyRecipeList(
                                  recipes: viewmodel.recipes,
                                  onListPressed: viewmodel.onListPressed,
                                  onRemovePressed: viewmodel.onRemovePressed,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: Text('New Recipe'),
              onPressed: () => viewmodel.onPressFloatButton(context),
              icon: Icon(
                Icons.add,
                size: 35,
                color: Colors.white,
              ),
              backgroundColor: Color.fromRGBO(255, 178, 102, 1),
            ),
          );
        });
  }
}
