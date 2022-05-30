import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:yumyumfyp/models/feedback.dart';
import 'package:yumyumfyp/models/nutrition.dart';
import 'package:yumyumfyp/models/recipe.dart';
import 'package:yumyumfyp/services/feedback/feedback_service.dart';
import 'package:yumyumfyp/services/nutrition/nutrition_service.dart';
import 'package:yumyumfyp/services/recipe/recipe_service.dart';

import '../../app/dependencies.dart';
import '../viewmodel.dart';

String rating;
String comment;
String recipeID;

class AddRecipeFeedbackViewModel extends Viewmodel {
  TextEditingController ratingController;
  TextEditingController commentController;
  GlobalKey<FormState> formKey;

  FeedbackService get dataService => dependency();

  AddRecipeFeedbackViewModel();

  void init(Recipe recipe) async {
    recipeID = recipe.recipeId;
    // print(recipeID);
    ratingController = TextEditingController();
    commentController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  void setRating(double tempRating) {
    rating = tempRating.toString();
  }

  Future<void> addFeedback(context) async {
    turnBusy();
    comment = commentController.text;
    final Feedbacks newFeedback =
        await dataService.addFeedback(recipeID, comment, rating);
    if (newFeedback != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback Added Successsfully!')));
      Navigator.of(context).pop(newFeedback);
    }
    turnIdle();
  }
}
