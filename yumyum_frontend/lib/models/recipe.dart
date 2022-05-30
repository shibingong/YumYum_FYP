import 'package:flutter/foundation.dart';
import 'package:yumyumfyp/models/nutrition.dart';
import 'package:yumyumfyp/models/user.dart';

class Recipe {
  String recipeId;
  String recipeName;
  String recipeDescription;
  List<String> steps;
  List<String> ingredients;
  List<String> types;
  String videoUrl;
  User user;
  String calories;
  String sugar;
  String fiber;
  String sodium;
  String fat;
  String recipeImage;

  Recipe({
    @required this.recipeId,
    @required this.recipeName,
    @required this.recipeDescription,
    @required this.steps,
    @required this.ingredients,
    @required this.types,
    @required this.videoUrl,
    @required this.user,
    @required this.calories,
    @required this.sugar,
    @required this.fiber,
    @required this.sodium,
    @required this.fat,
    @required this.recipeImage,
  });

  Recipe.fromJson(Map<String, dynamic> json)
      : this(
          recipeId: json['_id'],
          recipeName: json['recipeName'],
          recipeDescription: json['recipeDescription'],
          steps: List<String>.from(json['steps']),
          ingredients: List<String>.from(json['ingredients']),
          types: List<String>.from(json['types']),
          videoUrl: json['videoUrl'],
          user: User.fromJson(json['userID']),
          calories: json['nutrition']['calories'],
          sugar: json['nutrition']['sugar'],
          fiber: json['nutrition']['fiber'],
          sodium: json['nutrition']['sodium'],
          fat: json['nutrition']['fat'],
          recipeImage: json['recipeImage'],
        );

  Map<String, dynamic> toJson() => {
        '_id': recipeId,
        'recipeName': recipeName,
        'recipeDescription': recipeDescription,
        'steps': steps,
        'ingredients': ingredients,
        'types': types,
        'videoUrl': videoUrl,
        'userID': user,
        'nutrition.calories': calories,
        'nutrition.sugar': sugar,
        'nutrition.fiber': fiber,
        'nutrition.sodium': sodium,
        'nutrition.fat': fat,
        'recipeImage': recipeImage,
      };
}
