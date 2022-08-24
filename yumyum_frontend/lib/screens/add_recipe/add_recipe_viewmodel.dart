import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:yumyumfyp/models/nutrition.dart';
import 'package:yumyumfyp/models/recipe.dart';
import 'package:yumyumfyp/services/nutrition/nutrition_service.dart';
import 'package:yumyumfyp/services/recipe/recipe_service.dart';

import '../../app/dependencies.dart';
import '../viewmodel.dart';

String recipeName;
String recipeDescription;
List<String> steps;
List<String> ingredients;
String videoUrl;
List<String> type;
List<String> selectedType;

class AddRecipeViewModel extends Viewmodel {
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
  TextEditingController cholesterolController;
  TextEditingController proteinController;
  TextEditingController carbohydratesController;
  GlobalKey<FormState> formKey;
  int stepsNum;
  int ingredientsNum;
  List<Nutrition> nutrition = [];
  double totalCalories;
  double totalSugar;
  double totalFiber;
  double totalSodium;
  double totalFat;
  double totalCholesterol;
  double totalProtein;
  double totalCarbohydrates;

  List<String> type = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Vegetarian",
    "Tea Time"
  ];
  List<String> selectedType = [];

  RecipeService get dataService => dependency();
  NutritionService get nutriService => dependency();

  String tempImagePath;
  File tempImage;

  AddRecipeViewModel();

  void init() async {
    stepsControllers = [];
    ingredientsControllers = [];
    ingredientsQuantityControllers = [];
    steps = [];
    ingredients = [];
    recipeNameController = TextEditingController();
    recipeDescriptionController = TextEditingController();
    videoUrlController = TextEditingController();
    formKey = GlobalKey<FormState>();
    stepsNum = 1;
    ingredientsNum = 1;
    for (int i = 0; i < stepsNum; i++) {
      stepsControllers.add(TextEditingController());
    }
    for (int i = 0; i < ingredientsNum; i++) {
      ingredientsControllers.add(TextEditingController());
      ingredientsQuantityControllers.add(TextEditingController());
    }
    caloriesController = TextEditingController();
    sugarController = TextEditingController();
    fiberController = TextEditingController();
    sodiumController = TextEditingController();
    fatController = TextEditingController();
    cholesterolController = TextEditingController();
    proteinController = TextEditingController();
    carbohydratesController = TextEditingController();

    tempImage = null;
    tempImagePath = '';
  }

  Future<void> addRecipe(context) async {
    turnBusy();
    recipeName = recipeNameController.text;
    recipeDescription = recipeDescriptionController.text;
    videoUrl = videoUrlController.text;

    stepsControllers.forEach((element) => steps.add(element.text));
    // ingredientsControllers.forEach((element) => ingredients.add(element.text));
    for (int i = 0; i < ingredientsNum; i++) {
      if (ingredientsQuantityControllers[i]
          .text
          .contains(new RegExp(r'^[0-9]+$'))) {
        ingredients.add(ingredientsQuantityControllers[i].text +
            " " +
            ingredientsControllers[i].text);
      } else {
        ingredients.add(ingredientsQuantityControllers[i].text +
            " of " +
            ingredientsControllers[i].text);
      }
    }
    print(ingredients);

    final Recipe newRecipe = await dataService.addRecipe(
        recipeName: recipeName,
        recipeDescription: recipeDescription,
        types: selectedType,
        videoUrl: videoUrl,
        steps: steps,
        ingredients: ingredients,
        calories: totalCalories.toStringAsFixed(2),
        sugar: totalSugar.toStringAsFixed(2),
        fiber: totalFiber.toStringAsFixed(2),
        sodium: totalSodium.toStringAsFixed(2),
        fat: totalFat.toStringAsFixed(2),
        cholesterol: totalCholesterol.toStringAsFixed(2),
        protein: totalProtein.toStringAsFixed(2),
        carbohydrates: totalCarbohydrates.toStringAsFixed(2),
        imagefile: tempImage);
    if (newRecipe != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Recipe Added Successsfully!')));
      Navigator.of(context).pop(newRecipe);
    }
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
    // print("total ingredients => ${ingredientsNum}");
    for (int i = 0; i < ingredientsNum; i++) {
      if (ingredientsQuantityControllers[i]
          .text
          .contains(new RegExp(r'^[0-9]+$'))) {
        ingredients.add(ingredientsQuantityControllers[i].text +
            " " +
            ingredientsControllers[i].text);
      } else {
        ingredients.add(ingredientsQuantityControllers[i].text +
            " of " +
            ingredientsControllers[i].text);
      }
    }
    print(ingredients.join(", "));
    totalCalories = 0;
    totalSugar = 0;
    totalFiber = 0;
    totalSodium = 0;
    totalFat = 0;
    totalCholesterol = 0;
    totalProtein = 0;
    totalCarbohydrates = 0;
    nutrition = await nutriService.getNutrition(ingredients.join(", "));
    nutrition.forEach((element) {
      totalCalories += double.parse(element.calories);
      totalSugar += double.parse(element.sugar);
      totalFiber += double.parse(element.fiber);
      totalSodium += double.parse(element.sugar);
      totalFat += double.parse(element.fat);
      totalCholesterol += double.parse(element.cholesterol);
      totalProtein += double.parse(element.protein);
      totalCarbohydrates += double.parse(element.carbohydrates);
    });

    caloriesController.text = totalCalories.toStringAsFixed(2);
    sugarController.text = totalSugar.toStringAsFixed(2);
    fiberController.text = totalFiber.toStringAsFixed(2);
    sodiumController.text = totalSodium.toStringAsFixed(2);
    fatController.text = totalFat.toStringAsFixed(2);
    cholesterolController.text = totalCholesterol.toStringAsFixed(2);
    proteinController.text = totalProtein.toStringAsFixed(2);
    carbohydratesController.text = totalCarbohydrates.toStringAsFixed(2);

    ingredients.clear();
    turnIdle();
  }
}
