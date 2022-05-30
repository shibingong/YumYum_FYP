import 'dart:io';

import '../../models/recipe.dart';

abstract class RecipeService {
  Future<List<Recipe>> getRecipeList();
  Future<List<Recipe>> getUserRecipeList();
  Future<Recipe> addRecipe({
    String recipeName,
    String recipeDescription,
    List<String> types,
    String videoUrl,
    List<String> steps,
    List<String> ingredients,
    String calories,
    String sugar,
    String fiber,
    String sodium,
    String fat,
    File imagefile,
  });
  Future deleteRecipe(String recipeID);
  Future<List<Recipe>> searchRecipe(String recipeName);
  Future editRecipe({
    String recipeID,
    String recipeName,
    String recipeDescription,
    List<String> types,
    String videoUrl,
    List<String> steps,
    List<String> ingredients,
    String calories,
    String sugar,
    String fiber,
    String sodium,
    String fat,
    File imagefile,
  });
}
