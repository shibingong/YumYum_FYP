import 'package:flutter/foundation.dart';

class Nutrition {
  String sugar;
  String fiber;
  String sodium;
  String fat;
  String calories;
  String cholesterol;
  String protein;
  String carbohydrates;

  Nutrition({
    @required this.sugar,
    @required this.fiber,
    @required this.sodium,
    @required this.fat,
    @required this.calories,
    @required this.cholesterol,
    @required this.protein,
    @required this.carbohydrates
  });

  Nutrition.fromJson(Map<String, dynamic> json)
      : this(
          sugar: json['sugar_g'].toString(),
          fiber: json['fiber_g'].toString(),
          sodium: json['sodium_mg'].toString(),
          fat: json['fat_total_g'].toString(),
          calories: json['calories'].toString(),
          cholesterol: json['cholesterol_mg'].toString(),
          protein: json['protein_g'].toString(),
          carbohydrates: json['carbohydrates_total_g'].toString(),
        );

  Map<String, dynamic> toJson() => {
        'sugar_g': sugar,
        'fiber_g': fiber,
        'sodium_mg': sodium,
        'fat_total_g': fat,
        'calories': calories,
        'cholesterol_mg': cholesterol,
        'protein_g': protein,
        'carbohydrates_total_g': carbohydrates,
      };
}
