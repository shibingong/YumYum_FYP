import 'package:flutter/material.dart';
import 'package:yumyumfyp/models/recipe.dart';
import 'package:yumyumfyp/models/user.dart';
import 'package:yumyumfyp/services/recipe/recipe_service.dart';
import 'package:yumyumfyp/services/user/user_service.dart';

import '../../app/dependencies.dart';
import '../viewmodel.dart';

class RecipeDetailsViewModel extends Viewmodel {
  Recipe recipe;
  RecipeService get dataService => dependency();

  RecipeDetailsViewModel();

  void init(Recipe recipe) async {
    this.recipe = recipe;
  }
}
