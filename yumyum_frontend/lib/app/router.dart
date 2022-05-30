import 'package:flutter/material.dart';
import 'package:yumyumfyp/screens/add_recipe/add_recipe_view.dart';
import 'package:yumyumfyp/screens/add_recipe_feedback/add_recipe_feedback_view.dart';
import 'package:yumyumfyp/screens/edit_profile/edit_profile_view.dart';
import 'package:yumyumfyp/screens/edit_recipe/edit_recipe_view.dart';
import 'package:yumyumfyp/screens/home/home_view.dart';
import 'package:yumyumfyp/screens/login/login_view.dart';
import 'package:yumyumfyp/screens/main/main_view.dart';
import 'package:yumyumfyp/screens/my_profile/my_profile_view.dart';
import 'package:yumyumfyp/screens/my_recipe/my_recipe_view.dart';
import 'package:yumyumfyp/screens/recipe_details/recipe_details_view.dart';
import 'package:yumyumfyp/screens/registration/registration_view.dart';
import 'package:yumyumfyp/screens/search_recipe/search_recipe_view.dart';
import 'package:yumyumfyp/screens/view_recipe_feedback/view_recipe_feedback_view.dart';

import '../auth_wrapper.dart';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {
    case '/':
      return AuthWrapper.createRoute();

    case LoginScreen.routeName:
      return LoginScreen.createRoute();

    case RegistrationScreen.routeName:
      return RegistrationScreen.createRoute(settings.arguments);

    case MainScreen.routeName:
      return MainScreen.createRoute();

    case HomeScreen.routeName:
      return HomeScreen.createRoute(settings.arguments);

    case MyRecipeScreen.routeName:
      return MyRecipeScreen.createRoute(settings.arguments);

    case AddRecipeScreen.routeName:
      return AddRecipeScreen.createRoute(settings.arguments);

    case MyProfileScreen.routeName:
      return MyProfileScreen.createRoute();

    case EditProfileScreen.routeName:
      return EditProfileScreen.createRoute();

    case RecipeDetailsScreen.routeName:
      return RecipeDetailsScreen.createRoute(settings.arguments);

    case SearchRecipeScreen.routeName:
      return SearchRecipeScreen.createRoute(settings.arguments);

    case ViewRecipeFeedbackScreen.routeName:
      return ViewRecipeFeedbackScreen.createRoute(settings.arguments);

    case AddRecipeFeedbackScreen.routeName:
      return AddRecipeFeedbackScreen.createRoute(settings.arguments);

    case EditRecipeScreen.routeName:
      return EditRecipeScreen.createRoute(settings.arguments);
  }
  return null;
}
