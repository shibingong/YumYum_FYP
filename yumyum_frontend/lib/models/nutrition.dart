import 'package:flutter/foundation.dart';

class Nutrition {
  String sugar;
  String fiber;
  String sodium;
  String fat;
  String calories;

  Nutrition({
    @required this.sugar,
    @required this.fiber,
    @required this.sodium,
    @required this.fat,
    @required this.calories,
  });

  Nutrition.fromJson(Map<String, dynamic> json)
      : this(
          sugar: json['sugar_g'].toString(),
          fiber: json['fiber_g'].toString(),
          sodium: json['sodium_mg'].toString(),
          fat: json['fat_total_g'].toString(),
          calories: json['calories'].toString(),
        );

  Map<String, dynamic> toJson() => {
        'sugar_g': sugar,
        'fiber_g': fiber,
        'sodium_mg': sodium,
        'fat_total_g': fat,
        'calories': calories,
      };
}
