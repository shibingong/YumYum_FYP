import 'dart:convert';
import 'dart:io';

import 'package:yumyumfyp/services/recipe/recipe_service.dart';

import '../../app/dependencies.dart';
import '../../models/recipe.dart';
import '../rest.dart';

class RecipeServiceRest implements RecipeService {
  final rest = dependency<RestService>();
  Future<List<Recipe>> getRecipeList() async {
    var jsonResult = await rest.get('recipe');

    List<Recipe> recipeList =
        (jsonResult as List).map((json) => Recipe.fromJson(json)).toList();
    return recipeList;
  }

  Future<List<Recipe>> getUserRecipeList() async {
    var jsonResult = await rest.get('recipe/user');

    List<Recipe> recipeList =
        (jsonResult as List).map((json) => Recipe.fromJson(json)).toList();

    recipeList.forEach((element) {
      print(element.recipeImage);
    });
    return recipeList;
  }

  Future<Recipe> addRecipe(
      {String recipeName,
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
      String cholesterol,
      String protein,
      String carbohydrates,
      File imagefile}) async {
    String base64Image = base64Encode(imagefile.readAsBytesSync());
    String fileName = imagefile.path.split("/").last;

    final json = await rest.post('recipe/', data: {
      'recipeName': recipeName,
      'recipeDescription': recipeDescription,
      'types': types,
      'videoUrl': videoUrl,
      'steps': steps,
      'ingredients': ingredients,
      'calories': calories,
      'sugar': sugar,
      'fiber': fiber,
      'sodium': sodium,
      'fat': fat,
      'cholesterol': cholesterol,
      'protein': protein,
      'carbohydrates': carbohydrates,
      'image': base64Image,
      'imgName': fileName
    });
    // print(json);
    return Recipe.fromJson(json);
  }

  Future deleteRecipe(String recipeID) async {
    await rest.delete('recipe/$recipeID');
  }

  Future<List<Recipe>> searchRecipe(String recipeName) async {
    var jsonResult = await rest.get('recipe?recipeName=' + recipeName);

    List<Recipe> recipeList =
        (jsonResult as List).map((json) => Recipe.fromJson(json)).toList();
    return recipeList;
  }

  Future editRecipe(
      {String recipeID,
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
      String cholesterol,
      String protein,
      String carbohydrates,
      File imagefile}) async {
    var json = null;
    if (imagefile != null) {
      String base64Image = base64Encode(imagefile.readAsBytesSync());
      String fileName = imagefile.path.split("/").last;
      json = await rest.put('recipe/' + recipeID, data: {
        'recipeName': recipeName,
        'recipeDescription': recipeDescription,
        'types': types,
        'videoUrl': videoUrl,
        'steps': steps,
        'ingredients': ingredients,
        'nutrition.calories': calories,
        'nutrition.sugar': sugar,
        'nutrition.fiber': fiber,
        'nutrition.sodium': sodium,
        'nutrition.fat': fat,
        'nutrition.cholesterol': cholesterol,
        'nutrition.protein': protein,
        'nutrition.carbohydrates': carbohydrates,
        'image': base64Image,
        'imgName': fileName
      });
    } else {
      json = await rest.put('recipe/' + recipeID, data: {
        'recipeName': recipeName,
        'recipeDescription': recipeDescription,
        'types': types,
        'videoUrl': videoUrl,
        'steps': steps,
        'ingredients': ingredients,
        'nutrition.calories': calories,
        'nutrition.sugar': sugar,
        'nutrition.fiber': fiber,
        'nutrition.sodium': sodium,
        'nutrition.fat': fat,
        'nutrition.cholesterol': cholesterol,
        'nutrition.protein': protein,
        'nutrition.carbohydrates': carbohydrates,
        'image': '',
        'imgName': ''
      });
    }

    print(json);
    // return Recipe.fromJson(json);
  }
}
