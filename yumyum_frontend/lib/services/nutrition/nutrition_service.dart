import 'dart:io';

import '../../models/nutrition.dart';

abstract class NutritionService {
  Future<List<Nutrition>> getNutrition(String ingredients);
}
