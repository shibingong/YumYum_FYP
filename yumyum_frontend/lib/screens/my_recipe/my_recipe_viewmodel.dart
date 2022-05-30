import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yumyumfyp/app/auth.dart';
import 'package:yumyumfyp/models/nutrition.dart';
import 'package:yumyumfyp/screens/add_recipe/add_recipe_view.dart';
import 'package:yumyumfyp/screens/add_recipe_feedback/add_recipe_feedback_viewmodel.dart';
import 'package:yumyumfyp/screens/recipe_details/recipe_details_view.dart';
import 'package:yumyumfyp/services/nutrition/nutrition_service.dart';
import 'package:yumyumfyp/services/recipe/recipe_service.dart';

import '../../app/dependencies.dart';
import '../../models/recipe.dart';
import '../viewmodel.dart';

String recipeName;
String recipeDescription;
List<String> steps;
List<String> ingredients;
String videoUrl;
List<String> type;
List<String> selectedType;
String recipeID;

class MyRecipeViewModel extends Viewmodel {
  List<Recipe> recipes = [];

  TextEditingController recipeNameController;
  TextEditingController recipeDescriptionController;
  TextEditingController videoUrlController;
  List<TextEditingController> stepsControllers;
  List<TextEditingController> ingredientsControllers;
  List<TextEditingController> ingredientsQuantityControllers;
  TextEditingController caloriesController;
  TextEditingController sugarController;
  TextEditingController fiberController;
  TextEditingController sodiumController;
  TextEditingController fatController;
  GlobalKey<FormState> formKey;
  int stepsNum;
  int ingredientsNum;
  List<Nutrition> nutrition = [];
  double totalCalories;
  double totalSugar;
  double totalFiber;
  double totalSodium;
  double totalFat;
  List<String> type = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Vegetarian",
    "Tea Time"
  ];
  List<String> selectedType = [];

  MyRecipeViewModel();
  RecipeService get dataService => dependency();
  AuthService get authService => dependency();
  NutritionService get nutriService => dependency();

  String tempImagePath;
  File tempImage;

  Future<void> getList() async {
    turnBusy();
    recipes = await dataService.getUserRecipeList();
    turnIdle();
  }

  void onListPressed(context, recipe) async {
    await Navigator.of(context).pushNamed(RecipeDetailsScreen.routeName,
        arguments: {'recipe': recipe});
    // getList();
  }

  Future<void> onRemovePressed(String recipeID) async {
    await dataService.deleteRecipe(recipeID);
    recipes = await dataService.getUserRecipeList();
    turnIdle();
  }

  void onPressFloatButton(context) async {
    var newRecipe = (await Navigator.of(context).pushNamed(
      AddRecipeScreen.routeName,
    ));
    if (newRecipe != null) {
      recipes.add(newRecipe);
    }
    turnIdle();
  }

  void editRecipeInit(Recipe recipe) async {
    recipeID = recipe.recipeId;
    stepsControllers = [];
    ingredientsControllers = [];
    ingredientsQuantityControllers = [];
    steps = [];
    ingredients = [];
    (recipe.steps.length == 0) ? stepsNum = 1 : stepsNum = recipe.steps.length;
    (recipe.ingredients.length == 0)
        ? ingredientsNum = 1
        : ingredientsNum = recipe.ingredients.length;

    for (int i = 0; i < stepsNum; i++) {
      // steps.add(recipe.steps[i]);
      stepsControllers.add(TextEditingController(text: recipe.steps[i]));
    }
    for (int i = 0; i < ingredientsNum; i++) {
      // ingredients.add(recipe.ingredients[i]);
      var ingredientsArray = recipe.ingredients[i].split(" of ");
      print(ingredientsArray[0]);
      ingredientsQuantityControllers
          .add(TextEditingController(text: ingredientsArray[0]));
      ingredientsControllers
          .add(TextEditingController(text: ingredientsArray[1]));
      ingredientsArray.clear();
    }
    recipeNameController = TextEditingController(text: recipe.recipeName);
    recipeDescriptionController =
        TextEditingController(text: recipe.recipeDescription);
    videoUrlController = TextEditingController(text: recipe.videoUrl);
    caloriesController = TextEditingController(text: recipe.calories);
    sugarController = TextEditingController(text: recipe.sugar);
    fiberController = TextEditingController(text: recipe.fiber);
    sodiumController = TextEditingController(text: recipe.sodium);
    fatController = TextEditingController(text: recipe.fat);
    formKey = GlobalKey<FormState>();

    selectedType.clear();
    for (int i = 0; i < recipe.types.length; i++) {
      selectedType.add(recipe.types[i]);
    }

    tempImage = null;
    tempImagePath = '';

    recipeName = recipe.recipeName;
    recipeDescription = recipe.recipeDescription;
    videoUrl = recipe.videoUrl;
    totalCalories = double.parse(recipe.calories);
    totalSugar = double.parse(recipe.sugar);
    totalFiber = double.parse(recipe.fiber);
    totalSodium = double.parse(recipe.sodium);
    totalFat = double.parse(recipe.fiber);
  }

  Future editRecipe(context) async {
    recipeName = recipeNameController.text;
    recipeDescription = recipeDescriptionController.text;
    videoUrl = videoUrlController.text;

    steps.clear();
    ingredients.clear();
    stepsControllers.forEach((element) => steps.add(element.text));
    // ingredientsControllers.forEach((element) => ingredients.add(element.text));
    for (int i = 0; i < ingredientsNum; i++) {
      ingredients.add(ingredientsQuantityControllers[i].text +
          " of " +
          ingredientsControllers[i].text);
    }

    turnBusy();
    // final Recipe updatedRecipe =
    await dataService.editRecipe(
        recipeID: recipeID,
        recipeName: recipeNameController.text,
        recipeDescription: recipeDescriptionController.text,
        types: selectedType,
        videoUrl: videoUrlController.text,
        steps: steps,
        ingredients: ingredients,
        calories: caloriesController.text,
        sugar: sugarController.text,
        fiber: fiberController.text,
        sodium: sodiumController.text,
        fat: fatController.text,
        imagefile: tempImage);
    // if (updatedRecipe != null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Recipe Updated Successsfully!')));
    Navigator.of(context).pop();
    // }
    getList();
    turnIdle();
  }

  Future chooseImage() async {
    final _picker = ImagePicker();
    XFile pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    //tempImagePath = pickedFile.path;
    if (pickedFile == null) {
      tempImage = null;
    } else {
      tempImage = File(pickedFile.path);
    }

    turnIdle();
    // return pickedFile;
  }

  void addStepsButtonOnPressed(int index) {
    stepsNum += 1;
    stepsControllers.add(TextEditingController());
    turnIdle();
  }

  void removeStepsButtonOnPressed(int index) {
    stepsNum -= 1;
    stepsControllers.removeAt(index);
    turnIdle();
  }

  void addIngredientsButtonOnPressed(int index) {
    ingredientsNum += 1;
    ingredientsControllers.add(TextEditingController());
    ingredientsQuantityControllers.add(TextEditingController());
    turnIdle();
  }

  void removeIngredientsButtonOnPressed(int index) {
    ingredientsNum -= 1;
    ingredientsControllers.removeAt(index);
    ingredientsQuantityControllers.removeAt(index);
    turnIdle();
  }

  Future<void> getNutrition() async {
    // ingredientsControllers.forEach((element) => ingredients.add(element.text));
    for (int i = 0; i < ingredientsNum; i++) {
      ingredients.add(ingredientsQuantityControllers[i].text +
          " of " +
          ingredientsControllers[i].text);
    }

    totalCalories = 0;
    totalSugar = 0;
    totalFiber = 0;
    totalSodium = 0;
    totalFat = 0;
    nutrition = await nutriService.getNutrition(ingredients.join(", "));
    nutrition.forEach((element) {
      totalCalories += double.parse(element.calories);
      totalSugar += double.parse(element.sugar);
      totalFiber += double.parse(element.fiber);
      totalSodium += double.parse(element.sugar);
      totalFat += double.parse(element.fat);
    });

    caloriesController.text = totalCalories.toStringAsFixed(2);
    sugarController.text = totalSugar.toStringAsFixed(2);
    fiberController.text = totalFiber.toStringAsFixed(2);
    sodiumController.text = totalSodium.toStringAsFixed(2);
    fatController.text = totalFat.toStringAsFixed(2);

    ingredients.clear();
    turnIdle();
  }

  void logOut() {
    authService.triggerLogOut();
  }
}
