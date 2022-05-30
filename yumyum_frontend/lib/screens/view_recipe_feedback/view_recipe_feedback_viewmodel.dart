import 'package:flutter/material.dart';
import 'package:yumyumfyp/models/feedback.dart';
import 'package:yumyumfyp/models/recipe.dart';
import 'package:yumyumfyp/models/user.dart';
import 'package:yumyumfyp/screens/add_recipe_feedback/add_recipe_feedback_view.dart';
import 'package:yumyumfyp/services/feedback/feedback_service.dart';
import 'package:yumyumfyp/services/user/user_service.dart';

import '../../app/dependencies.dart';
import '../viewmodel.dart';

class ViewRecipeFeedbackViewModel extends Viewmodel {
  double averageRating;
  bool showFloatingButton;
  User user;
  Recipe recipe;
  List<Feedbacks> feedbacks = [];
  ViewRecipeFeedbackViewModel();
  UserService get userService => dependency();
  FeedbackService get dataService => dependency();

  Future<void> getList(Recipe recipe) async {
    turnBusy();
    user = await userService.getUser();
    feedbacks = await dataService.getFeedbackList(recipe.recipeId);
    feedbacks.length != 0
        ? averageRating = feedbacks
                .map((m) => double.parse(m.rating))
                .reduce((a, b) => a + b) /
            feedbacks.length
        : averageRating = 0;
    showFloatingButton = displayFloatingButton(feedbacks, recipe);
    turnIdle();
  }

  bool displayFloatingButton(List<Feedbacks> feedbacks, Recipe recipe) {
    bool temp = true;
    if (recipe.user.userId == user.userId) {
      temp = false;
    }
    for (int i = 0; i < feedbacks.length; i++) {
      if (feedbacks[i].user.userId == user.userId) {
        temp = false;
        break;
      }
    }
    return temp;
  }

  void onPressFloatButton(context, recipe) async {
    var newFeedback = (await Navigator.of(context).pushNamed(
        AddRecipeFeedbackScreen.routeName,
        arguments: {'recipe': recipe}));
    if (newFeedback != null) {
      feedbacks.add(newFeedback);
      averageRating =
          feedbacks.map((m) => double.parse(m.rating)).reduce((a, b) => a + b) /
              feedbacks.length;
      showFloatingButton = false;
    }
    turnIdle();
  }
}
