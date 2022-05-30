import 'dart:convert';
import 'dart:io';

import 'package:yumyumfyp/models/nutrition.dart';

import '../../app/dependencies.dart';
import '../rest.dart';
import 'nutrition_service.dart';

class NutritionServiceRest implements NutritionService {
  final rest = dependency<RestService>();
  Future<List<Nutrition>> getNutrition(String ingredients) async {
    var jsonResult = await rest.getNutri(ingredients);
    print(jsonResult['items']);
    List<Nutrition> nutritionResult = (jsonResult['items'] as List)
        .map((json) => Nutrition.fromJson(json))
        .toList();
    return nutritionResult;
  }
}
