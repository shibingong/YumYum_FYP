import 'dart:io';

import 'package:yumyumfyp/models/nutrition.dart';
import 'package:yumyumfyp/services/nutrition/nutrition_service.dart';

import '../../app/auth.dart';
import '../../app/dependencies.dart';
import '../../models/user.dart';
import '../../services/user/user_service.dart';
import '../viewmodel.dart';

class MainViewModel extends Viewmodel {
  UserService get dataService => dependency();
  AuthService get authService => dependency();
  NutritionService get nutriService => dependency();
  User user;
  List<Nutrition> nutrition = [];
  double totalCalories;

  MainViewModel();

  Future<void> init() async {
    await getUser();
    // await getNutrition("beef, tomato");
  }

  Future<void> getUser() async {
    turnBusy();
    user = await dataService.getUser();
    turnIdle();
  }

  Future<void> getNutrition(String ingredients) async {
    turnBusy();
    totalCalories = 0;
    nutrition = await nutriService.getNutrition(ingredients);
    nutrition.forEach((element) {
      totalCalories += double.parse(element.calories);
    });
    print("total calories =>" + totalCalories.toStringAsFixed(2));
    turnIdle();
  }

  void logOut() {
    authService.triggerLogOut();
  }
}
