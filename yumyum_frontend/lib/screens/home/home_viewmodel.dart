import 'package:flutter/material.dart';
import 'package:yumyumfyp/app/auth.dart';
import 'package:yumyumfyp/screens/recipe_details/recipe_details_view.dart';
import 'package:yumyumfyp/screens/search_recipe/search_recipe_view.dart';
import 'package:yumyumfyp/services/recipe/recipe_service.dart';

import '../../app/dependencies.dart';
import '../../models/recipe.dart';
import '../viewmodel.dart';

class HomeViewModel extends Viewmodel {
  List<Recipe> recipes = [];
  HomeViewModel();
  RecipeService get dataService => dependency();
  AuthService get authService => dependency();

  Future<void> getList() async {
    turnBusy();
    recipes = await dataService.getRecipeList();
    // recipes.forEach((element) => print(element.calories));
    turnIdle();
  }

  void onCardPressed(context, recipe) async {
    await Navigator.of(context).pushNamed(RecipeDetailsScreen.routeName,
        arguments: {'recipe': recipe});
    // getList();
  }

  void onPressSearchBar(context) async {
    await Navigator.of(context).pushNamed(
      SearchRecipeScreen.routeName,
    );
    // getList();
  }

  void logOut() {
    authService.triggerLogOut();
  }
}
