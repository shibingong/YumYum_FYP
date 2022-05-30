import 'package:flutter/material.dart';
import 'package:yumyumfyp/app/dependencies.dart';
import 'package:yumyumfyp/screens/search_recipe/search_recipe_viewmodel.dart';
import 'package:yumyumfyp/screens/view.dart';
import 'package:yumyumfyp/widgets/recipe_grid.dart';

class SearchRecipeScreen extends StatelessWidget {
  static const routeName = '/searchRecipe';
  static Route<dynamic> createRoute(args) =>
      MaterialPageRoute(builder: (_) => SearchRecipeScreen());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
      viewmodel: dependency<SearchRecipeViewModel>()..init(),
      builder: (context, viewmodel, _) => Scaffold(
        appBar: AppBar(
          // titleSpacing: 0,
          backgroundColor: Color.fromRGBO(255, 229, 204, 1),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Container(
            height: 40,
            child: TextFormField(
              // initialValue: viewmodel.searchProductName,
              // onFieldSubmitted: viewmodel.onSearchProductName,
              // style: TextStyle(fontSize: 12.0),
              onChanged: (value) {
                viewmodel.onSearchProductName(value);
              },
              cursorColor: Colors.deepOrange,
              //controller: viewmodel.searchBarController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(255, 229, 204, 1),
        body: Column(
          children: [
            // ConstrainedBox(
            //   constraints:
            //       BoxConstraints.expand(width: double.infinity, height: 50),
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //     color: Colors.white,
            //     child: ListView(
            //       scrollDirection: Axis.horizontal,
            //       children: [
            //         Row(
            //           children: [
            //             ...viewmodel.categories.map((category) {
            //               final index = viewmodel.categories.indexOf(category);
            //               return CategoryButton(
            //                   category,
            //                   index == viewmodel.selectedCategory,
            //                   (isSelected) =>
            //                       viewmodel.onCategoryChange(index));
            //             }).toList()
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: viewmodel.busy
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: RecipeGrid(
                          recipes: viewmodel.recipes,
                          onCardPressed: viewmodel.onCardPressed,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
