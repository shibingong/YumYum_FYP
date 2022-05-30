import 'package:flutter/material.dart';
import 'package:yumyumfyp/models/recipe.dart';
import 'package:yumyumfyp/screens/recipe_details/recipe_details_view.dart';
import 'package:yumyumfyp/services/recipe/recipe_service.dart';

import '../../app/dependencies.dart';
import '../viewmodel.dart';

class SearchRecipeViewModel extends Viewmodel {
  //const here
  List<String> categories = const [
    'All',
    'Sneaker',
    'Cap',
    'Shirt',
    'Pants',
    'Cardholder'
  ];

  RecipeService get dataService => dependency();

  //states here
  List<Recipe> recipes;

  Map<String, String> queryMap = {};
  String queryName = "";

  void init() async {
    // selectedCategory =
    //     categories.indexWhere((_category) => _category == category);

    // queryMap['category'] = categories[selectedCategory];
    turnBusy();
    recipes = await dataService.getRecipeList();
    turnIdle();
  }

  Future<void> getList() async {
    turnBusy();
    recipes = await dataService.getRecipeList();
    turnIdle();
  }

  void onSearchProductName(String productName) async {
    queryMap['productName'] = productName;
    // turnBusy();
    recipes = await dataService.searchRecipe(productName);
    turnIdle();
  }

  // void onCategoryChange(int index) async {
  //   if (index == selectedCategory) return;

  //   selectedCategory = index;
  //   queryMap['category'] = categories[index];
  //   if ((index == 0)) queryMap['category'] = '';
  //   turnBusy();
  //   auctions = await dataService.getAuctionList(queryMap);
  //   turnIdle();
  // }

  void onCardPressed(context, recipe) async {
    await Navigator.of(context).pushNamed(RecipeDetailsScreen.routeName,
        arguments: {'recipe': recipe});
    // getList();
  }
}
